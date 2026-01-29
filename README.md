# babs-containers-run-test

Test infrastructure for [babs#328](https://github.com/PennLINC/babs/issues/328) — adding `datalad containers-run` support to BABS.

Hardcoded to Dartmouth Discovery cluster: `/dartfs/rc/lab/D/DBIC/DBIC/CON/asmacdo/tmp-babs-container-run-testing/`

## One-time setup

```bash
bash setup-once.sh
```

Creates:
- `venv/` — datalad + datalad-container (via uv)
- `handmade-containers/` — datalad dataset with bids-mriqc 24.0.2
- `ds000003-demo/` — input BIDS dataset (2 subjects)
- `mriqc_config.yaml` — babs container config

## Test cycle

```bash
# Default: installs from PennLINC/babs@add-containers-run
bash test-run.sh

# Or specify repo and branch:
bash test-run.sh https://github.com/asmacdo/babs.git add-containers-run
```

Reinstalls babs from the specified branch, runs `babs init`, and prints the generated `participant_job.sh` and `.datalad/config`.
