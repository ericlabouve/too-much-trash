"""Version publication tests mock GitHub; never create real tags or releases."""
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

CD = Path(__file__).resolve().parents[2] / "ops/cd"
sys.path.insert(0, str(CD))
import publish_release as publisher

COMMIT = "a" * 40


def item(tag, *, draft=False, prerelease=False, owned=False):
    return {"tag_name": tag, "name": tag, "draft": draft, "prerelease": prerelease,
            "target_commitish": COMMIT, "body": publisher.marker(COMMIT) if owned else "",
            "assets": [{"name": name} for name in ("release.json", *publisher.CAD_ASSETS)]}


class VersionSelectionTests(unittest.TestCase):
    def test_first_version_ignores_legacy_sha_releases(self):
        self.assertEqual(publisher.choose_tag([], COMMIT), "0.1.0")
        self.assertEqual(publisher.choose_tag([item("backend-" + COMMIT)], COMMIT), "0.1.0")

    def test_patch_increment_is_numeric(self):
        self.assertEqual(publisher.choose_tag([item("0.9.0"), item("0.10.7")], COMMIT), "0.10.8")

    def test_manual_major_release_resets_minor_line(self):
        for tag in ("1.0.0", "v1.0.0"):
            self.assertEqual(publisher.choose_tag([item("0.99.0"), item(tag)], COMMIT), "1.0.1")
        self.assertEqual(publisher.choose_tag([item("1.0.1"), item("1.2.0")], COMMIT), "1.2.1")

    def test_older_release_published_later_never_downgrades(self):
        self.assertEqual(publisher.choose_tag([item("2.0.0"), item("0.8.0")], COMMIT), "2.0.1")

    def test_drafts_prereleases_and_non_semver_do_not_advance_baseline(self):
        releases = [item("0.2.0"), item("9.0.0", draft=True), item("8.0.0", prerelease=True),
                    item("7.0.0-rc.1"), item("06.0.0"), item("latest")]
        self.assertEqual(publisher.choose_tag(releases, COMMIT), "0.2.1")

    def test_retry_reuses_original_version_even_after_manual_major(self):
        for draft in (False, True):
            releases = [item("0.2.0", owned=True, draft=draft), item("1.0.0")]
            self.assertEqual(publisher.choose_tag(releases, COMMIT), "0.2.0")

    def test_unrelated_reserved_version_is_not_overwritten(self):
        for tag in ("0.1.0", "v0.1.0"):
            with self.assertRaises(ValueError):
                publisher.choose_tag([item(tag, draft=True)], COMMIT)

    def test_owned_release_must_have_consistent_identity(self):
        existing = item("0.1.0", owned=True)
        existing["prerelease"] = True
        with self.assertRaises(ValueError):
            publisher.choose_tag([existing], COMMIT)
        with self.assertRaises(ValueError):
            publisher.choose_tag([item("0.1.0", owned=True), item("0.2.0", owned=True)], COMMIT)


class PublicationTests(unittest.TestCase):
    def test_new_draft_eventually_appears_in_release_list(self):
        draft = item("0.1.0", owned=True, draft=True)
        with patch.object(publisher, "list_releases", side_effect=[[], [], [draft]]) as listing, \
             patch.object(publisher.time, "sleep") as sleep:
            self.assertEqual(publisher.find_release("0.1.0"), draft)
        self.assertEqual(listing.call_count, 3)
        self.assertEqual(sleep.call_count, 2)

    def test_missing_draft_stops_after_bounded_wait(self):
        with patch.object(publisher, "list_releases", return_value=[]) as listing, \
             patch.object(publisher.time, "sleep"), self.assertRaises(ValueError):
            publisher.find_release("0.1.0")
        self.assertEqual(listing.call_count, 10)

    def manifest(self, directory):
        path = Path(directory) / "release.json"
        path.write_text(json.dumps({"version": 1, "commit": COMMIT, "images": {
            name: "ghcr.io/ericlabouve/too-much-trash-" + name + "@sha256:" + "b" * 64
            for name in ("api", "worker", "caddy")}}))
        return path

    def bundle(self, directory):
        root = Path(directory) / "cad"
        root.mkdir()
        for name in publisher.CAD_ASSETS:
            (root / name).write_bytes(("content " + name).encode())
        return root

    def test_new_draft_uploads_and_verifies_every_asset_before_publication(self):
        draft = item("0.1.0", owned=True, draft=True)
        draft["assets"] = []
        with tempfile.TemporaryDirectory() as directory:
            path, bundle = self.manifest(directory), self.bundle(directory)
            with patch.object(publisher, "list_releases", return_value=[]), \
                 patch.object(publisher, "find_release", return_value=draft), \
                 patch.object(publisher, "ensure_tag"), \
                 patch.object(publisher, "verify_asset") as verify, \
                 patch.object(publisher, "gh") as gh:
                self.assertEqual(publisher.publish(path, bundle), "0.1.0")
        calls = gh.call_args_list
        self.assertEqual([c.args[1] for c in calls], ["create"] + ["upload"] * 7 + ["edit"])
        self.assertEqual({c.args[1].name for c in verify.call_args_list}, {"release.json", *publisher.CAD_ASSETS})
        edit = calls[-1].args
        self.assertIn("--draft=false", edit)
        self.assertIn("<details>\n<summary>CAD print plate previews</summary>", edit[edit.index("--notes") + 1])
        self.assertIn("</details>", edit[edit.index("--notes") + 1])
        self.assertIn("PETG.png", edit[edit.index("--notes") + 1])
        self.assertIn("TPU.png", edit[edit.index("--notes") + 1])

    def test_interrupted_draft_uploads_only_missing_assets(self):
        draft = item("0.1.0", owned=True, draft=True)
        draft["assets"] = [{"name": "release.json"}, {"name": "PETG.3mf"}]
        with tempfile.TemporaryDirectory() as directory:
            path, bundle = self.manifest(directory), self.bundle(directory)
            with patch.object(publisher, "list_releases", return_value=[draft]), \
                 patch.object(publisher, "find_release", return_value=draft), \
                 patch.object(publisher, "ensure_tag"), \
                 patch.object(publisher, "verify_asset") as verify, \
                 patch.object(publisher, "gh") as gh:
                self.assertEqual(publisher.publish(path, bundle), "0.1.0")
            self.assertEqual(verify.call_count, 7)
            uploads = [c.args for c in gh.call_args_list if c.args[:2] == ("release", "upload")]
            self.assertEqual({Path(c[3]).name for c in uploads}, set(publisher.CAD_ASSETS) - {"PETG.3mf"})

    def test_retry_verifies_all_assets_and_does_not_mutate_published_release(self):
        existing = item("0.2.0", owned=True)
        existing["body"] = publisher.update_body(existing["body"], publisher.REPOSITORY, "0.2.0")
        with tempfile.TemporaryDirectory() as directory:
            path, bundle = self.manifest(directory), self.bundle(directory)
            with patch.object(publisher, "list_releases", return_value=[existing]), \
                 patch.object(publisher, "find_release", return_value=existing), \
                 patch.object(publisher, "ensure_tag"), \
                 patch.object(publisher, "verify_asset") as verify, \
                 patch.object(publisher, "gh") as gh:
                self.assertEqual(publisher.publish(path, bundle), "0.2.0")
            self.assertEqual(verify.call_count, 7)
            gh.assert_not_called()

    def test_mismatched_asset_never_overwrites_or_publishes(self):
        draft = item("0.1.0", owned=True, draft=True)
        with tempfile.TemporaryDirectory() as directory:
            path, bundle = self.manifest(directory), self.bundle(directory)
            with patch.object(publisher, "list_releases", return_value=[draft]), \
                 patch.object(publisher, "find_release", return_value=draft), \
                 patch.object(publisher, "ensure_tag"), \
                 patch.object(publisher, "verify_asset", side_effect=ValueError("mismatch")), \
                 patch.object(publisher, "gh") as gh, self.assertRaises(ValueError):
                publisher.publish(path, bundle)
            gh.assert_not_called()

    def test_published_missing_asset_fails_closed(self):
        existing = item("0.1.0", owned=True)
        existing["assets"] = []
        with tempfile.TemporaryDirectory() as directory:
            path, bundle = self.manifest(directory), self.bundle(directory)
            with patch.object(publisher, "list_releases", return_value=[existing]), \
                 patch.object(publisher, "find_release", return_value=existing), \
                 patch.object(publisher, "ensure_tag"), patch.object(publisher, "gh") as gh, \
                 self.assertRaises(ValueError):
                publisher.publish(path, bundle)
            gh.assert_not_called()

    def test_each_asset_verifier_compares_actual_bytes(self):
        with tempfile.TemporaryDirectory() as directory:
            path, bundle = self.manifest(directory), self.bundle(directory)
            for asset in [path, *(bundle / name for name in publisher.CAD_ASSETS)]:
                for body in (asset.read_bytes(), b"different"):
                    def gh(*args):
                        (Path(args[args.index("--dir") + 1]) / asset.name).write_bytes(body)
                    with patch.object(publisher, "gh", side_effect=gh):
                        if body == asset.read_bytes():
                            publisher.verify_asset("0.1.0", asset)
                        else:
                            with self.assertRaises(ValueError):
                                publisher.verify_asset("0.1.0", asset)

    def test_bundle_requires_exact_nonempty_assets(self):
        with tempfile.TemporaryDirectory() as directory:
            path, bundle = self.manifest(directory), self.bundle(directory)
            (bundle / "PETG.png").unlink()
            with self.assertRaises(ValueError):
                publisher.publish(path, bundle)
            (bundle / "PETG.png").write_bytes(b"")
            with self.assertRaises(ValueError):
                publisher.publish(path, bundle)

    def test_version_baseline_reads_all_pages(self):
        with patch.object(publisher, "api", return_value=[[item("0.5.0")], [item("v1.0.0")]]):
            self.assertEqual(publisher.choose_tag(publisher.list_releases(), COMMIT), "1.0.1")

    def test_retry_uses_tag_identity_not_descriptive_branch_field(self):
        existing = item("0.1.0", owned=True)
        existing["target_commitish"] = "main"
        self.assertEqual(publisher.choose_tag([existing], COMMIT), "0.1.0")

    def test_existing_tag_cannot_be_moved_to_another_commit(self):
        conflict = {"object": {"type": "commit", "sha": "b" * 40}}
        failed_create = subprocess.CalledProcessError(1, ["gh", "api"])
        with patch.object(publisher, "api", side_effect=[failed_create, conflict]) as api, \
             self.assertRaises(ValueError):
            publisher.ensure_tag("0.1.0", COMMIT, False)
        self.assertEqual(api.call_count, 2)

    def test_orphaned_matching_tag_is_reused_not_retagged(self):
        ref = {"object": {"type": "commit", "sha": COMMIT}}
        failed_create = subprocess.CalledProcessError(1, ["gh", "api"])
        with patch.object(publisher, "api", side_effect=[failed_create, ref]) as api:
            publisher.ensure_tag("0.1.0", COMMIT, False)
        self.assertEqual(api.call_count, 2)


class WorkflowRoutingTests(unittest.TestCase):
    def test_only_main_cd_publishes_and_waits_for_both_builds(self):
        root = CD.parents[2]
        cd = (root / ".github/workflows/backend-cd.yaml").read_text()
        cad = (root / ".github/workflows/cad-release.yml").read_text()
        self.assertIn("  push:\n    branches: [main]", cd)
        self.assertIn("  cad:\n    uses: ./.github/workflows/cad-release.yml", cd)
        self.assertIn("    needs: [build, cad]", cd)
        self.assertIn("github.ref == 'refs/heads/main'", cd)
        self.assertIn("id-token: write", cd)
        self.assertIn("publish_release.py release.json release-assets", cd)
        self.assertIn("  workflow_call:", cad)
        self.assertIn("  pull_request:", cad)
        self.assertNotIn("  release:", cad)
        self.assertNotIn("  workflow_dispatch:", cad)
        self.assertNotIn("contents: write", cad)
        self.assertNotIn("gh release", cad)


if __name__ == "__main__":
    unittest.main()
