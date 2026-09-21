#!/bin/bash
set -e

MODEL_ID="Qwen/Qwen2.5-0.5B-Instruct"
QUANT="q4f16_1"
CONV_TEMPLATE="qwen2"
MODEL_NAME="Qwen2.5-0.5B"

echo "=== Downloading model ==="
huggingface-cli download ${MODEL_ID} --local-dir ./model

echo "=== Generating config ==="
mlc_llm gen_config ./model \
  --quantization ${QUANT} \
  --prefill-chunk-size 1024 \
  --conv-template ${CONV_TEMPLATE} \
  -o ./dist/${MODEL_NAME}-${QUANT}-MLC/

echo "=== Compiling for WebGPU ==="
mlc_llm compile ./dist/${MODEL_NAME}-${QUANT}-MLC/mlc-chat-config.json \
  --device webgpu \
  -o ./dist/libs/${MODEL_NAME}-${QUANT}-webgpu.wasm

echo "=== Done ==="
ls -la ./dist/libs/
