# Original Crash Collection: opensc fuzz_pkcs15_reader

Generated: 2026-04-24 UTC

Benchmark: `opensc_transplant_fuzz_pkcs15_reader`
Project: `opensc`
Fuzzer: `fuzz_pkcs15_reader`
Sanitizer: `address`

Target source commit: `6903aebfddc466d966c7b865fae34572bf3ed23e` (2020-07-30)
Target-era base-runner: `gcr.io/oss-fuzz-base/base-runner@sha256:88ceb7b782d6e1e4a126bce5d751c7698493616f006b4b4f5a492f6e0ed0da3e` (2020-01, from `get_base_runner_for_date()`)

## Semantics

Each `OSV-*.txt` is a crash on the pristine source tree:
- **Local bugs** (already triggering at target): NAS prebuilt at target + target-era runner.
- **Migration bugs**: from `/mnt/nas/linke/new_migrate/opensc/fuzz_pkcs15_reader/
  bug_transplant/<proj>_<bug>/transplant_crash.txt` (captured during the transplant
  agent's verification at each bug's buggy source commit).
- **OSV-2020-2254**: flagged as local by the migration pipeline, but pristine target
  doesn't fire it. Captured at the bug's OSV `introduced` commit
  (`9ffb9bae63c8`) with `-runs=100` so libFuzzer's stack-reuse path fires the
  SUAR bug. `detect_stack_use_after_return=1` is required.

## Bug → source commit / OSS-Fuzz commit

| Bug | Kind | Source commit | OSS-Fuzz commit |
| --- | --- | --- | --- |
| OSV-2020-1046 | migration | `708cedbdad0d` | `auto` |
| OSV-2020-1720 | local | `6903aebfddc4` | `auto` |
| OSV-2020-1836 | local | `6903aebfddc4` | `auto` |
| OSV-2020-1844 | local | `6903aebfddc4` | `auto` |
| OSV-2020-1848 | local | `6903aebfddc4` | `auto` |
| OSV-2020-1860 | local | `6903aebfddc4` | `auto` |
| OSV-2020-1981 | migration | `3ff059a74bcd` | `auto` |
| OSV-2020-1990 | local | `6903aebfddc4` | `auto` |
| OSV-2020-209 | local | `6903aebfddc4` | `auto` |
| OSV-2020-2157 | local | `6903aebfddc4` | `auto` |
| OSV-2020-2178 | local | `6903aebfddc4` | `auto` |
| OSV-2020-2222 | local | `6903aebfddc4` | `auto` |
| OSV-2020-2254 | local* | `9ffb9bae63c8` | `auto` |
| OSV-2020-55 | migration | `55fd3db2b5f2` | `auto` |
| OSV-2020-693 | migration | `7a1e42e13522` | `auto` |
| OSV-2020-885 | local | `6903aebfddc4` | `auto` |
| OSV-2020-969 | migration | `af42a9387413` | `auto` |
| OSV-2021-1017 | migration | `8453c0d99a49` | `auto` |
| OSV-2021-262 | local | `6903aebfddc4` | `auto` |
| OSV-2021-474 | local | `6903aebfddc4` | `auto` |
| OSV-2021-537 | local | `6903aebfddc4` | `auto` |
| OSV-2021-538 | local | `6903aebfddc4` | `auto` |
| OSV-2021-915 | migration | `8453c0d99a49` | `auto` |

*`OSV-2020-2254` uses its OSV-introduced commit (`9ffb9bae`) instead of target. The
migration pipeline captured a `pkcs15-tcos.c:235:26` UBSAN bounds at target (shadow),
but the OSV report is a `Stack-use-after-return READ 1` at the same line. Reproducing
the authentic SUAR requires the introduced-commit binary with `-runs=100`.

## Re-run command (migration bugs)

Migration crashes were captured during the transplant pipeline's per-bug
verification; the authoritative copy lives in `bug_transplant/<proj>_<bug>/
transplant_crash.txt` under `/mnt/nas/linke/new_migrate/opensc/fuzz_pkcs15_reader/`.
(No per-bug `crash/` dir was populated for opensc by the pipeline this run.)

```bash
NAS=/mnt/nas/linke/new_migrate/opensc/fuzz_pkcs15_reader/bug_transplant
OUT=/home/user/oss-fuzz-build/fuzzbench/benchmarks/opensc_transplant_fuzz_pkcs15_reader/original-crashes
for bug in \
    OSV-2020-1046 \
    OSV-2020-1981 \
    OSV-2020-55 \
    OSV-2020-693 \
    OSV-2020-969 \
    OSV-2021-1017 \
    OSV-2021-915 \
; do
  cp "$NAS/opensc_${bug}/transplant_crash.txt" "$OUT/${bug}.txt"
done
```

## Re-run command (local bugs)

```bash
TARGET=6903aebfddc466d966c7b865fae34572bf3ed23e
RUNNER_IMAGE='gcr.io/oss-fuzz-base/base-runner@sha256:88ceb7b782d6e1e4a126bce5d751c7698493616f006b4b4f5a492f6e0ed0da3e'
BIN_DIR="/mnt/nas/linke/opensc/opensc-${TARGET}-address"
OUT_DIR='/home/user/oss-fuzz-build/fuzzbench/benchmarks/opensc_transplant_fuzz_pkcs15_reader/original-crashes'

for bug in \
    OSV-2020-1720 \
    OSV-2020-1836 \
    OSV-2020-1844 \
    OSV-2020-1848 \
    OSV-2020-1860 \
    OSV-2020-1990 \
    OSV-2020-209 \
    OSV-2020-2157 \
    OSV-2020-2178 \
    OSV-2020-2222 \
    OSV-2020-885 \
    OSV-2021-262 \
    OSV-2021-474 \
    OSV-2021-537 \
    OSV-2021-538
; do
  TMPD=$(mktemp -d); cp /home/user/oss-fuzz-for-select/pocs/tmp/testcase-${bug} "$TMPD/"
  docker run --rm --platform linux/amd64 --shm-size=2g \
    -v "$BIN_DIR":/out:ro -v "$TMPD":/corpus:ro \
    -e ASAN_OPTIONS=abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1 \
    "$RUNNER_IMAGE" \
    /out/fuzz_pkcs15_reader "/corpus/testcase-${bug}" -rss_limit_mb=8192 \
    > "${OUT_DIR}/${bug}.txt" 2>&1
  rm -rf "$TMPD"
done

# OSV-2020-2254: introduced commit + runs=100
BIN2254="/mnt/nas/linke/opensc/opensc-9ffb9bae63c8b7fbababb8481a83f1b575e59a18-address"
TMPD=$(mktemp -d); cp /home/user/oss-fuzz-for-select/pocs/tmp/testcase-OSV-2020-2254 "$TMPD/"
docker run --rm --platform linux/amd64 --shm-size=2g \
  -v "$BIN2254":/out:ro -v "$TMPD":/corpus:ro \
  -e ASAN_OPTIONS=abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1 \
  "$RUNNER_IMAGE" \
  /out/fuzz_pkcs15_reader /corpus/testcase-OSV-2020-2254 -rss_limit_mb=8192 -runs=100 \
  > "${OUT_DIR}/OSV-2020-2254.txt" 2>&1
rm -rf $TMPD
```

