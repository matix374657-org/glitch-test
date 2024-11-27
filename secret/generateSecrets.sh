#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <relative target folder name>"
  exit 1
fi

scriptDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sshPath="$scriptDir/$1"

echo "ssh path: $sshPath"

mkdir -p "$sshPath"

ssh-keygen -t rsa -b 4096 -f "$sshPath/id_rsa" -q -N ""

cat "$sshPath/id_rsa" | base64 -w 0 > "$sshPath/id_rsa64"