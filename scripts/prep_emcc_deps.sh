#!/bin/bash
set -e

# Emscriptenのバージョンを固定（MLC-LLM v0.19.0推奨）
EMCC_VERSION="3.1.56"

echo "=== Installing Emscripten ${EMCC_VERSION} ==="
git clone https://github.com/emscripten-core/emsdk.git /tmp/emsdk
cd /tmp/emsdk
./emsdk install ${EMCC_VERSION}
./emsdk activate ${EMCC_VERSION}
source ./emsdk_env.sh

echo "=== Emscripten version ==="
emcc --version

# 環境変数を後続ステップに引き継ぐ
echo "EMSDK=/tmp/emsdk" >> $GITHUB_ENV
echo "PATH=/tmp/emsdk:/tmp/emsdk/upstream/emscripten:$PATH" >> $GITHUB_ENV
