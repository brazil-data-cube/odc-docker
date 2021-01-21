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
ODC_STATS_IMAGE_TAG="${ODC_TAG_PREFIX}/odc-stats:${ODC_TAG_VERSION}"


#
# Build ODC image with all the dependencies already installed
#
echo "Building image for ODC..."

cp .datacube.conf docker/odc/

cd docker/odc

docker build ${ODC_BUILD_MODE} \
             -t ${ODC_IMAGE_TAG} \
             --file Dockerfile .

cd ../../


#
# Build ODC-Stats image with all the dependencies already installed
#
echo "Building image for ODC-Stats..."

cd docker/odc-stats

docker build ${ODC_BUILD_MODE} \
             --build-arg BASE_IMAGE=${ODC_IMAGE_TAG} \
             -t "${ODC_TAG_PREFIX}/odc-stats:${ODC_TAG_VERSION}" \
             --file Dockerfile .

cd ../../