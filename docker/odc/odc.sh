#!/bin/bash
#
# This file is part of ODC Docker.
# Copyright (C) 2021 INPE.
#
# ODC Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

set -e

conda create --name odc \
             --channel conda-forge \
             python=3.6 datacube pre_commit psycopg2 ipykernel

source activate odc

mkdir ~/Devel && cd ~/Devel && git clone https://github.com/opendatacube/datacube-core.git

cd datacube-core

pip install --upgrade -e .

pre-commit install

conda install --yes \
              --channel conda-forge \
              gdal geopandas matplotlib ipyleaflet

jupyter labextension install @jupyter-widgets/jupyterlab-manager
jupyter labextension install jupyter-leaflet
jupyter nbextension enable --py --sys-prefix ipyleaflet
jupyter labextension install @jupyterlab/debugger
jupyter labextension install @jupyterlab/geojson-extension
jupyter labextension install @jupyterlab/vega3-extension
jupyter labextension install @jupyterlab/mathjax3-extension
jupyter labextension install @jupyterlab/github
jupyter labextension install @jupyterlab/latex