#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5dc7365c3ffbee001a2cc5cd/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5dc7365c3ffbee001a2cc5cd 
fi
curl -s -X POST https://api.stackbit.com/project/5dc7365c3ffbee001a2cc5cd/webhook/build/ssgbuild > /dev/null
jekyll build

curl -s -X POST https://api.stackbit.com/project/5dc7365c3ffbee001a2cc5cd/webhook/build/publish > /dev/null
