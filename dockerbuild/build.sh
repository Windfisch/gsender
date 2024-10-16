#!/bin/bash
set -eo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DIRECTORY="$1"

if [ x"$DIRECTORY" == x ]; then
	DIRECTORY="$PWD"
fi

echo "Building repo at $DIRECTORY"

echo "Building gsender-builder container (if not already cached)"
echo "using Dockerfile at $SCRIPT_DIR/container/"
podman build -t gsender-builder "$SCRIPT_DIR/container"
echo

echo 'Running build. (This will appear unresponsive for minutes on the first run. This is normal.)'
podman run --rm -it -v "$DIRECTORY":/gsender --uidmap 1234:0:1 --uidmap 0:1:1 gsender-builder
echo

echo "success. find your results in $DIRECTORY/output"
