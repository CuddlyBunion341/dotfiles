#!/bin/bash

set -euo pipefail

# --- Config ---
DEFAULT_MAX_SIZE_MB=500
ZIP_PREFIX="archive_part"
OUTPUT_DIR="zipped_parts"

# --- Help ---
print_help() {
  cat <<EOF
Usage: $(basename "$0") <directory> [max_size_mb]

Splits files from a directory into zip archives, each under a max size.
Useful for platforms like Discord with upload size limits.

Arguments:
  directory       Path to directory containing files to archive
  max_size_mb     Maximum size per zip file in MB (default: $DEFAULT_MAX_SIZE_MB)

Options:
  -h, --help      Show this help message

Example:
  $(basename "$0") ./my_folder 500
EOF
}

# --- Platform-aware file size function ---
file_size() {
  if [[ "$(uname)" == "Darwin" ]]; then
    stat -f%z "$1" # macOS
  else
    stat --printf="%s" "$1" # Linux
  fi
}

# --- Parse args ---
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  print_help
  exit 0
fi

if [[ $# -lt 1 ]]; then
  echo "❌ Error: Missing directory argument."
  print_help
  exit 1
fi

SOURCE_DIR="$1"
MAX_SIZE_MB="${2:-$DEFAULT_MAX_SIZE_MB}"

# Validate that MAX_SIZE_MB is a number
if ! [[ "$MAX_SIZE_MB" =~ ^[0-9]+$ ]]; then
  echo "❌ Error: max_size_mb must be a number."
  print_help
  exit 1
fi

MAX_SIZE_BYTES=$((MAX_SIZE_MB * 1024 * 1024))

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "❌ Error: Directory '$SOURCE_DIR' does not exist."
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

# --- Main ---
CURRENT_BATCH=()
CURRENT_SIZE=0
PART_INDEX=1

echo "📂 Scanning files in: $SOURCE_DIR"
echo "📦 Max size per archive: $MAX_SIZE_MB MB"
echo "📁 Output directory: $OUTPUT_DIR"

shopt -s nullglob
for FILE in "$SOURCE_DIR"/*; do
  [[ -f "$FILE" ]] || continue
  SIZE=$(file_size "$FILE")

  if ((SIZE > MAX_SIZE_BYTES)); then
    echo "⚠️  Skipping large file: $(basename "$FILE") (${SIZE} bytes)"
    continue
  fi

  if ((CURRENT_SIZE + SIZE > MAX_SIZE_BYTES && CURRENT_SIZE > 0)); then
    ZIP_NAME="$OUTPUT_DIR/${ZIP_PREFIX}${PART_INDEX}.zip"
    echo "📦 Creating $ZIP_NAME..."
    zip -j -q "$ZIP_NAME" "${CURRENT_BATCH[@]}"
    ((PART_INDEX++))
    CURRENT_BATCH=()
    CURRENT_SIZE=0
  fi

  CURRENT_BATCH+=("$FILE")
  CURRENT_SIZE=$((CURRENT_SIZE + SIZE))
done

if ((${#CURRENT_BATCH[@]} > 0)); then
  ZIP_NAME="$OUTPUT_DIR/${ZIP_PREFIX}${PART_INDEX}.zip"
  echo "📦 Creating $ZIP_NAME..."
  zip -j -q "$ZIP_NAME" "${CURRENT_BATCH[@]}"
fi

echo "✅ Done! Created zip files in '$OUTPUT_DIR'."
