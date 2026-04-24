# Original Crash Collection: ghostscript gs_device_pdfwrite_fuzzer

Generated: 2026-04-24 UTC

Benchmark: `ghostscript_transplant_gs_device_pdfwrite_fuzzer`
Project: `ghostscript`
Fuzzer: `gs_device_pdfwrite_fuzzer`
Sanitizer: `address`

Target source commit: `e088d3a844717878592fa5ccf871729983140676` (2022-08-13)
Target OSS-Fuzz commit: `e65a914168f13f4cd823e6df9a76ec60896876f4` (from `/home/user/log/ghostscript_builds.csv`)
Target-era base-runner: `gcr.io/oss-fuzz-base/base-runner@sha256:3a190cfbada024425c48aebd06558a0e974e819f69625e886b1fe2b1a138064d` (from `get_base_runner_for_date()`)

## Semantics

Each `OSV-*.txt` log is a crash on the pristine, un-transplanted source tree:

- **Local bugs** (already triggering at the target commit) are replayed against
  the `-address` prebuilt binary at target commit `e088d3a8` using the
  target-era base-runner.
- **Migration bugs** are replayed at each bug's own buggy source commit during
  the migration pipeline (`fuzz_helper.py collect_crash --runner-image auto`),
  which picks a per-commit era-matched base-runner. Their logs are copied from
  `/mnt/nas/linke/new_migrate/ghostscript/gs_device_pdfwrite_fuzzer/crash/`.

## Bug → source commit / OSS-Fuzz commit

| Bug | Kind | Source commit | OSS-Fuzz commit |
| --- | --- | --- | --- |
| OSV-2022-1021 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-1097 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-1148 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-1194 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-1208 | migration | `04c8185f0e80` | `9a3498ed88d3` |
| OSV-2022-522 | migration | `e784b3314b61` | `017cf397caa9` |
| OSV-2022-523 | migration | `e784b3314b61` | `017cf397caa9` |
| OSV-2022-719 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-724 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-726 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-727 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-744 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-751 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-757 | migration | `05efb77627aa` | `2fa71e3c7f87` |
| OSV-2022-772 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-797 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-818 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-855 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-866 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-888 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2022-949 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2023-1079 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2023-88 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2023-970 | migration | `4cb2e5ff261d` | `876d043e5595` |
| OSV-2024-1391 | local | `e088d3a84471` | `e65a914168f1` |
| OSV-2024-503 | migration | `00264e69ed97` | `4d798330717b` |

## Re-run command (migration bugs)

Run from `/home/user/oss-fuzz-for-select`. Uses `--runner-image auto` so
`get_base_runner_for_date()` picks the era-matched runner for each source commit.

```bash
BUILD_CSV='/home/user/oss-fuzz-build/fuzzbench/benchmarks/ghostscript_transplant_gs_device_pdfwrite_fuzzer/original-crashes/collect_crash_builds.csv'
OUT_DIR='/home/user/oss-fuzz-build/fuzzbench/benchmarks/ghostscript_transplant_gs_device_pdfwrite_fuzzer/original-crashes'

while IFS=$'\t' read -r bug commit; do
  [ "$bug" = "bug" ] && continue
  ts=$(git -C /home/user/tasks-git/ghostscript log -1 --format=%ct "$commit")
  /home/user/pyenv/venv/bin/python3 /home/user/oss-fuzz-for-select/script/fuzz_helper.py collect_crash \
    --commit "$commit" \
    --build_csv "$BUILD_CSV" \
    --testcases /home/user/oss-fuzz-for-select/pocs/tmp \
    --test_input "testcase-${bug}" \
    --runner-image auto --commit-date "$ts" \
    ghostscript gs_device_pdfwrite_fuzzer
  cp "/home/user/oss-fuzz-build/data/crash/target_crash-${commit:0:6}-testcase-${bug}.txt" "${OUT_DIR}/${bug}.txt"
done <<'JOBS'
bug	commit
OSV-2022-1208	04c8185f0e8088f01592917af2b7d52ec63114bf
OSV-2022-522	e784b3314b61f8dfb65e21cd04d7b0ff53251ce1
OSV-2022-523	e784b3314b61f8dfb65e21cd04d7b0ff53251ce1
OSV-2022-757	05efb77627aa0e05ab59ec1d6cb6988e1eb9710e
OSV-2023-970	4cb2e5ff261d260487913e3e075377b51b075db5
OSV-2024-503	00264e69ed974afcc9d4790c3e615fcfc2a39833
JOBS
```

## Re-run command (local bugs)

Local bugs share the target commit, so they are replayed against the prebuilt
`-address` binary at `/mnt/nas/linke/ghostscript/ghostscript-e088d3a844717878592fa5ccf871729983140676-address/`
with the target-era runner. Use `-runs=10` for bugs that need repeat
execution (some crashes only fire on the second run, when libFuzzer's
`TryDetectingAMemoryLeak` double-executes the input).

```bash
RUNNER_IMAGE='gcr.io/oss-fuzz-base/base-runner@sha256:3a190cfbada024425c48aebd06558a0e974e819f69625e886b1fe2b1a138064d'
BIN_DIR='/mnt/nas/linke/ghostscript/ghostscript-e088d3a844717878592fa5ccf871729983140676-address'
OUT_DIR='/home/user/oss-fuzz-build/fuzzbench/benchmarks/ghostscript_transplant_gs_device_pdfwrite_fuzzer/original-crashes'

for bug in \
    OSV-2022-1021 \
    OSV-2022-1097 \
    OSV-2022-1148 \
    OSV-2022-1194 \
    OSV-2022-719 \
    OSV-2022-724 \
    OSV-2022-726 \
    OSV-2022-727 \
    OSV-2022-744 \
    OSV-2022-751 \
    OSV-2022-772 \
    OSV-2022-797 \
    OSV-2022-818 \
    OSV-2022-855 \
    OSV-2022-866 \
    OSV-2022-888 \
    OSV-2022-949 \
    OSV-2023-1079 \
    OSV-2023-88 \
    OSV-2024-1391
;do
  TMPD=$(mktemp -d)
  cp /home/user/oss-fuzz-for-select/pocs/tmp/testcase-${bug} "$TMPD/"
  docker run --rm --platform linux/amd64 --shm-size=2g \
    -v "$BIN_DIR":/out:ro \
    -v "$TMPD":/corpus:ro \
    -e ASAN_OPTIONS=abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1 \
    "$RUNNER_IMAGE" \
    /out/gs_device_pdfwrite_fuzzer "/corpus/testcase-${bug}" -rss_limit_mb=8192 -runs=10 \
    > "${OUT_DIR}/${bug}.txt" 2>&1
  rm -rf "$TMPD"
done
```

