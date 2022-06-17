ARG JUPYTER_STACKS_TAG=python-3.9.13
FROM jupyter/scipy-notebook:$JUPYTER_STACKS_TAG

LABEL maintainer="Nick Brown"

# executable jupyter extension installer
ARG JUPYTER_EXTENSIONS=jupyter_extension_install.sh 
ARG THEME_FILE=themes.jupyterlab-settings
ARG JUPYTER_CONFIG_FILE_PATH=/home/jovyan/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/

COPY $JUPYTER_EXTENSIONS /tmp/ 
COPY $THEME_FILE $JUPYTER_CONFIG_FILE_PATH
COPY environment.yml /tmp
COPY kernel.json /opt/conda/share/jupyter/kernels/python3/

USER root

RUN conda env update -n base --file /tmp/environment.yml && \
    conda clean --all -f -y && \
    chmod 744 /tmp/$JUPYTER_EXTENSIONS && \
    /tmp/$JUPYTER_EXTENSIONS && \
    rm /tmp/$JUPYTER_EXTENSIONS && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER $NB_UID
