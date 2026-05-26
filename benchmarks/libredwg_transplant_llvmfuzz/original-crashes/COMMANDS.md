# Original Crash Collection: libredwg llvmfuzz

Generated: 2026-04-24 UTC

Benchmark: `libredwg_transplant_llvmfuzz`
Project: `libredwg`
Fuzzer: `llvmfuzz`
Sanitizer: `address`

Target source commit: `a67ea97d93998f35d6494c96118c60c5f1aee4e9` (2023-10-29)
Target-era base-runner: `gcr.io/oss-fuzz-base/base-runner@sha256:3a190cfbada024425c48aebd06558a0e974e819f69625e886b1fe2b1a138064d` (2022-07)

## Semantics

Each `OSV-*.txt` is a crash on the pristine source tree:
- **Local bugs** (already triggering at target) replayed against the NAS prebuilt
  `-address` binary at target commit (`a67ea97d9399`) with the target-era base-runner.
- **Migration bugs** copied from `/mnt/nas/linke/new_migrate/libredwg/llvmfuzz/crash/`,
  captured per-bug by the migration pipeline with era-matched runner per source commit.

Note: 2 bugs (`OSV-2021-495`, `OSV-2023-416`) were **dropped** from this
benchmark on 2026-05-26 (`total_bugs` 65 → 63). They were misclassified by
the migration pipeline as already-triggering at target but neither PoC
actually crashes at target `a67ea97d` (clean exit in <50 ms) or on the
merged binary. Two transplant attempts produced no usable diff. See
`/mnt/nas/linke/new_migrate/libredwg/llvmfuzz/dropped_bugs.md` for the
full diagnostic notes and captured introduced-commit crash signatures.

Note: `libredwg_builds.csv` contains 409 rows but does not cover every source commit
used here; rows in `collect_crash_builds.csv` with `oss_fuzz_commit=auto` defer to
`fuzz_helper.py collect_crash --runner-image auto --commit-date <ts>` to pick era-
matched images at reproduction time.

## Bug → source commit / OSS-Fuzz commit

| Bug | Kind | Source commit | OSS-Fuzz commit |
| --- | --- | --- | --- |
| OSV-2021-493 | migration | `ea0b9522f63d` | `3a564d9f11a1` |
| OSV-2021-535 | migration | `837c8bf8c486` | `a517dca16725` |
| OSV-2021-543 | migration | `084083ce54e5` | `4dc731cfacc6` |
| OSV-2021-577 | migration | `85b1abf3aad0` | `3a4e6e4484a1` |
| OSV-2021-620 | migration | `376c4f69a4e6` | `f93b8506e826` |
| OSV-2021-771 | migration | `d31d11b8df12` | `fd772dcbb51c` |
| OSV-2021-814 | migration | `98a95f7de998` | `0aac0529ada6` |
| OSV-2022-1180 | migration | `a06d461bf19a` | `b33da1891377` |
| OSV-2022-1211 | migration | `a06d461bf19a` | `b33da1891377` |
| OSV-2022-1251 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2022-1252 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2022-128 | migration | `376c4f69a4e6` | `f93b8506e826` |
| OSV-2022-129 | migration | `d31d11b8df12` | `fd772dcbb51c` |
| OSV-2022-363 | migration | `c71fbe25cba8` | `97d0732562d2` |
| OSV-2022-377 | migration | `c463afbab3a4` | `f93b8506e826` |
| OSV-2022-387 | migration | `c71fbe25cba8` | `97d0732562d2` |
| OSV-2022-398 | migration | `a06d461bf19a` | `b33da1891377` |
| OSV-2022-403 | migration | `98729e9d56bd` | `dbf4d1181ac4` |
| OSV-2022-654 | migration | `9a98686f3f54` | `dfede1ec348a` |
| OSV-2022-656 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2022-657 | migration | `24faedf968fc` | `a7f41820024a` |
| OSV-2022-664 | migration | `a06d461bf19a` | `b33da1891377` |
| OSV-2023-1048 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-1051 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-1063 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-1099 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-1101 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-1104 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-1110 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-1122 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-1149 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-1186 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-135 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-269 | migration | `a8bc5d06cbb5` | `19831c6fc569` |
| OSV-2023-270 | migration | `a8bc5d06cbb5` | `19831c6fc569` |
| OSV-2023-271 | migration | `a8bc5d06cbb5` | `19831c6fc569` |
| OSV-2023-284 | migration | `8f3afc1b98de` | `5b0c0f3b0b54` |
| OSV-2023-314 | migration | `f4a639a97838` | `7ecfd475b6b1` |
| OSV-2023-316 | migration | `1c722dabc26a` | `9fc1908fc15d` |
| OSV-2023-397 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-412 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-415 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-42 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-440 | migration | `8c36b98d4308` | `eb1862cc1373` |
| OSV-2023-452 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-455 | migration | `bf11fad98f6f` | `1b179522218a` |
| OSV-2023-46 | migration | `919f9faa3094` | `11c63707a20a` |
| OSV-2023-634 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-717 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-748 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-758 | migration | `8c36b98d4308` | `eb1862cc1373` |
| OSV-2023-777 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-811 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-850 | migration | `336fa3944463` | `750c28088587` |
| OSV-2023-855 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-874 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-894 | migration | `b4bf31ac7357` | `2128769e2286` |
| OSV-2023-965 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2023-997 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2024-123 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2024-38 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2024-384 | local | `a67ea97d9399` | `85ca9895ba29` |
| OSV-2024-42 | local | `a67ea97d9399` | `85ca9895ba29` |

## Re-run command (migration bugs)

```bash
BUILD_CSV='/home/user/oss-fuzz-build/fuzzbench/benchmarks/libredwg_transplant_llvmfuzz/original-crashes/collect_crash_builds.csv'
OUT_DIR='/home/user/oss-fuzz-build/fuzzbench/benchmarks/libredwg_transplant_llvmfuzz/original-crashes'

while IFS=$'\t' read -r bug commit; do
  [ "$bug" = "bug" ] && continue
  ts=$(git -C /home/user/tasks-git/libredwg log -1 --format=%ct "$commit")
  /home/user/pyenv/venv/bin/python3 /home/user/oss-fuzz-for-select/script/fuzz_helper.py collect_crash \
    --commit "$commit" --build_csv "$BUILD_CSV" \
    --testcases /home/user/oss-fuzz-for-select/pocs/tmp --test_input "testcase-${bug}" \
    --runner-image auto --commit-date "$ts" \
    libredwg llvmfuzz
  cp "/home/user/oss-fuzz-build/data/crash/target_crash-${commit:0:6}-testcase-${bug}.txt" "${OUT_DIR}/${bug}.txt"
done <<'JOBS'
bug	commit
OSV-2021-493	ea0b9522f63d049ded2c3cff8d9a8c360119951c
OSV-2021-535	837c8bf8c486da9f39313e06750a5b257af09db8
OSV-2021-543	084083ce54e59b5a43e6eb936868ef4bd037c7e2
OSV-2021-577	85b1abf3aad0add9336c5876ea892013aa63e4e6
OSV-2021-620	376c4f69a4e6590c63c4b4df6a9ff76a357aff36
OSV-2021-771	d31d11b8df12fd480239f1e4f502b94ac8ea2103
OSV-2021-814	98a95f7de998e21e668f3ee956df21f4c52ae5d0
OSV-2022-1180	a06d461bf19a9542204ad9761f2b38dc57c9d23d
OSV-2022-1211	a06d461bf19a9542204ad9761f2b38dc57c9d23d
OSV-2022-128	376c4f69a4e6590c63c4b4df6a9ff76a357aff36
OSV-2022-129	d31d11b8df12fd480239f1e4f502b94ac8ea2103
OSV-2022-363	c71fbe25cba8bfe6b0ef9aee2982cf2c5d53efe5
OSV-2022-377	c463afbab3a48532f2bf1a79bdb8ab046d5b3065
OSV-2022-387	c71fbe25cba8bfe6b0ef9aee2982cf2c5d53efe5
OSV-2022-398	a06d461bf19a9542204ad9761f2b38dc57c9d23d
OSV-2022-403	98729e9d56bd5e8e0530de39d955dc838803cbb2
OSV-2022-654	9a98686f3f54f6e8450056ec846f82c71a4777e1
OSV-2022-657	24faedf968fc32f563b596d3621d086696958a8b
OSV-2022-664	a06d461bf19a9542204ad9761f2b38dc57c9d23d
OSV-2023-269	a8bc5d06cbb503f88958e45338bfebdee9baf0fd
OSV-2023-270	a8bc5d06cbb503f88958e45338bfebdee9baf0fd
OSV-2023-271	a8bc5d06cbb503f88958e45338bfebdee9baf0fd
OSV-2023-284	8f3afc1b98de37e9263ed91dd300daa877b7e5df
OSV-2023-314	f4a639a97838b982f3db11e0ab16e9c33bb05167
OSV-2023-316	1c722dabc26a3b91e3bb5b4cb8f480c4b5bb900b
OSV-2023-440	8c36b98d4308bc28a1fed434faef6e51d75ca566
OSV-2023-455	bf11fad98f6f3af66eac0aa86efdd4e9deb30c9d
OSV-2023-46	919f9faa30942269ba453ae563a0d376b290d861
OSV-2023-758	8c36b98d4308bc28a1fed434faef6e51d75ca566
OSV-2023-850	336fa39444631a5eb27fcf9311ff08098a45aa24
OSV-2023-894	b4bf31ac73570ac19a6ca9f753bdf979c5f625f7
JOBS
```

## Re-run command (local bugs)

```bash
TARGET=a67ea97d93998f35d6494c96118c60c5f1aee4e9
RUNNER_IMAGE='gcr.io/oss-fuzz-base/base-runner@sha256:3a190cfbada024425c48aebd06558a0e974e819f69625e886b1fe2b1a138064d'
BIN_DIR="/mnt/nas/linke/libredwg/libredwg-${TARGET}-address"
OUT_DIR='/home/user/oss-fuzz-build/fuzzbench/benchmarks/libredwg_transplant_llvmfuzz/original-crashes'

# Most local bugs trigger on -runs=1; a few need -runs=10 (libFuzzer's leak detection re-exec).
for bug in \
    OSV-2022-1251 \
    OSV-2022-1252 \
    OSV-2022-656 \
    OSV-2023-1048 \
    OSV-2023-1051 \
    OSV-2023-1063 \
    OSV-2023-1099 \
    OSV-2023-1101 \
    OSV-2023-1104 \
    OSV-2023-1110 \
    OSV-2023-1122 \
    OSV-2023-1149 \
    OSV-2023-1186 \
    OSV-2023-135 \
    OSV-2023-397 \
    OSV-2023-412 \
    OSV-2023-415 \
    OSV-2023-42 \
    OSV-2023-452 \
    OSV-2023-634 \
    OSV-2023-717 \
    OSV-2023-748 \
    OSV-2023-777 \
    OSV-2023-811 \
    OSV-2023-855 \
    OSV-2023-874 \
    OSV-2023-965 \
    OSV-2023-997 \
    OSV-2024-123 \
    OSV-2024-38 \
    OSV-2024-384 \
    OSV-2024-42
; do
  TMPD=$(mktemp -d)
  cp /home/user/oss-fuzz-for-select/pocs/tmp/testcase-${bug} "$TMPD/"
  docker run --rm --platform linux/amd64 --shm-size=2g \
    -v "$BIN_DIR":/out:ro -v "$TMPD":/corpus:ro \
    -e ASAN_OPTIONS=abort_on_error=1:symbolize=1:detect_leaks=0:detect_stack_use_after_return=1 \
    "$RUNNER_IMAGE" \
    /out/llvmfuzz "/corpus/testcase-${bug}" -rss_limit_mb=8192 -runs=10 \
    > "${OUT_DIR}/${bug}.txt" 2>&1
  rm -rf "$TMPD"
done
```

