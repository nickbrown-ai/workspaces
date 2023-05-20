ARG JUPYTER_STACKS_TAG=python-3.10
FROM jupyter/minimal-notebook:$JUPYTER_STACKS_TAG

LABEL maintainer="Nick Brown"

ARG THEME_FILE=themes.jupyterlab-settings
ARG PLUGIN_FILE=plugin.jupyterlab-settings
ARG JUPYTER_CONFIG_DIR_PATH=/home/jovyan/.jupyter/lab/user-settings/@jupyterlab 

COPY $THEME_FILE ${JUPYTER_CONFIG_DIR_PATH}/apputils-extension/
COPY $PLUGIN_FILE ${JUPYTER_CONFIG_DIR_PATH}/extensionmanager-extension/
COPY kernel.json /opt/conda/share/jupyter/kernels/python3/

USER root

RUN apt-get update && apt-get install -y libxml2 gcc && \
    rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

COPY environment.yml /tmp/

RUN conda env update -n base --file /tmp/environment.yml && \
    conda clean --all -f -y && \
    rm /tmp/environment.yml && \
    jupyter lab build && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER $NB_UID
