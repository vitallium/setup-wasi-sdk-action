ARG SDK_VERSION=24
FROM ghcr.io/webassembly/wasi-sdk:wasi-sdk-${SDK_VERSION}

# Install curl
RUN apt-get update && apt-get install -y curl && apt-get clean
