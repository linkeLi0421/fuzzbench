# Original Crash Collection: ntopng fuzz_dissect_packet

Generated: 2026-04-24 UTC

Benchmark: `ntopng_transplant_fuzz_dissect_packet`
Project: `ntopng`
Fuzzer: `fuzz_dissect_packet`
Sanitizer: `address`

Target source commit: `b7b2810e617117c4420a5e1a4639515f2c45b26b` (2023-05-22)
Target-era base-runner: `gcr.io/oss-fuzz-base/base-runner@sha256:3a190cfbada024425c48aebd06558a0e974e819f69625e886b1fe2b1a138064d` (2022-07)

## Semantics

Each `OSV-*.txt` is a crash on the pristine source tree:
- **Local bugs** (already triggering at target) come from the migration pipeline's
  target-commit captures, saved in `/mnt/nas/linke/new_migrate/ntopng/
  fuzz_dissect_packet/crash/` (though they were actually captured at target by the
  migration pipeline when it verified each local bug still fires at target).
- **Migration bugs** come from the same NAS crash directory, captured per-bug at
  each bug's own buggy source commit by `fuzz_helper.py collect_crash
  --runner-image auto` (era-matched per commit).

All 18 logs are valid (18 real crashes, including the `libFuzzer: deadly signal`
assertion paths). No re-capture was needed; only this CSV + updated COMMANDS.md
were added.

## Bug → source commit / OSS-Fuzz commit

| Bug | Kind | Source commit | OSS-Fuzz commit |
| --- | --- | --- | --- |
| OSV-2023-1160 | local | `b7b2810e6171` | `884106149890` |
| OSV-2023-1214 | local | `b7b2810e6171` | `884106149890` |
| OSV-2023-1352 | migration | `35b09487b9e3` | `f1d21d6f1bea` |
| OSV-2023-1360 | migration | `4084c291321b` | `d98ab91d4709` |
| OSV-2023-1375 | migration | `bb028d7271dc` | `b754d865dc5c` |
| OSV-2023-1381 | migration | `c907e4292692` | `39a27b6a0ff3` |
| OSV-2023-423 | local | `b7b2810e6171` | `884106149890` |
| OSV-2023-425 | local | `b7b2810e6171` | `884106149890` |
| OSV-2023-462 | local | `b7b2810e6171` | `884106149890` |
| OSV-2023-480 | local | `b7b2810e6171` | `884106149890` |
| OSV-2023-507 | local | `b7b2810e6171` | `884106149890` |
| OSV-2023-688 | migration | `f6296c76ea3c` | `645de0a46e48` |
| OSV-2023-697 | local | `b7b2810e6171` | `884106149890` |
| OSV-2023-710 | local | `b7b2810e6171` | `884106149890` |
| OSV-2023-726 | local | `b7b2810e6171` | `884106149890` |
| OSV-2023-741 | local | `b7b2810e6171` | `884106149890` |
| OSV-2023-761 | local | `b7b2810e6171` | `884106149890` |
| OSV-2023-976 | local | `b7b2810e6171` | `884106149890` |

## Re-run command (any bug)

```bash
BUILD_CSV='/home/user/oss-fuzz-build/fuzzbench/benchmarks/ntopng_transplant_fuzz_dissect_packet/original-crashes/collect_crash_builds.csv'
OUT_DIR='/home/user/oss-fuzz-build/fuzzbench/benchmarks/ntopng_transplant_fuzz_dissect_packet/original-crashes'

while IFS=$'\t' read -r bug commit; do
  [ "$bug" = "bug" ] && continue
  ts=$(git -C /home/user/tasks-git/ntopng log -1 --format=%ct "$commit")
  /home/user/pyenv/venv/bin/python3 /home/user/oss-fuzz-for-select/script/fuzz_helper.py collect_crash \
    --commit "$commit" --build_csv "$BUILD_CSV" \
    --testcases /home/user/oss-fuzz-for-select/pocs/tmp --test_input "testcase-${bug}" \
    --runner-image auto --commit-date "$ts" \
    ntopng fuzz_dissect_packet
  cp "/home/user/oss-fuzz-build/data/crash/target_crash-${commit:0:6}-testcase-${bug}.txt" "${OUT_DIR}/${bug}.txt"
done <<'JOBS'
bug	commit
OSV-2023-1160	b7b2810e617117c4420a5e1a4639515f2c45b26b
OSV-2023-1214	b7b2810e617117c4420a5e1a4639515f2c45b26b
OSV-2023-1352	35b09487b9e38f11e5e01fc3cf9eb60b1b493f7c
OSV-2023-1360	4084c291321bc6d152f3926a465f5fb1679f849f
OSV-2023-1375	bb028d7271dc3e2cfead4592ecbf0594a81ae710
OSV-2023-1381	c907e4292692af8fc7a09c14c9093dce44f08dc1
OSV-2023-423	b7b2810e617117c4420a5e1a4639515f2c45b26b
OSV-2023-425	b7b2810e617117c4420a5e1a4639515f2c45b26b
OSV-2023-462	b7b2810e617117c4420a5e1a4639515f2c45b26b
OSV-2023-480	b7b2810e617117c4420a5e1a4639515f2c45b26b
OSV-2023-507	b7b2810e617117c4420a5e1a4639515f2c45b26b
OSV-2023-688	f6296c76ea3c51ce2e602b3280c3df431a1820cd
OSV-2023-697	b7b2810e617117c4420a5e1a4639515f2c45b26b
OSV-2023-710	b7b2810e617117c4420a5e1a4639515f2c45b26b
OSV-2023-726	b7b2810e617117c4420a5e1a4639515f2c45b26b
OSV-2023-741	b7b2810e617117c4420a5e1a4639515f2c45b26b
OSV-2023-761	b7b2810e617117c4420a5e1a4639515f2c45b26b
OSV-2023-976	b7b2810e617117c4420a5e1a4639515f2c45b26b
JOBS
```

