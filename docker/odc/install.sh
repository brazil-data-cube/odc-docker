#!/bin/bash
#
# This file is part of ODC Docker.
# Copyright (C) 2021 INPE.
#
# ODC Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

set -e

ODC_DISPLAY_NAME=""
ODC_ENVIRONMENT_NAME=""
ODC_ENVIRONMENT_MODE="user"

#
# General functions
#
usage() {
    echo "Usage: $0 [-e <environment name>] [-d <display name>] [-m [user|development]" 1>&2;

    exit 1;
}

#
# Environment options
#
while getopts "e:d:m:h" option; do
    case "${option}" in
        d)
            ODC_DISPLAY_NAME=${OPTARG}
            ;;
        e)
            ODC_ENVIRONMENT_NAME=${OPTARG}
            ;;
        m)
            ODC_ENVIRONMENT_MODE=${OPTARG}
            ;;
        h)
            usage
            ;;
        *)
            usage
            ;;
    esac
done

if [ ${ODC_ENVIRONMENT_MODE} == "development" ]
then
    echo "Development mode!"

    ODC_ENVIRONMENT_NAME=/opt/development/conda-envs/jovyan/${ODC_ENVIRONMENT_NAME}
    conda create --prefix ${ODC_ENVIRONMENT_NAME} python=3.6
else
    echo "User mode!"

    conda create --name ${ODC_ENVIRONMENT_NAME} python=3.6
fi

source activate ${ODC_ENVIRONMENT_NAME}

#
# Install Open Data Cube
#
conda install --yes --channel conda-forge \
    datacube \
    pre_commit \
    psycopg2 \
    ipykernel \
    gdal

#
# Install extra packages
#
echo "Installing extra packages"

for script in extras/*.sh; do
    ./${script}
done

#
# Configure ipykernel
#
python -m ipykernel install --name `basename ${ODC_ENVIRONMENT_NAME}` \
                            --display-name "$ODC_DISPLAY_NAME"

#
# Set permissions (development mode)
#
if [ ${ODC_ENVIRONMENT_MODE} == "development" ]
then
    chown -R $NB_USER:users ${ODC_ENVIRONMENT_NAME}
fi
