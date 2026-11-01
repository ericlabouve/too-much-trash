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
            "assets": [{"name": "release.json"}]}


class VersionSelectionTests(unittest.TestCase):
    def test_first_version_ignores_legacy_sha_releases(self):
        self.assertEqual(publisher.choose_tag([], COMMIT), "0.1.0")
        self.assertEqual(publisher.choose_tag([item("backend-" + COMMIT)], COMMIT), "0.1.0")

    def test_minor_increment_is_numeric_and_resets_patch(self):
        self.assertEqual(publisher.choose_tag([item("0.9.0"), item("0.10.7")], COMMIT), "0.11.0")

    def test_manual_major_release_resets_minor_line(self):
        for tag in ("1.0.0", "v1.0.0"):
            self.assertEqual(publisher.choose_tag([item("0.99.0"), item(tag)], COMMIT), "1.1.0")
        self.assertEqual(publisher.choose_tag([item("1.1.0"), item("1.2.0")], COMMIT), "1.3.0")

    def test_older_release_published_later_never_downgrades(self):
        self.assertEqual(publisher.choose_tag([item("2.0.0"), item("0.8.0")], COMMIT), "2.1.0")

    def test_drafts_prereleases_and_non_semver_do_not_advance_baseline(self):
        releases = [item("0.2.0"), item("9.0.0", draft=True), item("8.0.0", prerelease=True),
                    item("7.0.0-rc.1"), item("06.0.0"), item("latest")]
        self.assertEqual(publisher.choose_tag(releases, COMMIT), "0.3.0")

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

    def test_new_release_publishes_only_after_verified_asset_upload(self):
        draft = item("0.1.0", owned=True, draft=True)
        draft["assets"] = []
        events = []
        with tempfile.TemporaryDirectory() as directory:
            path = self.manifest(directory)
            def gh(*args):
                events.append(args)
                if args[0] == "api":
                    if "--paginate" in args:
                        created = any(e[:2] == ("release", "create") for e in events)
                        return json.dumps([[draft]]) if created else "[[],[]]"
                    if "/git/refs" in args[1]:
                        return json.dumps({"object": {"type": "commit", "sha": COMMIT}})
                    self.fail("Unexpected GitHub API request")
                if args[:2] == ("release", "download"):
                    (Path(args[args.index("--dir") + 1]) / "release.json").write_bytes(path.read_bytes())
                return ""
            with patch.object(publisher, "gh", side_effect=gh):
                self.assertEqual(publisher.publish(path), "0.1.0")
        operations = [event[1] for event in events if event[0] == "release"]
        self.assertEqual(operations, ["create", "upload", "download", "edit"])
        created = next(event for event in events if event[:2] == ("release", "create"))
        self.assertIn("--draft", created)
        self.assertEqual(created[created.index("--title") + 1], "0.1.0")
        self.assertEqual(created[created.index("--target") + 1], COMMIT)

    def test_published_retry_only_verifies_and_never_mutates(self):
        existing = item("0.2.0", owned=True)
        with tempfile.TemporaryDirectory() as directory:
            path = self.manifest(directory)
            with patch.object(publisher, "api", side_effect=[[[existing]], [[existing]]]), \
                 patch.object(publisher, "ensure_tag") as ensure, \
                 patch.object(publisher, "verify_asset") as verify, \
                 patch.object(publisher, "gh") as gh:
                self.assertEqual(publisher.publish(path), "0.2.0")
            ensure.assert_called_once_with("0.2.0", COMMIT, True)
            verify.assert_called_once_with("0.2.0", path)
            gh.assert_not_called()

    def test_interrupted_draft_can_resume_without_allocating_version(self):
        draft = item("0.1.0", owned=True, draft=True)
        with tempfile.TemporaryDirectory() as directory:
            path = self.manifest(directory)
            with patch.object(publisher, "api", side_effect=[[[draft]], [[draft]]]), \
                 patch.object(publisher, "ensure_tag"), patch.object(publisher, "verify_asset"), \
                 patch.object(publisher, "gh") as gh:
                self.assertEqual(publisher.publish(path), "0.1.0")
            gh.assert_called_once_with("release", "edit", "0.1.0", "--repo", publisher.REPOSITORY,
                                       "--draft=false")

    def test_version_baseline_reads_all_pages(self):
        with patch.object(publisher, "api", return_value=[[item("0.5.0")], [item("v1.0.0")]]):
            self.assertEqual(publisher.choose_tag(publisher.list_releases(), COMMIT), "1.1.0")

    def test_retry_uses_tag_identity_not_descriptive_branch_field(self):
        existing = item("0.1.0", owned=True)
        existing["target_commitish"] = "main"
        self.assertEqual(publisher.choose_tag([existing], COMMIT), "0.1.0")

    def test_manifest_mismatch_never_publishes_or_overwrites(self):
        draft = item("0.1.0", owned=True, draft=True)
        with tempfile.TemporaryDirectory() as directory:
            path = self.manifest(directory)
            with patch.object(publisher, "api", side_effect=[[[draft]], [[draft]]]), \
                 patch.object(publisher, "ensure_tag"), \
                 patch.object(publisher, "verify_asset", side_effect=ValueError("mismatch")), \
                 patch.object(publisher, "gh") as gh, self.assertRaises(ValueError):
                publisher.publish(path)
            gh.assert_not_called()

    def test_published_missing_asset_fails_closed(self):
        existing = item("0.1.0", owned=True)
        existing["assets"] = []
        with tempfile.TemporaryDirectory() as directory:
            path = self.manifest(directory)
            with patch.object(publisher, "api", side_effect=[[[existing]], [[existing]]]), \
                 patch.object(publisher, "ensure_tag"), patch.object(publisher, "gh") as gh, \
                 self.assertRaises(ValueError):
                publisher.publish(path)
            gh.assert_not_called()

    def test_asset_verifier_compares_actual_bytes(self):
        with tempfile.TemporaryDirectory() as directory:
            path = self.manifest(directory)
            for body in (path.read_bytes(), b"different manifest"):
                def gh(*args):
                    (Path(args[args.index("--dir") + 1]) / "release.json").write_bytes(body)
                with patch.object(publisher, "gh", side_effect=gh):
                    if body == path.read_bytes():
                        publisher.verify_asset("0.1.0", path)
                    else:
                        with self.assertRaises(ValueError):
                            publisher.verify_asset("0.1.0", path)

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


if __name__ == "__main__":
    unittest.main()
