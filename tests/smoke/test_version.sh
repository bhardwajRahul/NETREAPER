#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)

echo "Testing --version..."
version=$("$ROOT/bin/netreaper" --version 2>&1)
echo "Got: $version"

if [[ "$version" == *"6."* ]]; then
    echo "PASS: version contains 6.x"
else
    echo "FAIL: unexpected version"
    exit 1
fi
