#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/.."

# check does it need to publish
if [[ -n $DO_NOT_PUBLISH_TAR ]]; then
  echo "Skipping publishing install wrapper"
  exit 0
fi

# check channel and tag
eval "$(ci/channel-info.sh)"

if [[ -n "$CI_TAG" ]]; then
  CHANNEL_OR_TAG=$CI_TAG
else
  CHANNEL_OR_TAG=$CHANNEL
fi

if [[ -z $CHANNEL_OR_TAG ]]; then
  echo +++ Unable to determine channel or tag to publish into, exiting.
  exit 0
fi

# upload install script
source ci/upload-ci-artifact.sh

cat >release.dolly.com-install <<EOF
SOLANA_RELEASE=$CHANNEL_OR_TAG
SOLANA_INSTALL_INIT_ARGS=$CHANNEL_OR_TAG
SOLANA_DOWNLOAD_ROOT=https://release.dolly.com
EOF
cat install/dolly-install-init.sh >>release.dolly.com-install

echo --- AWS S3 Store: "install"
upload-s3-artifact "/dolly/release.dolly.com-install" "s3://release.dolly.com/$CHANNEL_OR_TAG/install"
echo Published to:
ci/format-url.sh https://release.dolly.com/"$CHANNEL_OR_TAG"/install
