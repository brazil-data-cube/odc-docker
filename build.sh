#!/bin/bash
#
# This file is part of SITS Docker.
# Copyright (C) 2021 INPE.
#
# SITS Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

set -eoux pipefail


#
# General variables
#
ODC_BUILD_MODE=""
ODC_TAG_PREFIX="bdc"
ODC_TAG_VERSION="1.8"
ODC_IMAGE_TAG="${ODC_TAG_PREFIX}/odc:${ODC_TAG_VERSION}"

# allow jovyan to install o.s and conda packages
ODC_IMAGE_JOVYAN_AS_ROOT=0
ODC_IMAGE_USE_DEVELOPMENT_MODE=0

ODC_DASK_IMAGE_TAG="${ODC_TAG_PREFIX}/odc-dask-worker:${ODC_TAG_VERSION}"

#
# Build ODC image with all the dependencies already installed
#
echo "Building image for ODC..."

cp .datacube.conf docker/odc/
cp .datacube.conf docker/odc-stats-dask-worker/

cd docker/odc

docker build ${ODC_BUILD_MODE} \
             -t ${ODC_IMAGE_TAG} \
             --build-arg JOVYAN_AS_ROOT=${ODC_IMAGE_JOVYAN_AS_ROOT} \
             --build-arg BUILD_DEVELOPMENT_MODE=${ODC_IMAGE_USE_DEVELOPMENT_MODE} \
             --file Dockerfile .

cd ../

#
# Build Dask-Worker image for ODC-Stats with all the dependencies already installed
#
echo "Building Dask-Worker image for ODC-Stats"

cd odc-stats-dask-worker/

docker build ${ODC_BUILD_MODE} \
             -t "${ODC_STATS_DASK_IMAGE_TAG}" \
             --file Dockerfile .


cd ../../
