ARG WASI_SDK_MAJOR_VERSION="24"
ARG WASI_SDK_VERSION="24.0"
ARG GITHUB_TOKEN

FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y cmake ninja-build make autoconf autogen automake libtool wget && \
    rm -rf /var/lib/apt/lists/*

# RUN (type -p wget >/dev/null || (apt-get update && apt-get install --no-install-recommends -y wget)) \
#     && mkdir -p -m 755 /etc/apt/keyrings \
#     && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
#     && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
#     && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
#     && apt-get update \
#     && apt-get install --no-install-recommends -y gh

# RUN gh release -R "WebAssembly/wasi-sdk download wasi-sdk-${WASI_SDK_VERSION}" --pattern '*.deb' --clobber

COPY download_sdk.sh /download_sdk.sh
RUN chmod +x /download_sdk.sh

RUN /download_sdk.sh "${WASI_SDK_MAJOR_VERSION}" "${WASI_SDK_VERSION}" && \
    case $(dpkg --print-architecture) in \
    amd64) dpkg -i wasi-sdk-*-x86_64-linux.deb ;; \
    arm64) dpkg -i wasi-sdk-*-arm64-linux.deb ;; \
    *) exit 1 ;; \
    esac && \
    rm wasi-sdk-*.deb

ENV CC=/opt/wasi-sdk/bin/clang
ENV CXX=/opt/wasi-sdk/bin/clang++
ENV LD=/opt/wasi-sdk/bin/wasm-ld
ENV AR=/opt/wasi-sdk/bin/llvm-ar
ENV RANLIB=/opt/wasi-sdk/bin/llvm-ranlib
