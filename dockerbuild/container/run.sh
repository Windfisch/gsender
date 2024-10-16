#!/bin/bash

set -eo pipefail

export UV_USE_IO_URING=0

cd /gsender
npm install --legacy-peer-deps --dev
npm run build-prod
npm run build:linux-x64

