#!/bin/bash

SDK_VERSION_MAJOR=${1:-24}
SDK_VERSION=${2:-24.0}
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
    ARCH="x86_64"
elif [ "$ARCH" = "aarch64" ]; then
    ARCH="arm64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

DOWNLOAD_URL="https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${SDK_VERSION_MAJOR}/wasi-sdk-${SDK_VERSION}-${ARCH}-${OS}.deb"

echo "Downloading WASI SDK version ${SDK_VERSION} for ${OS}-${ARCH} via ${DOWNLOAD_URL}"
wget "${DOWNLOAD_URL}"

echo "WASI SDK ${SDK_VERSION} has been downloaded."
