# Original Crash Collection: ndpi fuzz_ndpi_reader

Generated: 2026-04-24 UTC

Benchmark: `ndpi_transplant_fuzz_ndpi_reader`
Project: `ndpi`
Fuzzer: `fuzz_ndpi_reader`
Sanitizer: `address`

Target source commit: `5cad39f0e88c03b3cb4f78addf56e217b3d372f2` (2020-02-07)
Target-era base-runner: `gcr.io/oss-fuzz-base/base-runner@sha256:88ceb7b782d6e1e4a126bce5d751c7698493616f006b4b4f5a492f6e0ed0da3e` (2020-01, from `get_base_runner_for_date()`)

## Semantics

Each `OSV-*.txt` is a crash on the pristine source tree:
- **Local bugs** (already triggering at target) come from the migration
  pipeline's target-commit captures, already saved in `/mnt/nas/linke/new_migrate/ndpi/
  fuzz_ndpi_reader/crash/` with a target-era runner.
- **Migration bugs** come from the same NAS crash directory, captured per-bug at
  each bug's own buggy source commit by the migration pipeline with
  `fuzz_helper.py collect_crash --runner-image auto` (era-matched per commit).

This benchmark did not require any re-capture beyond the `/mnt/nas` files — all 35
crash logs are valid ASAN / libFuzzer outputs (including the libFuzzer `deadly
signal` from `OSV-2020-242`'s `ndpi_load_domain_suffixes` assertion).

## Bug → source commit / OSS-Fuzz commit

| Bug | Kind | Source commit | OSS-Fuzz commit |
| --- | --- | --- | --- |
| OSV-2020-10 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2020-142 | migration | `f6038c358a71` | `auto` |
| OSV-2020-1566 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2020-177 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2020-178 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2020-18 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2020-181 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2020-185 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2020-1884 | migration | `bb33d579714e` | `auto` |
| OSV-2020-2126 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2020-236 | migration | `98d9f524f9ff` | `c3271ac0e45c` |
| OSV-2020-242 | migration | `98d9f524f9ff` | `c3271ac0e45c` |
| OSV-2020-40 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2020-60 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2020-67 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2020-70 | migration | `493bffb3e0bd` | `auto` |
| OSV-2020-71 | migration | `f6038c358a71` | `auto` |
| OSV-2020-747 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2020-806 | migration | `94bf7b0130c1` | `auto` |
| OSV-2020-821 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2020-829 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2020-92 | migration | `3874f0e0e029` | `auto` |
| OSV-2020-956 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2022-1025 | migration | `3c0021d60365` | `auto` |
| OSV-2022-325 | local | `5cad39f0e88c` | `1cc1638224a0` |
| OSV-2022-443 | migration | `3b825fca6dc9` | `auto` |
| OSV-2022-447 | migration | `3b825fca6dc9` | `auto` |
| OSV-2022-481 | migration | `8dcaa5c0e11a` | `auto` |
| OSV-2022-695 | migration | `59a9bdeb55fb` | `auto` |
| OSV-2022-712 | migration | `30730e95e5a2` | `auto` |
| OSV-2023-1354 | migration | `5c7200f2bb76` | `auto` |
| OSV-2023-19 | migration | `edb8165ab9b7` | `auto` |
| OSV-2023-573 | migration | `abee1a2a6f1d` | `auto` |
| OSV-2024-1330 | migration | `d7d942586aae` | `auto` |
| OSV-2024-552 | migration | `aee2c81f7684` | `auto` |

## Re-run command (any bug)

```bash
BUILD_CSV='/home/user/oss-fuzz-build/fuzzbench/benchmarks/ndpi_transplant_fuzz_ndpi_reader/original-crashes/collect_crash_builds.csv'
OUT_DIR='/home/user/oss-fuzz-build/fuzzbench/benchmarks/ndpi_transplant_fuzz_ndpi_reader/original-crashes'

while IFS=$'\t' read -r bug commit; do
  [ "$bug" = "bug" ] && continue
  ts=$(git -C /home/user/tasks-git/ndpi log -1 --format=%ct "$commit")
  /home/user/pyenv/venv/bin/python3 /home/user/oss-fuzz-for-select/script/fuzz_helper.py collect_crash \
    --commit "$commit" --build_csv "$BUILD_CSV" \
    --testcases /home/user/oss-fuzz-for-select/pocs/tmp --test_input "testcase-${bug}" \
    --runner-image auto --commit-date "$ts" \
    ndpi fuzz_ndpi_reader
  cp "/home/user/oss-fuzz-build/data/crash/target_crash-${commit:0:6}-testcase-${bug}.txt" "${OUT_DIR}/${bug}.txt"
done <<'JOBS'
bug	commit
OSV-2020-10	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2020-142	f6038c358a71ab43bd1e1b53103659f62ea5adce
OSV-2020-1566	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2020-177	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2020-178	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2020-18	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2020-181	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2020-185	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2020-1884	bb33d579714e140650e13325c39b0d372888b717
OSV-2020-2126	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2020-236	98d9f524f9ff7746d0345939fe543020f8057212
OSV-2020-242	98d9f524f9ff7746d0345939fe543020f8057212
OSV-2020-40	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2020-60	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2020-67	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2020-70	493bffb3e0bd616c2a333d563bc1dd4addec5359
OSV-2020-71	f6038c358a71ab43bd1e1b53103659f62ea5adce
OSV-2020-747	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2020-806	94bf7b0130c1fd447624a9a91d2d125eaac91ea7
OSV-2020-821	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2020-829	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2020-92	3874f0e0e0293dd977fda31d3f50c69ebcad4463
OSV-2020-956	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2022-1025	3c0021d6036532a6fdff9196b7ee7a614bdbd525
OSV-2022-325	5cad39f0e88c03b3cb4f78addf56e217b3d372f2
OSV-2022-443	3b825fca6dc9faef47a06fc47e38450b7571e90a
OSV-2022-447	3b825fca6dc9faef47a06fc47e38450b7571e90a
OSV-2022-481	8dcaa5c0e11a7af1b529d0d657f4b37f11e8ec11
OSV-2022-695	59a9bdeb55fb5a712b51141bfa4492a897cda5c8
OSV-2022-712	30730e95e5a270cb70dd5509fa6e481a7ed4e074
OSV-2023-1354	5c7200f2bb763bfcd4e0636aebb88573e97bbcf3
OSV-2023-19	edb8165ab9b70cf8c152b6a3dfbec9c8a4853eef
OSV-2023-573	abee1a2a6f1d8375831901e49ace85eaea0650e3
OSV-2024-1330	d7d942586aaee89968f458e95acafe260dbdda7c
OSV-2024-552	aee2c81f76842c6968e98f343adb46082eb3fb85
JOBS
```

