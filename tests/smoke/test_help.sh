#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)

echo "Testing --help..."
"$ROOT/bin/netreaper" --help >/dev/null
echo "PASS: --help"

echo "Testing netreaper-install --help..."
"$ROOT/bin/netreaper-install" --help >/dev/null
echo "PASS: netreaper-install --help"
