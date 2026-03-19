#!/bin/bash
set -euo pipefail

BASE=/dartfs/rc/lab/D/DBIC/DBIC/CON/asmacdo/tmp-babs-container-run-testing
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "${BASE}"

# TODO idemopotent
# Install uv and create venv
# curl -LsSf https://astral.sh/uv/install.sh | sh
 uv venv "${BASE}/venv"
source "${BASE}/venv/bin/activate"
uv pip install datalad datalad-container

# Create container dataset
cd "${BASE}"
# TODO IDEMPOTENT
# datalad create -c text2git handmade-containers
cd handmade-containers
mkdir -p /scratch/${USER}/tmp
# TODO IDEMPOTENT
# APPTAINER_TMPDIR="/scratch/${USER}/tmp" datalad containers-add bids-mriqc \
#     --url docker://nipreps/mriqc:24.0.2
cd "${BASE}"

# Clone input BIDS dataset
# datalad clone https://github.com/ReproNim/ds000003-demo
# TODO CHANGE PER DS
# datalad clone https://github.com/OpenNeuroDatasets/ds006192/

# Copy config from repo
# TODO CHANGE PER DS
# cp "${SCRIPT_DIR}/seed/ds006192_mriqc_config.yaml" "${BASE}/ds006192_mriqc_config.yaml"

echo ""
echo "Setup complete: ${BASE}"
