#!/bin/bash

# Temporary directory to store the generated keys
KEY_DIR=$(mktemp -d)

# Ensure cleanup on exit
cleanup() {
    rm -rf "$KEY_DIR"
}
trap cleanup EXIT

# Generate SSH keys
echo "Generating SSH keys..." >&2
ssh-keygen -t rsa -f "$KEY_DIR/ssh_host_rsa_key" -N "" -q
ssh-keygen -t ecdsa -f "$KEY_DIR/ssh_host_ecdsa_key" -N "" -q
ssh-keygen -t ed25519 -f "$KEY_DIR/ssh_host_ed25519_key" -N "" -q

# Zip the keys and write the ZIP file to stdout
echo "Zipping keys..." >&2
zip -j - "$KEY_DIR"/* 2>/dev/null

# Cleanup will happen automatically on exit
