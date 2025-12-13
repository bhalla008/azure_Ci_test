#!/bin/bash
set -e

CSV_NAME=$1

# Azure DevOps provides this automatically
SOURCE_ROOT="${BUILD_SOURCESDIRECTORY}"

# CSV location inside repo
#CSV_FILE="$SOURCE_ROOT/deployment_list/$CSV_NAME"

# Target server path
TARGET_ROOT="$BUILD_ARTIFACTSTAGINGDIRECTORY"

CSV_DIR="$SOURCE_ROOT/deployment_list"
CSV_FILE="$CSV_DIR/$CSV_NAME"


echo "Source Repo      : $SOURCE_ROOT"
echo "CSV File         : $CSV_FILE"
echo "Target Directory : $TARGET_ROOT"

if [ ! -f "$CSV_FILE" ]; then
  echo "CSV file not found: $CSV_FILE"
  exit 1
fi

ls -l "$SOURCE_ROOT/deployment_list"

sed -i 's/\r$//' "$CSV_FILE"

cat "$CSV_FILE"

echo "Copying deployment_list directory"
mkdir -p "$TARGET_ROOT/deployment_list"
cp "$CSV_FILE" "$TARGET_ROOT/deployment_list/"


while IFS=',' read -r id filename extension
do
  [[ -z "$filename" || "$filename" == "filename" ]] && continue

  FULL_NAME="${filename}.${extension}"
  echo "Searching for $FULL_NAME"

 SOURCE_FILE=$(find "$SOURCE_ROOT" -type d \( -name "__azure_pipelines" -o -name "deployment_list" \) -prune -o -type f -name "$FULL_NAME" -print | head -n 1)

  
  if [ -z "$SOURCE_FILE" ]; then
    echo "File not found: $FULL_NAME"
    continue
  fi

  REL_PATH=$(dirname "${SOURCE_FILE#"$SOURCE_ROOT/"}")
  DEST_DIR="$TARGET_ROOT/$REL_PATH"

  mkdir -p "$DEST_DIR"
  cp "$SOURCE_FILE" "$DEST_DIR/"

  echo "Copied: $SOURCE_FILE → $DEST_DIR"

done < "$CSV_FILE"
