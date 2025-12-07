#!/bin/bash
set -e

# -----------------------------
# Resolve paths safely
# -----------------------------
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../" && pwd)"

CSV_FILE="$REPO_ROOT/deploy-list.csv"
OUTPUT_DIR="$REPO_ROOT/searched_file"
OUTPUT_FILE="$OUTPUT_DIR/result.txt"

# -----------------------------
# Prepare output
# -----------------------------
mkdir -p "$OUTPUT_DIR"
> "$OUTPUT_FILE"

# -----------------------------
# Validate CSV
# -----------------------------
if [ ! -f "$CSV_FILE" ]; then
    echo "❌ deploy.csv not found at $CSV_FILE"
    exit 1
fi

# -----------------------------
# Read CSV and search files
# -----------------------------
while IFS=',' read -r id name ext; do
    # Skip empty or invalid lines
    [ -z "$name" ] || [ -z "$ext" ] && continue

    filename="${name}.${ext}"

    # Find ALL matching files (case-insensitive)
    found_paths=$(find "$REPO_ROOT" -type f -iname "$filename" 2>/dev/null | sort)

    if [ -z "$found_paths" ]; then
        echo "$filename - not present" >> "$OUTPUT_FILE"
    else
        while read -r path; do
            abs_path=$(readlink -f "$path")
            echo "$filename - $abs_path" >> "$OUTPUT_FILE"
        done <<< "$found_paths"
    fi

done < "$CSV_FILE"

# -----------------------------
# Print result for pipeline logs
# -----------------------------
echo "✅ File search completed."
echo "--------------------------------"
cat "$OUTPUT_FILE"
echo "--------------------------------"

