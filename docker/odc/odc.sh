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

python -m ipykernel install --name odc \
                            --display-name "Python (Open Data Cube)"

mkdir ~/Devel && cd ~/Devel && git clone https://github.com/opendatacube/datacube-core.git

cd datacube-core

pip install --upgrade -e .

pre-commit install

conda install --yes \
              --channel conda-forge \
              gdal geopandas matplotlib ipyleaflet rasterio fiona shapely seaborn rtree