# Original Crash Collection: c-blosc2 decompress_frame_fuzzer

Generated: 2026-04-23 UTC

Benchmark: `c-blosc2_transplant_decompress_frame_fuzzer`
Project: `c-blosc2`
Fuzzer: `decompress_frame_fuzzer`
Sanitizer: `address`

Default source testcase directory: `/home/user/oss-fuzz-for-select/pocs/tmp`
Transplant crash-log directory: `/home/user/oss-fuzz-build/fuzzbench/benchmarks/c-blosc2_transplant_decompress_frame_fuzzer/crashes`
Original crash-log directory: `/home/user/oss-fuzz-build/fuzzbench/benchmarks/c-blosc2_transplant_decompress_frame_fuzzer/original-crashes`
Build CSV used by `collect_crash`: `/home/user/oss-fuzz-build/fuzzbench/benchmarks/c-blosc2_transplant_decompress_frame_fuzzer/original-crashes/collect_crash_builds.csv`

Runner image: `gcr.io/oss-fuzz-base/base-runner@sha256:83dc2104f6325551cf7b2dd928b63a3545bd283d00c3179827dcd963cff7764b`
Runner local image ID: `sha256:47823077f55a0715ce32e3b5caeb8bf051d2e93a1a653843e329096265c253ef`
Runner local image created: `2026-01-03T03:54:18.617978113Z`

## Commit Mapping

Local bugs are the `Already triggering` cases and were replayed at target source commit `79e921d904d46fc9edc292e02a48f1aa54567a7d`.
Migration bugs were replayed at their buggy source commits from `/mnt/nas/linke/new_migrate/c-blosc2/decompress_frame_fuzzer/transplant.log`; skipped-but-triggering entries were completed from the local c-blosc2 migration logs.

`79e921d904d46fc9edc292e02a48f1aa54567a7d` maps to OSS-Fuzz commit `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b`, timestamp `1629815276` (`2021-08-24 14:27:56 +0000`).
`26d05bff` maps to OSS-Fuzz commit `d64b3f05953dfa943b62b81e797034dc91a58e14`.
Source commits not present in `/home/user/log/c-blosc2_builds.csv` were mapped in `collect_crash_builds.csv` to `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` so `collect_crash` can use the historical c-blosc2 OSS-Fuzz integration.

`OSV-2021-639` uses `/home/user/oss-fuzz-for-select/pocs/tmp/testcase-OSV-2021-639` (SHA1 `9fa91231a3d087984487ca05aae682b2f045cb4c`). It was captured with the prebuilt `77b7dfd41f4b8ae7cc12c8babd547829a84435da` fuzzer and the runner image above; the older helper default runner fails before execution with a `GLIBC_2.29` loader error.
`OSV-2022-486` uses `/home/user/oss-fuzz-for-select/pocs/tmp/testcase-OSV-2022-486` and triggers only when replayed with libFuzzer `-runs=10`; the single-input `collect_crash` path can miss the heap-use-after-free.
`OSV-2021-464` requires libFuzzer `-rss_limit_mb=8192`; under the default 2048MB cap libFuzzer aborts with `out-of-memory (malloc(2155905168))` from `init_thread_context` (`blosc2.c:1560`) before the expected `heap-buffer-overflow READ 16` at `blosc_read_header` (`blosc2.c:677`) can fire. It was captured by running the prebuilt `79e921d9` fuzzer directly against the testcase inside the runner image above (see "Re-run Command (OSV-2021-464)" below).

| Bug | Kind | Source commit | OSS-Fuzz commit |
| --- | --- | --- | --- |
| OSV-2020-2184 | migration | `3055a0` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-21 | migration | `0e8bdfce` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-22 | migration | `0e8bdfce` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-213 | migration | `0e8bdfce` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-221 | migration | `fdfeb753` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-246 | migration | `c91ed64c` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-247 | migration | `1a42fcd4` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-274 | migration | `e362bb0b` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-369 | migration | `60b79c4c` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-404 | migration | `49357bd0` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-429 | migration | `5eff30b8` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-464 | local | `79e921d904d46fc9edc292e02a48f1aa54567a7d` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-481 | local | `79e921d904d46fc9edc292e02a48f1aa54567a7d` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-485 | local | `79e921d904d46fc9edc292e02a48f1aa54567a7d` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-487 | local | `79e921d904d46fc9edc292e02a48f1aa54567a7d` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-496 | local | `79e921d904d46fc9edc292e02a48f1aa54567a7d` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-498 | local | `79e921d904d46fc9edc292e02a48f1aa54567a7d` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-526 | local | `79e921d904d46fc9edc292e02a48f1aa54567a7d` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-622 | local | `79e921d904d46fc9edc292e02a48f1aa54567a7d` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-639 | migration | `77b7dfd4` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2021-997 | local | `79e921d904d46fc9edc292e02a48f1aa54567a7d` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2022-4 | migration | `886d4c9b` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2022-34 | migration | `886d4c9b` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2022-486 | migration | `13fbe91e` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2022-511 | migration | `95e0fd42` | `dbf359cf9f0795770d391a4a4bf6b4c9bb88ad5b` |
| OSV-2022-1242 | migration | `26d05bff` | `d64b3f05953dfa943b62b81e797034dc91a58e14` |
| OSV-2023-51 | migration | `26d05bff` | `d64b3f05953dfa943b62b81e797034dc91a58e14` |

## Re-run Command

Run from `/home/user/oss-fuzz-build/fuzzbench`.

```bash
RUNNER_IMAGE='gcr.io/oss-fuzz-base/base-runner@sha256:83dc2104f6325551cf7b2dd928b63a3545bd283d00c3179827dcd963cff7764b'
BUILD_CSV='/home/user/oss-fuzz-build/fuzzbench/benchmarks/c-blosc2_transplant_decompress_frame_fuzzer/original-crashes/collect_crash_builds.csv'
OUT_DIR='benchmarks/c-blosc2_transplant_decompress_frame_fuzzer/original-crashes'

while IFS=$'\t' read -r bug commit prefix testcases; do
  [ "$bug" = "bug" ] && continue
  /home/user/pyenv/venv/bin/python3 /home/user/oss-fuzz-for-select/script/fuzz_helper.py collect_crash \
    --commit "$commit" \
    --build_csv "$BUILD_CSV" \
    --testcases "$testcases" \
    --test_input "testcase-${bug}" \
    --runner-image "$RUNNER_IMAGE" \
    c-blosc2 \
    decompress_frame_fuzzer
  sort -m "/home/user/oss-fuzz-build/data/crash/target_crash-${prefix}-testcase-${bug}.txt" -o "${OUT_DIR}/${bug}.txt"
done <<'JOBS'
bug	commit	prefix	testcases
OSV-2020-2184	3055a0	3055a0	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-21	0e8bdfce	0e8bdf	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-22	0e8bdfce	0e8bdf	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-213	0e8bdfce	0e8bdf	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-221	fdfeb753	fdfeb7	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-246	c91ed64c	c91ed6	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-247	1a42fcd4	1a42fc	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-274	e362bb0b	e362bb	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-369	60b79c4c	60b79c	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-404	49357bd0	49357b	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-429	5eff30b8	5eff30	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-464	79e921d904d46fc9edc292e02a48f1aa54567a7d	79e921	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-481	79e921d904d46fc9edc292e02a48f1aa54567a7d	79e921	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-485	79e921d904d46fc9edc292e02a48f1aa54567a7d	79e921	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-487	79e921d904d46fc9edc292e02a48f1aa54567a7d	79e921	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-496	79e921d904d46fc9edc292e02a48f1aa54567a7d	79e921	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-498	79e921d904d46fc9edc292e02a48f1aa54567a7d	79e921	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-526	79e921d904d46fc9edc292e02a48f1aa54567a7d	79e921	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-622	79e921d904d46fc9edc292e02a48f1aa54567a7d	79e921	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2021-997	79e921d904d46fc9edc292e02a48f1aa54567a7d	79e921	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2022-4	886d4c9b	886d4c	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2022-34	886d4c9b	886d4c	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2022-511	95e0fd42	95e0fd	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2022-1242	26d05bff	26d05b	/home/user/oss-fuzz-for-select/pocs/tmp
OSV-2023-51	26d05bff	26d05b	/home/user/oss-fuzz-for-select/pocs/tmp
JOBS
```

The two non-standard replays are captured with prebuilt fuzzers, because OSV-2021-639 needs the compatible runner image and OSV-2022-486 needs libFuzzer repeat execution:

```bash
/home/user/pyenv/venv/bin/python3 /home/user/oss-fuzz-for-select/script/fuzz_helper.py reproduce \
  --fuzzer_path /mnt/nas/linke/c-blosc2/c-blosc2-77b7dfd41f4b8ae7cc12c8babd547829a84435da-address \
  --runner-image "$RUNNER_IMAGE" \
  c-blosc2 \
  decompress_frame_fuzzer \
  /home/user/oss-fuzz-for-select/pocs/tmp/testcase-OSV-2021-639 \
  > "${OUT_DIR}/OSV-2021-639.txt" 2>&1

/home/user/pyenv/venv/bin/python3 /home/user/oss-fuzz-for-select/script/fuzz_helper.py reproduce \
  --fuzzer_path /mnt/nas/linke/c-blosc2/c-blosc2-13fbe91ec93839e2de76b3df9238d6aec70b9449-address \
  --runner-image "$RUNNER_IMAGE" \
  c-blosc2 \
  decompress_frame_fuzzer \
  /home/user/oss-fuzz-for-select/pocs/tmp/testcase-OSV-2022-486 \
  > "${OUT_DIR}/OSV-2022-486.txt" 2>&1
```

## Re-run Command (OSV-2021-464)

`OSV-2021-464` needs `-rss_limit_mb=8192` or libFuzzer kills the process with `out-of-memory` before the heap-buffer-overflow fires. The `collect_crash` path does not forward fuzzer flags, so it is captured by running the prebuilt binary directly inside the runner image:

```bash
TMPD=$(mktemp -d)
cp /home/user/oss-fuzz-for-select/pocs/tmp/testcase-OSV-2021-464 "$TMPD/"
docker run --rm --platform linux/amd64 --shm-size=2g \
  -v /mnt/nas/linke/c-blosc2/c-blosc2-79e921d904d46fc9edc292e02a48f1aa54567a7d-address:/out:ro \
  -v "$TMPD":/corpus:ro \
  -e ASAN_OPTIONS=abort_on_error=1:symbolize=1 \
  "$RUNNER_IMAGE" \
  /out/decompress_frame_fuzzer /corpus/testcase-OSV-2021-464 -rss_limit_mb=8192 \
  > "${OUT_DIR}/OSV-2021-464.txt" 2>&1
rm -rf "$TMPD"
```
