#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom

repo init -u https://github.com/DerpFest-AOSP/manifest.git -b 14 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Eritsuu/local_manifests --depth 1 -b 14/derps .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# build
/opt/crave/resync.sh && repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all);
echo "============="
echo "Sync success"
echo "============="

# Private keys
git clone https://github.com/Eritsuu/vendor_lineage-priv_keys.git vendor/lineage-priv/keys

# Export
export BUILD_USERNAME=Eritsu
export BUILD_HOSTNAME=craveFt.Eritsu
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Set up build environment
. build/envsetup.sh;
echo "====== Envsetup Done ======="

# Lunch
lunch derp_Mi439_4_19-userdebug;
make installclean;
echo "====== MAKAN SIANG :) ======="

# Build ROM
mka derp;
