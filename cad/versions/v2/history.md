# V2 design history

Only current Version 1 and Version 2 appear in the viewer. Older V2 renditions are stored in Git rather than duplicated in the working tree.

Snapshot commit: `f8f11822459f5e140ed34d06caa46a720999467c` (before archive removal). It contains dedicated-r1, raised-r2, recessed-r3, reinforced-r4, knot-access-r5, tie-eye-r6, thread-8x3-r7, closed-clamp-r8, screen-clear-r9 and extended-saddle-r10 under `cad/versions/v2/archive/`. The old camera-clearance study is also preserved there in `cad/versions/v2/studies/`.

Inspect an earlier source file:

```sh
git show f8f11822459f5e140ed34d06caa46a720999467c:cad/versions/v2/archive/extended-saddle-r10/source/model.py
```

For the historical viewers and files, open a separate detached worktree rather than replacing current work:

```sh
git worktree add --detach /tmp/too-much-trash-history f8f11822459f5e140ed34d06caa46a720999467c
```

Then serve that worktree's `cad` directory on an unused port. Future revisions should use focused commits, not new archive directories. Existing small fit/thread trial records remain as experimental evidence. The active clamp comparison check loads its r7 baseline directly from this pinned commit; retain this history when cloning (a shallow checkout needs the checkpoint commit fetched).

Current r11: four collar screw/nut stations, opposed lower pair and offset upper pair. Build checks pass for eight phone/side configurations; near-side service and cap-removal checks pass. The end-oriented r10 coupon's sizing passed physically, but its single-fastener closure produced a V gap. The new two-fastener coupon is prepared, not printed.
