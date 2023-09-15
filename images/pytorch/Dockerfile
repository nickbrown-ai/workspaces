ARG JUPYTER_STACKS_TAG=python-3.10
FROM jupyter/minimal-notebook:$JUPYTER_STACKS_TAG

LABEL maintainer="Nick Brown"

USER root

RUN apt-get update && apt-get install -y \
    curl \
    gcc \
    libxml2  \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

ARG CONFIG_DIR_PATH=.jupyter/lab/user-settings
COPY ./jupyter-user-settings /home/jovyan/${CONFIG_DIR_PATH}
COPY ./jupyter-user-settings /home/nick/${CONFIG_DIR_PATH}

COPY requirements.txt /tmp/
COPY environment.yml /tmp/

RUN conda env update -n base --file /tmp/environment.yml && \
    conda clean --all -f -y && \
    rm /tmp/environment.yml

ARG EVCXR_VERSION=0.15.1

ENV PATH="/root/.cargo/bin:${PATH}"
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y && \
    cargo install evcxr_jupyter --version $EVCXR_VERSION && \
    evcxr_jupyter --install

# split conda from pip for docker caching benefits
RUN pip install -r /tmp/requirements.txt && \
    jupyter labextension disable "@jupyterlab/apputils-extension:announcements" && \
    jupyter lab build && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER $NB_UID
