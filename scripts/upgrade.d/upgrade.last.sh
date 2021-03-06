#!/bin/bash

# Last available nextcloud version
next_version="16.0.0"

# Nextcloud tarball checksum sha256
nextcloud_source_sha256="4532f7028b1d9bf060f75ac4fbbde52a59ecd9c9155f3178a038d3cf3609402e"

# This function will only be executed upon applying the last upgrade referenced above
last_upgrade_operations () {
  # Patch nextcloud files only for the last version
  cp -a ../sources/patches_last_version/* ../sources/patches

  # Execute post-upgrade operations later on
  (cd /tmp ; at now + 10 minutes <<< "(cd $final_path ; sudo -u $app php occ db:add-missing-indices ; sudo -u $app php occ db:convert-filecache-bigint -n) > /tmp/${app}_maintenance.log")
}
