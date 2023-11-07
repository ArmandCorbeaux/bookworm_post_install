#!/bin/bash

################################################################################
# 08 - ADD ZRAMSWAP
################################################################################
#
# Job :     Change boot style and enable amd_pstate if AMD CPU
#
# Author :  Armand CORBEAUX
# Date :    2023-11-07
#
# Impact :  whole system
#
# Inputs :  ZRAM_ALGO, ZRAM_PERCENT, ZRAM_PRIORITY
#           SYSCTL_VALUES
# Outputs : ZRAM_TARGET, SYSCTL_TARGET
#
# More informations :
#   https://en.wikipedia.org/wiki/Zram


ZRAM_ALGO="zstd"
ZRAM_PERCENT=400
ZRAM_PRIORITY=180

SYSCTL_VALUES=(
  "vm.page-cluster=0"
  "vm.swappiness=180"
  "vm.watermark_boost_factor=0"
  "vm.watermark_scale_factor=125"
  "vm.max_map_count = 2147483642"
)

ZRAM_TARGET="/etc/default/zramswap"
SYSCTL_TARGET="/etc/sysctl.conf"

# Update packages list
sudo apt update

# Install ZRAM
sudo apt install zram-tools -y

# ZRAM - uncomment and modify the values
sudo sed -i "s/#\s*ALGO=.*/ALGO=\"$ZRAM_ALGO\"/" $ZRAM_TARGET
sudo sed -i "s/#\s*PERCENT=.*/PERCENT=$ZRAM_PERCENT/" $ZRAM_TARGET
sudo sed -i "s/#\s*PRIORITY=.*/PRIORITY=$ZRAM_PRIORITY/" $ZRAM_TARGET

# Append values to sysctl.conf
for value in "${SYSCTL_VALUES[@]}"; do
  echo "$value" | sudo tee -a $SYSCTL_TARGET
done