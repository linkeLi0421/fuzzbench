# Original Crash Collection: ghostscript gstoraster_fuzzer

Generated: 2026-04-24 UTC

Benchmark: `ghostscript_transplant_gstoraster_fuzzer`
Project: `ghostscript`
Fuzzer: `gstoraster_fuzzer`
Sanitizer: `address`

Target source commit: `2be8b436910cfc8b013a13df000c3c854cf3c5c5` (2021-12-14)
Target OSS-Fuzz commit: `7490e8a466e40c3ac4c092a26f737c5276c4a860` (from `/home/user/log/ghostscript_builds.csv`)
Target-era base-runner: `gcr.io/oss-fuzz-base/base-runner@sha256:83dc2104f6325551cf7b2dd928b63a3545bd283d00c3179827dcd963cff7764b`

## Semantics

Each `OSV-*.txt` is a crash on the pristine, un-transplanted source tree:

- **Local bugs** (already triggering at the target commit) are replayed against
  the `-address` prebuilt binary at `ghostscript-2be8b436910c...-address/gstoraster_fuzzer`
  using the target-era base-runner.
- **Migration bugs** come from `/mnt/nas/linke/new_migrate/ghostscript/gstoraster_fuzzer/crash/`,
  captured per-bug by the migration pipeline (`fuzz_helper.py collect_crash
  --runner-image auto`) which era-matches the runner image per source commit.
  When a migration crash file had no ASAN error (broken `collect_crash` capture — e.g. binary-missing), the fallback was `bug_transplant/<project>_<bug>/transplant_crash.txt`
  captured during the transplant agent's verification step.

## Bug → source commit / OSS-Fuzz commit

| Bug | Kind | Source commit | OSS-Fuzz commit |
| --- | --- | --- | --- |
| OSV-2020-1875 | migration | `ad317d8d436f` | `da9cbde065a6` |
| OSV-2021-1681 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1682 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1683 | migration | `991a95ff4c4f` | `7490e8a466e4` |
| OSV-2021-1684 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1685 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1686 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1687 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1688 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1689 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1690 | migration | `991a95ff4c4f` | `7490e8a466e4` |
| OSV-2021-1692 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1693 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1694 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1697 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1698 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1703 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1704 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1706 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1707 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1709 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1711 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1715 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1717 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1719 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1723 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1724 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1731 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1740 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1741 | migration | `d066f5000d9a` | `ad1ecf0c592d` |
| OSV-2021-1743 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1752 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1753 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1754 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1763 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1764 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1767 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1770 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1771 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1772 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1774 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1781 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1788 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1795 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1802 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1803 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-1806 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2021-237 | migration | `7a469b14c884` | `d108b02e950a` |
| OSV-2021-337 | migration | `7a469b14c884` | `d108b02e950a` |
| OSV-2021-668 | migration | `edd20b3b8c3c` | `c2abaa0bd34f` |
| OSV-2021-717 | migration | `d859bc3a556d` | `4442574e302a` |
| OSV-2021-803 | migration | `1419607dd606` | `f8d0ee3c89b8` |
| OSV-2022-1 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-100 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-102 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-121 | migration | `a16d4303a172` | `4261d526ad02` |
| OSV-2022-177 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-18 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-199 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-206 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-210 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-218 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-229 | migration | `ed4ea44d3a6e` | `10fdf2878d52` |
| OSV-2022-232 | migration | `61e2de99c2d4` | `4d723ba45142` |
| OSV-2022-270 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-271 | migration | `3aac4c1d09c3` | `7dd39a677caf` |
| OSV-2022-278 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-3 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-301 | migration | `31ccc0f92038` | `3291b708db4f` |
| OSV-2022-339 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-351 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-390 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-415 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-417 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-422 | migration | `1b5c3c953c69` | `3ce6a5816906` |
| OSV-2022-429 | migration | `3c317be3539c` | `d1e407f0f335` |
| OSV-2022-449 | migration | `c519bbf479cf` | `beb98b4d1a3b` |
| OSV-2022-453 | local* | `13dd78221346` | `7bcd9edc3608` |
| OSV-2022-456 | migration | `c519bbf479cf` | `beb98b4d1a3b` |
| OSV-2022-47 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-496 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-53 | migration | `9c4eb789379c` | `f72ca0fd0938` |
| OSV-2022-54 | migration | `f4f1797aabba` | `55e0764b3308` |
| OSV-2022-684 | migration | `db0f222fd72d` | `b5c6cd48c0f6` |
| OSV-2022-79 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-81 | migration | `6fde1cf8be08` | `9b03e118c244` |
| OSV-2022-83 | local | `2be8b436910c` | `7490e8a466e4` |
| OSV-2022-85 | migration | `6fde1cf8be08` | `9b03e118c244` |
| OSV-2022-97 | local | `2be8b436910c` | `7490e8a466e4` |

*`OSV-2022-453` was flagged as 'already triggering at target' by the migration
pipeline, but its OSV-reported `introduced` commit (`e4fef6cf`, 2022-05-31) is
actually **after** the benchmark target (2021-12-14). The buggy code is not
present at target; the crash was captured at the first in-range CSV-mapped commit
`13dd7822` (2022-06-XX) instead.

## ASAN options note

Three local bugs (`OSV-2021-1693`, `OSV-2021-1706`, `OSV-2022-453`) are sensitive
to ASAN's `detect_stack_use_after_return=1` flag which the other benchmarks in this
repo set by default. With it enabled, ASAN's stack-rewrite layout masks the bug
and the process exits cleanly. These three logs were captured with the plainer
`ASAN_OPTIONS=abort_on_error=1:symbolize=1:detect_leaks=0` to surface the crash.

## Re-run command (migration bugs)

```bash
BUILD_CSV='/home/user/oss-fuzz-build/fuzzbench/benchmarks/ghostscript_transplant_gstoraster_fuzzer/original-crashes/collect_crash_builds.csv'
OUT_DIR='/home/user/oss-fuzz-build/fuzzbench/benchmarks/ghostscript_transplant_gstoraster_fuzzer/original-crashes'

while IFS=$'\t' read -r bug commit; do
  [ "$bug" = "bug" ] && continue
  ts=$(git -C /home/user/tasks-git/ghostscript log -1 --format=%ct "$commit")
  /home/user/pyenv/venv/bin/python3 /home/user/oss-fuzz-for-select/script/fuzz_helper.py collect_crash \
    --commit "$commit" \
    --build_csv "$BUILD_CSV" \
    --testcases /home/user/oss-fuzz-for-select/pocs/tmp \
    --test_input "testcase-${bug}" \
    --runner-image auto --commit-date "$ts" \
    ghostscript gstoraster_fuzzer
  cp "/home/user/oss-fuzz-build/data/crash/target_crash-${commit:0:6}-testcase-${bug}.txt" "${OUT_DIR}/${bug}.txt"
done <<'JOBS'
bug	commit
OSV-2020-1875	ad317d8d436f3ae282597631464313666451747f
OSV-2021-1683	991a95ff4c4ffd6114f0ae5b9ecb7887ba775d50
OSV-2021-1690	991a95ff4c4ffd6114f0ae5b9ecb7887ba775d50
OSV-2021-1741	d066f5000d9a959708838c0ee471ffeb84d00bfc
OSV-2021-237	7a469b14c88409b96614e6b8abe2b645078ded3a
OSV-2021-337	7a469b14c88409b96614e6b8abe2b645078ded3a
OSV-2021-668	edd20b3b8c3c1a7117dd5dbee0b54cd1de7838bf
OSV-2021-717	d859bc3a556d76adeff89a00fa7b41f308bda88c
OSV-2021-803	1419607dd606ac6bc6850308621d0bd275bddac2
OSV-2022-121	a16d4303a172eb1f4f0e6c0133a728fe5f78c07e
OSV-2022-229	ed4ea44d3a6e0f705fa055a81beef964a1b1cfea
OSV-2022-232	61e2de99c2d465abf3dec54180da20e4659c42e7
OSV-2022-271	3aac4c1d09c3b0772727609cac0242905e45ceea
OSV-2022-301	31ccc0f920386b3f3cf42040f82aa8ed74b10c92
OSV-2022-422	1b5c3c953c69837889ecca694097eccacfdcb567
OSV-2022-429	3c317be3539c6fe9920b4065612a9d209a8ea872
OSV-2022-449	c519bbf479cfd22ef57cd486470f5031137539e8
OSV-2022-456	c519bbf479cfd22ef57cd486470f5031137539e8
OSV-2022-53	9c4eb789379cfd0902a4e4981d101d11fc7b01a4
OSV-2022-54	f4f1797aabba7c931903eacbd78003d006770c7d
OSV-2022-684	db0f222fd72d3038aad3a32427603f05a76600e2
OSV-2022-81	6fde1cf8be088fbe074c97eac334c6a539b0e380
OSV-2022-85	6fde1cf8be088fbe074c97eac334c6a539b0e380
JOBS
```

## Re-run command (local bugs + OSV-2022-453)

```bash
RUNNER_IMAGE='gcr.io/oss-fuzz-base/base-runner@sha256:83dc2104f6325551cf7b2dd928b63a3545bd283d00c3179827dcd963cff7764b'
OUT_DIR='/home/user/oss-fuzz-build/fuzzbench/benchmarks/ghostscript_transplant_gstoraster_fuzzer/original-crashes'

while IFS=$'\t' read -r bug commit asan_opts; do
  [ "$bug" = "bug" ] && continue
  BIN_DIR="/mnt/nas/linke/ghostscript/ghostscript-${commit}-address"
  TMPD=$(mktemp -d)
  cp /home/user/oss-fuzz-for-select/pocs/tmp/testcase-${bug} "$TMPD/"
  docker run --rm --platform linux/amd64 --shm-size=2g \
    -v "$BIN_DIR":/out:ro -v "$TMPD":/corpus:ro \
    -e ASAN_OPTIONS="$asan_opts" \
    "$RUNNER_IMAGE" \
    /out/gstoraster_fuzzer "/corpus/testcase-${bug}" -rss_limit_mb=8192 -runs=10 \
    > "${OUT_DIR}/${bug}.txt" 2>&1
  rm -rf "$TMPD"
done <<'JOBS'
bug	commit	asan_opts
OSV-2021-1681	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1682	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1684	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1685	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1686	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1687	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1688	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1689	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1692	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1693	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0
OSV-2021-1694	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1697	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1698	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1703	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1704	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1706	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0
OSV-2021-1707	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1709	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1711	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1715	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1717	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1719	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1723	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1724	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1731	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1740	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1743	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1752	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1753	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1754	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1763	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1764	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1767	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1770	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1771	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1772	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1774	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1781	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1788	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1795	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1802	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1803	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2021-1806	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-1	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-100	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-102	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-177	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-18	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-199	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-206	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-210	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-218	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-270	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-278	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-3	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-339	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-351	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-390	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-415	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-417	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-453	13dd78221346a098445c4c8ab3f68d2f44651be2	abort_on_error=1:symbolize=1:detect_leaks=0
OSV-2022-47	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-496	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-79	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-83	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
OSV-2022-97	2be8b436910cfc8b013a13df000c3c854cf3c5c5	abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1
JOBS
```

