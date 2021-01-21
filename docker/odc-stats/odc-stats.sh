#!/bin/bash
#
# This file is part of ODC Docker.
# Copyright (C) 2021 INPE.
#
# ODC Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

set -e

## Installing datacube-stats
echo "Installing digitalearthau..."
git clone https://github.com/GeoscienceAustralia/digitalearthau && cd digitalearthau
python3 setup.py install && rm -rf digitalearthau

echo "Installing odc-tools..."
pip install --extra-index-url="https://packages.dea.ga.gov.au" \
  odc-ui \
  odc-index \
  odc-geom \
  odc-algo \
  odc-io \
  odc-aws \
  odc-aio \
  odc-dscache \
  odc-dtools
pip install --extra-index-url="https://packages.dea.ga.gov.au" odc-apps-dc-tools

echo "Installing datacube-stats"
pip install git+https://github.com/opendatacube/datacube-stats/

echo "Installing compression libraries"
pip install blosc lz4