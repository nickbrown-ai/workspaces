ARG JUPYTER_STACKS_TAG=python-3.11
FROM jupyter/minimal-notebook:$JUPYTER_STACKS_TAG

LABEL maintainer="Nick Brown"

# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/docker-specialized.html#dockerfiles
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

USER root

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libxml2  \
    && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

ARG CONFIG_DIR_PATH=.jupyter/lab/user-settings
COPY ./jupyter-user-settings /home/jovyan/${CONFIG_DIR_PATH}
COPY ./jupyter-user-settings /home/nick/${CONFIG_DIR_PATH}

COPY requirements.txt /tmp/

# split conda from pip for docker caching benefits
RUN pip install --no-cache-dir -r /tmp/requirements.txt && \
    jupyter labextension disable "@jupyterlab/apputils-extension:announcements" && \
    jupyter lab build && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER $NB_UID
