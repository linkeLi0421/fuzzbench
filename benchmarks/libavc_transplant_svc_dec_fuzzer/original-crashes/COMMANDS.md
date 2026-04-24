# Original Crash Collection: libavc svc_dec_fuzzer

Generated: 2026-04-24 UTC

Benchmark: `libavc_transplant_svc_dec_fuzzer`
Project: `libavc`
Fuzzer: `svc_dec_fuzzer`
Sanitizer: `address`

Target source commit: `c38af025abf0040f6693d15f4ce2e878a728cfee` (2023-02-20)
Target-era base-runner: `gcr.io/oss-fuzz-base/base-runner@sha256:3a190cfbada024425c48aebd06558a0e974e819f69625e886b1fe2b1a138064d` (2022-07, from `get_base_runner_for_date()`)

## Semantics

Each `OSV-*.txt` is a crash on the pristine source tree:
- **Local bugs** (already triggering at target) were replayed against the NAS prebuilt
  `-address` binary at target commit (`c38af025abf0`) using the target-era base-runner.
- **Migration bugs** came from `/mnt/nas/linke/new_migrate/libavc/svc_dec_fuzzer/crash/`,
  captured per-bug by the migration pipeline with `fuzz_helper.py collect_crash
  --runner-image auto` which era-matches the runner per source commit.

Note: `libavc_builds.csv` contains only 29 curated entries (mainly for
`buildAndtest.py` coverage surveys) and does NOT cover this benchmark's target or
migration commits. The `oss_fuzz_commit` column in `collect_crash_builds.csv`
is therefore written as `auto`, which instructs `fuzz_helper.py collect_crash
--runner-image auto --commit-date <ts>` to pick an era-matched base-builder/runner
via `get_base_builder_for_date()` at reproduction time.

## Bug → source commit / OSS-Fuzz commit

| Bug | Kind | Source commit | OSS-Fuzz commit |
| --- | --- | --- | --- |
| OSV-2023-1205 | local | `c38af025abf0` | `auto` |
| OSV-2023-1206 | local | `c38af025abf0` | `auto` |
| OSV-2023-1207 | local | `c38af025abf0` | `auto` |
| OSV-2023-1208 | local | `c38af025abf0` | `auto` |
| OSV-2023-1294 | local | `c38af025abf0` | `auto` |
| OSV-2023-1311 | local | `c38af025abf0` | `auto` |
| OSV-2023-1312 | local | `c38af025abf0` | `auto` |
| OSV-2023-1313 | local | `c38af025abf0` | `auto` |
| OSV-2023-342 | local | `c38af025abf0` | `auto` |
| OSV-2023-68 | migration | `7f19ac220647` | `auto` |
| OSV-2023-75 | migration | `7f19ac220647` | `auto` |
| OSV-2023-840 | local | `c38af025abf0` | `auto` |
| OSV-2023-97 | local | `c38af025abf0` | `auto` |
| OSV-2024-637 | local | `c38af025abf0` | `auto` |
| OSV-2024-638 | migration | `72315c11ac59` | `auto` |
| OSV-2025-534 | local | `c38af025abf0` | `auto` |
| OSV-2025-584 | migration | `2f6371b3b8d6` | `52ee750b71ec` |
| OSV-2025-589 | migration | `2f6371b3b8d6` | `52ee750b71ec` |

## Re-run command (migration bugs)

```bash
BUILD_CSV='/home/user/oss-fuzz-build/fuzzbench/benchmarks/libavc_transplant_svc_dec_fuzzer/original-crashes/collect_crash_builds.csv'
OUT_DIR='/home/user/oss-fuzz-build/fuzzbench/benchmarks/libavc_transplant_svc_dec_fuzzer/original-crashes'

while IFS=$'\t' read -r bug commit; do
  [ "$bug" = "bug" ] && continue
  ts=$(git -C /home/user/tasks-git/libavc log -1 --format=%ct "$commit")
  /home/user/pyenv/venv/bin/python3 /home/user/oss-fuzz-for-select/script/fuzz_helper.py collect_crash \
    --commit "$commit" \
    --build_csv "$BUILD_CSV" \
    --testcases /home/user/oss-fuzz-for-select/pocs/tmp \
    --test_input "testcase-${bug}" \
    --runner-image auto --commit-date "$ts" \
    libavc svc_dec_fuzzer
  cp "/home/user/oss-fuzz-build/data/crash/target_crash-${commit:0:6}-testcase-${bug}.txt" "${OUT_DIR}/${bug}.txt"
done <<'JOBS'
bug	commit
OSV-2023-68	7f19ac220647a58262bf08262049f7340030e1bf
OSV-2023-75	7f19ac220647a58262bf08262049f7340030e1bf
OSV-2024-638	72315c11ac595a73d3b629cc36647327156d5875
OSV-2025-584	2f6371b3b8d69ee596fa44c48ca522db27f6f22f
OSV-2025-589	2f6371b3b8d69ee596fa44c48ca522db27f6f22f
JOBS
```

## Re-run command (local bugs)

Uses the NAS prebuilt target-commit binary (built with a modern OSS-Fuzz toolchain,
compatible with the 2022-07 base-runner) + the target-era base-runner.

```bash
TARGET=c38af025abf0040f6693d15f4ce2e878a728cfee
RUNNER_IMAGE='gcr.io/oss-fuzz-base/base-runner@sha256:3a190cfbada024425c48aebd06558a0e974e819f69625e886b1fe2b1a138064d'
BIN_DIR="/mnt/nas/linke/libavc/libavc-${TARGET}-address"
OUT_DIR='/home/user/oss-fuzz-build/fuzzbench/benchmarks/libavc_transplant_svc_dec_fuzzer/original-crashes'

for bug in \
    OSV-2023-1205 \
    OSV-2023-1206 \
    OSV-2023-1207 \
    OSV-2023-1208 \
    OSV-2023-1294 \
    OSV-2023-1311 \
    OSV-2023-1312 \
    OSV-2023-1313 \
    OSV-2023-342 \
    OSV-2023-840 \
    OSV-2023-97 \
    OSV-2024-637 \
    OSV-2025-534
; do
  TMPD=$(mktemp -d)
  cp /home/user/oss-fuzz-for-select/pocs/tmp/testcase-${bug} "$TMPD/"
  docker run --rm --platform linux/amd64 --shm-size=2g \
    -v "$BIN_DIR":/out:ro -v "$TMPD":/corpus:ro \
    -e ASAN_OPTIONS=abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1 \
    "$RUNNER_IMAGE" \
    /out/svc_dec_fuzzer "/corpus/testcase-${bug}" -rss_limit_mb=8192 \
    > "${OUT_DIR}/${bug}.txt" 2>&1
  rm -rf "$TMPD"
done
```

