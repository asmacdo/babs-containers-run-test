#!/bin/bash
set -euo pipefail

BASE=/dartfs/rc/lab/D/DBIC/DBIC/CON/asmacdo/tmp-babs-container-run-testing
BABS_REPO="${1:-https://github.com/PennLINC/babs.git}"
BABS_BRANCH="${2:-add-containers-run}"

source "${BASE}/venv/bin/activate"

# Install babs from specified branch
uv pip install "git+${BABS_REPO}@${BABS_BRANCH}"

# Clean previous run
rm -rf "${BASE}/babs-generated"

# Run babs init
babs init \
    "${BASE}/babs-generated" \
    --container-ds "${BASE}/handmade-containers" \
    --container-name bids-mriqc \
    --container-config "${BASE}/mriqc_config.yaml" \
    --processing-level subject \
    --queue slurm

echo ""
echo "=== participant_job.sh ==="
cat "${BASE}/babs-generated/analysis/code/participant_job.sh"
echo ""
echo "=== .datalad/config ==="
cat "${BASE}/babs-generated/analysis/.datalad/config"
