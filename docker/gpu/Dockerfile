FROM nvidia/cuda:11.1.1-runtime-ubuntu18.04
EXPOSE 8888

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq --allow-releaseinfo-change update && \
    apt-get -qq upgrade -y && \
    apt-get install --yes --no-install-recommends \
        gettext-base \
        gnupg \
        locales \
        wget \
        curl \
        bzip2 \
        ca-certificates \
        git \
        awscli \
        rsync \
        sudo \
        openssh-server \
        htop \
        screen \
    	vim \
	    emacs-nox \
        default-jre \
        build-essential \
        gcc-multilib \
     > /dev/null && \
    apt-get -qq purge && \
    apt-get -qq clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /run/sshd && \
    chmod 755 /run/sshd && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV SHELL /bin/bash
ENV NB_USER=jovyan
ENV NB_UID=1000
ENV USER=${NB_USER}
ENV HOME=/home/${NB_USER}
ENV APP_BASE=/srv
ENV CONDA_DIR=/srv/conda
ENV CONDA_BIN=${CONDA_DIR}/bin


RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER} && \
    echo "$NB_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/notebook && \
    mkdir -p ${APP_BASE} && \
    chown -R $NB_USER:$NB_USER ${APP_BASE}

COPY profile /etc/profile

USER ${NB_USER}

COPY install-miniconda.bash /tmp/install-miniconda.bash
RUN bash /tmp/install-miniconda.bash


COPY install-jupyter.bash /tmp/install-jupyter.bash
COPY environment.yml /tmp/environment.yml
RUN bash /tmp/install-jupyter.bash && \
    echo '' > ${CONDA_DIR}/conda-meta/history && \
    ${CONDA_BIN}/conda config --system --add channels conda-forge && \
    ${CONDA_BIN}/conda config --system --set auto_update_conda false && \
    ${CONDA_BIN}/conda config --system --set show_channel_urls true
ENV NPM_DIR ${APP_BASE}/npm
ENV NB_PYTHON_PREFIX ${CONDA_DIR}/envs/saturn
ENV PATH ${NB_PYTHON_PREFIX}/bin:${CONDA_BIN}:${NPM_DIR}/bin:${HOME}/.local/bin:${PATH}
WORKDIR ${HOME}

COPY kernel.yml /tmp/kernel.yml
RUN mamba env update -n saturn --file /tmp/kernel.yml && \
    ${CONDA_DIR}/envs/saturn/bin/python -m ipykernel install \
        --name python3 \
        --display-name 'saturn (Python 3)' \
        --prefix=${CONDA_DIR} && \
    ${CONDA_DIR}/bin/conda clean -afy && \
    find ${CONDA_DIR} -type f,l -name '*.pyc' -delete && \
    find ${CONDA_DIR} -type f,l -name '*.a' -delete && \
    find ${CONDA_DIR} -type f,l -name '*.js.map' -delete
RUN echo '' > ${CONDA_DIR}/envs/saturn/conda-meta/history
RUN ${CONDA_DIR}/envs/saturn/bin/Rscript -e 'install.packages(c("IRkernel", "tidyverse", "anndata", "lmds", "FNN"), repos = "https://cran.rstudio.com")'
