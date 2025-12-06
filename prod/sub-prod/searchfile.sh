#!/bin/bash
set -e

# Absolute path of this script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Repo root (prod/sub-prod -> ../../)
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

CSV_FILE="$REPO_ROOT/deploy-list.csv"

echo "Script path   : $SCRIPT_DIR"
echo "Repo root     : $REPO_ROOT"
echo "CSV file path : $CSV_FILE"
echo "----------------------------------"

if [[ ! -f "$CSV_FILE" ]]; then
  echo "ERROR: deploy-list.csv not found!"
  exit 1
fi

echo "Contents of deploy-list.csv:"
echo "----------------------------------"
cat "$CSV_FILE"
echo "----------------------------------"
