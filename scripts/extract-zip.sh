#!/bin/sh

# Ensure the script is called with a target directory
if [ $# -ne 1 ]; then
    echo "Usage: $0 <target_directory>"
    exit 1
fi

# Target directory for extraction
TARGET_DIR="$1"

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Create a temporary file to store the zip input
TEMP_ZIP=$(mktemp)

# Define cleanup function
cleanup() {
    rm -f "$TEMP_ZIP"
}
trap cleanup EXIT

# Save the standard input to the temporary file
cat > "$TEMP_ZIP"

# Extract the ZIP file to the target directory
echo "Extracting ZIP file to $TARGET_DIR..." >&2
unzip -q -d "$TARGET_DIR" "$TEMP_ZIP"
if [ $? -eq 0 ]; then
    echo "Extraction completed successfully."
else
    echo "Failed to extract the ZIP file." >&2
    exit 1
fi
