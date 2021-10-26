#!/bin/bash

set -ex
export PATH="${CONDA_BIN}:${PATH}"

cd $(dirname $0)

echo "installing root env:"
cat /tmp/environment.yml
conda install -c conda-forge mamba
mamba env update -n root  -f /tmp/environment.yml
jupyter serverextension enable --sys-prefix jupyter_server_proxy


conda clean -afy
jupyter lab clean
jlpm cache clean
npm cache clean --force
find ${CONDA_DIR}/ -type f,l -name '*.pyc' -delete
find ${CONDA_DIR}/ -type f,l -name '*.a' -delete
find ${CONDA_DIR}/ -type f,l -name '*.js.map' -delete
rm -rf $HOME/.node-gyp
rm -rf $HOME/.local

conda create -n saturn
