#!/bin/bash
set -euo pipefail

BASE=/dartfs/rc/lab/D/DBIC/DBIC/CON/asmacdo/tmp-babs-container-run-testing
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "${BASE}"

# Install uv and create venv
curl -LsSf https://astral.sh/uv/install.sh | sh
uv venv "${BASE}/venv"
source "${BASE}/venv/bin/activate"
uv pip install datalad datalad-container

# Create container dataset
cd "${BASE}"
datalad create -c text2git handmade-containers
cd handmade-containers
APPTAINER_TMPDIR="${HOME}/tmp" datalad containers-add bids-mriqc \
    --url docker://nipreps/mriqc:24.0.2
cd "${BASE}"

# Clone input BIDS dataset
datalad clone https://github.com/ReproNim/ds000003-demo

# Copy config from repo
cp "${SCRIPT_DIR}/seed/mriqc_config.yaml" "${BASE}/mriqc_config.yaml"

echo ""
echo "Setup complete: ${BASE}"
