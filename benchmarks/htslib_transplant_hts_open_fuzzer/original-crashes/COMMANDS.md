# Original Crash Collection: htslib hts_open_fuzzer

Generated: 2026-04-24 UTC

Benchmark: `htslib_transplant_hts_open_fuzzer`
Project: `htslib`
Fuzzer: `hts_open_fuzzer`
Sanitizer: `address`

Target source commit: `dd6f0b72c92591252bb77818663629cc1a129949` (2019-10-11)
Target OSS-Fuzz commit: `c15017cf4f41014630be236bed440fd2995c2de7` (from `/home/user/log/htslib_builds.csv`)
Target-era base-runner: `gcr.io/oss-fuzz-base/base-runner@sha256:caba4ce727f6dfe43a68b4554efdd617052ad3b634bbc6e28b97f6e3ca1a92ac` (2019-12, from `get_base_runner_for_date()`)

## Semantics

Each `OSV-*.txt` is a crash on the pristine source tree:

- **Local bugs** (already triggering at the target commit, 2019-10) were replayed
  against a **freshly-built** `-address` binary at target commit, using the
  era-matched OSS-Fuzz base-builder (`c15017cf4f41...`) from
  `/home/user/log/htslib_builds.csv`. The NAS prebuilt binary at
  `/mnt/nas/linke/htslib/htslib-dd6f0b72c925...-address/` was built with a
  modern OSS-Fuzz toolchain and requires `libcrypto.so.1.1` which the 2019-era
  base-runner does not ship. Rebuilding at target with the era-matched OSS-Fuzz
  commit produces a binary compatible with the 2019-era base-runner.
- **Migration bugs** were captured per-bug at their own buggy source commits during
  the migration pipeline (`fuzz_helper.py collect_crash --runner-image auto`) which
  era-matches the runner per source commit. Logs are copied from
  `/mnt/nas/linke/new_migrate/htslib/hts_open_fuzzer/crash/`.

## Bug → source commit / OSS-Fuzz commit

| Bug | Kind | Source commit | OSS-Fuzz commit |
| --- | --- | --- | --- |
| OSV-2020-1121 | local | `dd6f0b72c925` | `c15017cf4f41` |
| OSV-2020-1301 | local | `dd6f0b72c925` | `c15017cf4f41` |
| OSV-2020-1733 | migration | `34ba6c726925` | `488d1d35d93c` |
| OSV-2020-958 | local | `dd6f0b72c925` | `c15017cf4f41` |
| OSV-2020-998 | local | `dd6f0b72c925` | `c15017cf4f41` |
| OSV-2020-999 | local | `dd6f0b72c925` | `c15017cf4f41` |
| OSV-2023-1370 | migration | `61b037bb881e` | `84fed7c8f7fb` |
| OSV-2024-1212 | migration | `ca920611fcd8` | `0b69e19c1c00` |
| OSV-2024-189 | migration | `ca0f6214b94a` | `051851826637` |
| OSV-2024-20 | migration | `31e5a5f972b1` | `163e36a5b15e` |
| OSV-2024-74 | migration | `65ae5744347c` | `c58ac449237f` |

## Re-run command (migration bugs)

```bash
BUILD_CSV='/home/user/oss-fuzz-build/fuzzbench/benchmarks/htslib_transplant_hts_open_fuzzer/original-crashes/collect_crash_builds.csv'
OUT_DIR='/home/user/oss-fuzz-build/fuzzbench/benchmarks/htslib_transplant_hts_open_fuzzer/original-crashes'

while IFS=$'\t' read -r bug commit; do
  [ "$bug" = "bug" ] && continue
  ts=$(git -C /home/user/tasks-git/htslib log -1 --format=%ct "$commit")
  /home/user/pyenv/venv/bin/python3 /home/user/oss-fuzz-for-select/script/fuzz_helper.py collect_crash \
    --commit "$commit" \
    --build_csv "$BUILD_CSV" \
    --testcases /home/user/oss-fuzz-for-select/pocs/tmp \
    --test_input "testcase-${bug}" \
    --runner-image auto --commit-date "$ts" \
    htslib hts_open_fuzzer
  cp "/home/user/oss-fuzz-build/data/crash/target_crash-${commit:0:6}-testcase-${bug}.txt" "${OUT_DIR}/${bug}.txt"
done <<'JOBS'
bug	commit
OSV-2020-1733	34ba6c726925efceaa2cc995d7d4b0409907f331
OSV-2023-1370	61b037bb881e85259f8df30c78d99ad3a357ed52
OSV-2024-1212	ca920611fcd8be1180045589ac11bff2f04eafd8
OSV-2024-189	ca0f6214b94adf9278cbcaaefd50f5fe9455f9ad
OSV-2024-20	31e5a5f972b137ec3738bfd565652270904f7112
OSV-2024-74	65ae5744347c9403c061585fa2fc9f5262f2f977
JOBS
```

## Re-run command (local bugs)

Fresh-build at target commit via `fuzz_helper.py build_version` (picks OSS-Fuzz
commit from `htslib_builds.csv`), then replay each PoC against the freshly built
binary using the 2019-era base-runner.

```bash
TARGET=dd6f0b72c92591252bb77818663629cc1a129949
RUNNER_IMAGE='gcr.io/oss-fuzz-base/base-runner@sha256:caba4ce727f6dfe43a68b4554efdd617052ad3b634bbc6e28b97f6e3ca1a92ac'
OUT_DIR='/home/user/oss-fuzz-build/fuzzbench/benchmarks/htslib_transplant_hts_open_fuzzer/original-crashes'

# 1. Build at target commit with era-matched OSS-Fuzz
ts=$(git -C /home/user/tasks-git/htslib log -1 --format=%ct "$TARGET")
sudo -E /home/user/pyenv/venv/bin/python3 /home/user/oss-fuzz-for-select/script/fuzz_helper.py build_version \
  htslib --commit "$TARGET" \
  --build_csv /home/user/log/htslib_builds.csv \
  --runner-image auto --commit-date "$ts" --no_corpus
BIN_DIR=/home/user/oss-fuzz-build/build/out/htslib

# 2. Replay each local bug
for bug in \
    OSV-2020-1121 \
    OSV-2020-1301 \
    OSV-2020-958 \
    OSV-2020-998 \
    OSV-2020-999
; do
  TMPD=$(mktemp -d)
  cp /home/user/oss-fuzz-for-select/pocs/tmp/testcase-${bug} "$TMPD/"
  docker run --rm --platform linux/amd64 --shm-size=2g \
    -v "$BIN_DIR":/out:ro -v "$TMPD":/corpus:ro \
    -e ASAN_OPTIONS=abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1 \
    "$RUNNER_IMAGE" \
    /out/hts_open_fuzzer "/corpus/testcase-${bug}" -rss_limit_mb=8192 \
    > "${OUT_DIR}/${bug}.txt" 2>&1
  rm -rf "$TMPD"
done
```

