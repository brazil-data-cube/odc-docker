#!/bin/bash
#
# This file is part of ODC Docker.
# Copyright (C) 2021 INPE.
#
# ODC Docker is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

set -eou pipefail

#
# Open Data Cube user environment (Standard permissions)
#
./install.sh -e odc -d "Python (Open Data Cube)"

#
# Open Data Cube development environment (Allow packages installation from conda and pip)
#
if [ $1 -eq 1 ]
then
    echo -e "\e[31m Warning! The development mode gives too much power to the container user\e[0m"
    echo -e "> \e[31m With great power comes great responsibility\e[0m"

    ./install.sh -e odc-dev -d "Python (Open Data Cube Development)" -m development

    # jovyan as root
    echo "$NB_USER ALL=(ALL:ALL) ALL" >> /etc/sudoers
    adduser $NB_USER sudo
    echo "$NB_USER:$NB_USER" | chpasswd
fi
