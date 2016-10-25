#!/bin/sh
# Fix permissions on the given directory to allow group read/write of
# regular files and execute of directories.
/bin/busybox chown -R gogs "$1"
/bin/busybox chgrp -R 0 "$1"
/bin/busybox chmod -R g+rw "$1"
/bin/busybox find "$1" -type d -exec /bin/busybox chmod g+x {} +