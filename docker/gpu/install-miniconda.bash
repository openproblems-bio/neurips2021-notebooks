#!/bin/bash

set -ex

cd $(dirname $0)

MINICONDA_VERSION=py37_4.9.2
URL="https://repo.continuum.io/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh"
INSTALLER_PATH=/tmp/miniconda-installer.sh
wget --quiet $URL -O ${INSTALLER_PATH}
chmod +x ${INSTALLER_PATH}

MD5SUM="3143b1116f2d466d9325c206b7de88f7"

if ! echo "${MD5SUM}  ${INSTALLER_PATH}" | md5sum  --quiet -c -; then
    echo "md5sum mismatch for ${INSTALLER_PATH}, exiting!"
    exit 1
fi

bash ${INSTALLER_PATH} -b -p ${CONDA_DIR}

export PATH="${CONDA_BIN}:$PATH"

# Update conda
conda update -y conda

# Allow easy direct installs from conda forge
conda config --system --add channels conda-forge
conda config --system --set auto_update_conda false
conda config --system --set show_channel_urls true
