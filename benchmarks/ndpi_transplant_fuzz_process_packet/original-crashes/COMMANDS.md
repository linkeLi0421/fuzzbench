# Original Crash Collection: ndpi fuzz_process_packet

Generated: 2026-04-24 UTC

Benchmark: `ndpi_transplant_fuzz_process_packet`
Project: `ndpi`
Fuzzer: `fuzz_process_packet`
Sanitizer: `address`

Target source commit: `e695dd6eade754b2d50bdf297ca8bdc4105f93ff` (2019-11-03)
Target-era base-runner: `gcr.io/oss-fuzz-base/base-runner@sha256:caba4ce727f6dfe43a68b4554efdd617052ad3b634bbc6e28b97f6e3ca1a92ac` (2019-12, from `get_base_runner_for_date()`)

## Semantics

Each `OSV-*.txt` is a crash on the pristine source tree:
- **Local bugs** (already triggering at target) replayed against the NAS prebuilt
  `-address` binary at target commit (`e695dd6eade7`) with the target-era base-
  runner. The ndpi `fuzz_process_packet` binary does not link OpenSSL, so the 2019-
  era runner (no `libcrypto.so.1.1`) can load the NAS prebuilt binary without
  needing a fresh rebuild.
- **Migration bugs** come from `/mnt/nas/linke/new_migrate/ndpi/fuzz_process_packet/
  crash/`, captured per-bug at each bug's own buggy source commit by the migration
  pipeline with era-matched runner.

Note: `ndpi_builds.csv` covers half of the migration commits here; rows with
`oss_fuzz_commit=auto` defer to `--runner-image auto --commit-date <ts>` at reproduce
time to pick era-matched images.

## Bug → source commit / OSS-Fuzz commit

| Bug | Kind | Source commit | OSS-Fuzz commit |
| --- | --- | --- | --- |
| OSV-2020-1011 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-1013 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-1015 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-1019 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-1074 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-1112 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-1114 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-1131 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-1133 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-1187 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-1194 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-1233 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-1263 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-1294 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-136 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-154 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-1715 | migration | `bccf1c433a49` | `ffc6af6d1d24` |
| OSV-2020-179 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-194 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-28 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-342 | migration | `32dc9e3225cc` | `81c465662194` |
| OSV-2020-49 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-59 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-774 | migration | `bccf1c433a49` | `ffc6af6d1d24` |
| OSV-2020-78 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-795 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-812 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-918 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-922 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-972 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-992 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2020-994 | local | `e695dd6eade7` | `91d0e0786014` |
| OSV-2022-1032 | migration | `cd76bacd4aa4` | `76d961ba5449` |
| OSV-2022-445 | migration | `b306a4b8edc3` | `auto` |
| OSV-2022-661 | migration | `8402bd68ad95` | `auto` |
| OSV-2022-670 | migration | `ac24b35b1fa3` | `auto` |
| OSV-2022-709 | migration | `93d65ed6503b` | `auto` |
| OSV-2023-102 | migration | `4075324e2b81` | `c9e3a82e3dc1` |
| OSV-2023-436 | migration | `6da3474203fc` | `2cbf2afc2971` |
| OSV-2023-504 | migration | `3608ab01b61b` | `auto` |
| OSV-2023-566 | migration | `0c5a17accb50` | `auto` |
| OSV-2024-469 | migration | `a813121e0a70` | `auto` |
| OSV-2025-449 | migration | `2a77c58ebefd` | `0bd4b81ee98e` |

## Re-run command (any bug)

```bash
BUILD_CSV='/home/user/oss-fuzz-build/fuzzbench/benchmarks/ndpi_transplant_fuzz_process_packet/original-crashes/collect_crash_builds.csv'
OUT_DIR='/home/user/oss-fuzz-build/fuzzbench/benchmarks/ndpi_transplant_fuzz_process_packet/original-crashes'

while IFS=$'\t' read -r bug commit; do
  [ "$bug" = "bug" ] && continue
  ts=$(git -C /home/user/tasks-git/ndpi log -1 --format=%ct "$commit")
  /home/user/pyenv/venv/bin/python3 /home/user/oss-fuzz-for-select/script/fuzz_helper.py collect_crash \
    --commit "$commit" --build_csv "$BUILD_CSV" \
    --testcases /home/user/oss-fuzz-for-select/pocs/tmp --test_input "testcase-${bug}" \
    --runner-image auto --commit-date "$ts" \
    ndpi fuzz_process_packet
  cp "/home/user/oss-fuzz-build/data/crash/target_crash-${commit:0:6}-testcase-${bug}.txt" "${OUT_DIR}/${bug}.txt"
done <<'JOBS'
bug	commit
OSV-2020-1011	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-1013	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-1015	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-1019	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-1074	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-1112	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-1114	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-1131	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-1133	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-1187	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-1194	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-1233	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-1263	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-1294	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-136	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-154	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-1715	bccf1c433a49af286f6b29da72169868e78d4410
OSV-2020-179	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-194	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-28	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-342	32dc9e3225cc3c55f263221e8fd723aa85a991af
OSV-2020-49	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-59	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-774	bccf1c433a49af286f6b29da72169868e78d4410
OSV-2020-78	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-795	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-812	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-918	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-922	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-972	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-992	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2020-994	e695dd6eade754b2d50bdf297ca8bdc4105f93ff
OSV-2022-1032	cd76bacd4aa42e0a2b97f3c8e3ff497fd3dd0495
OSV-2022-445	b306a4b8edc35fc2a42344be7276f0b2367c85d2
OSV-2022-661	8402bd68ad95f486f3dc12984cb39ffd8351ea1d
OSV-2022-670	ac24b35b1fa36f8df6d586742200a0dc2d54f59e
OSV-2022-709	93d65ed6503b32865b5453238c159e603bb37cb8
OSV-2023-102	4075324e2b81c11254a28362942a477594be6b28
OSV-2023-436	6da3474203fc2ff5981f6c73f7ad02fa81138166
OSV-2023-504	3608ab01b61bde1b7ac88baa448fe37724a313db
OSV-2023-566	0c5a17accb509ff950829d50c2af0b031bcbe3a5
OSV-2024-469	a813121e0a7021cdbfd64630960b330a23b1a4d2
OSV-2025-449	2a77c58ebefd60024e7731b3befb20714bc59314
JOBS
```

