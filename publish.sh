#!/usr/bin/env bash

PROFILE="becod20"
TARGET_REGION="ap-northeast-2"
GHOSTSCRIPT_VERSION=9.52
LAYER_NAME='ghostscript'
LAYER_VERSION=$(
  aws --profile $PROFILE lambda publish-layer-version --region "$TARGET_REGION" \
    --layer-name $LAYER_NAME \
    --zip-file fileb://`pwd`/ghostscript.zip \
    --description "Ghostscript v${GHOSTSCRIPT_VERSION}" \
    --query Version \
    --output text
) 

aws --profile $PROFILE lambda add-layer-version-permission \
  --region "$TARGET_REGION" \
  --layer-name $LAYER_NAME \
  --statement-id sid1 \
  --action lambda:GetLayerVersion \
  --principal '*' \
  --query Statement \
  --output text \
  --version-number "$LAYER_VERSION"
