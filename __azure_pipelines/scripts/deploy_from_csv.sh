#!/bin/bash
set -e

CSV_NAME=$1

# Azure DevOps provides this automatically
SOURCE_ROOT="${BUILD_SOURCESDIRECTORY}"

# CSV location inside repo
CSV_FILE="$SOURCE_ROOT/deployment_list/$CSV_NAME"

# Target server path
TARGET_ROOT="$BUILD_ARTIFACTSTAGINGDIRECTORY"


echo "Source Repo      : $SOURCE_ROOT"
echo "CSV File         : $CSV_FILE"
echo "Target Directory : $TARGET_ROOT"

if [ ! -f "$CSV_FILE" ]; then
  echo "❌ CSV file not found: $CSV_FILE"
  exit 1
fi

while IFS=',' read -r id filename extension
do
  [[ -z "$filename" || "$filename" == "filename" ]] && continue

  FULL_NAME="${filename}.${extension}"
  echo "🔍 Searching for $FULL_NAME"

  SOURCE_FILE=$(find "$SOURCE_ROOT" \
    -type f \
    -name "$FULL_NAME" \
    ! -path "*/__azure_pipelines/*" \
    ! -path "*/deployment_list/*" \
    2>/dev/null | head -n 1)

  if [ -z "$SOURCE_FILE" ]; then
    echo "❌ File not found: $FULL_NAME"
    continue
  fi

  REL_PATH=$(dirname "${SOURCE_FILE#"$SOURCE_ROOT/"}")
  DEST_DIR="$TARGET_ROOT/$REL_PATH"

  mkdir -p "$DEST_DIR"
  cp "$SOURCE_FILE" "$DEST_DIR/"

  echo "✅ Copied: $SOURCE_FILE → $DEST_DIR"

done < "$CSV_FILE"
