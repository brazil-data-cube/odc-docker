FROM jupyter/datascience-notebook@sha256:ed6c44b7b513783e541e251fa057ced63e91887179c16ae5c535fe103c86c3f4


#
# Run command as root
#
USER root


#
# Install ODC system dependencies
#
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libudunits2-dev \
    libpq-dev \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*


#
# Install JupyterLab extensions
#
RUN conda install --yes ipyleaflet \
    && jupyter labextension install @jupyter-widgets/jupyterlab-manager \
    && jupyter labextension install jupyter-leaflet \
    && jupyter nbextension enable --py --sys-prefix ipyleaflet \
    && jupyter labextension install @jupyterlab/debugger \
    && jupyter labextension install @jupyterlab/geojson-extension \
    && jupyter labextension install @jupyterlab/vega3-extension \
    && jupyter labextension install @jupyterlab/mathjax3-extension \
    && jupyter labextension install @jupyterlab/github \
    && jupyter labextension install @jupyterlab/latex \
    && jupyter nbextension enable --py widgetsnbextension


#
# Install ODC in a new conda environment named odc
#
COPY odc.sh odc.sh
RUN ./odc.sh && rm odc.sh

COPY .datacube.conf .datacube.conf
RUN chown $NB_UID:users .datacube.conf


#
# Change user to jovyan
#
USER $NB_UID