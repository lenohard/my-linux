#!/bin/zsh
setproxy
rclone copy ~/mounts/galileo/Calibre_Library gd_alves:library -v --drive-use-created-date --no-update-modtime --checksum --size-only
rclone copy ~/mounts/galileo/Front  gd_alves:arch_upload -v --drive-use-created-date --no-update-modtime --ignore-existing

