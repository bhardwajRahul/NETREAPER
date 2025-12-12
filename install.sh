#!/usr/bin/env bash
# NETREAPER Installer Wrapper
# Calls bin/netreaper-install with all arguments

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#═══════════════════════════════════════════════════════════════════════════════
# LEGACY CLEANUP (MANDATORY)
#═══════════════════════════════════════════════════════════════════════════════
# Hard-delete legacy monolithic netreaper (v5.1.0) - it is broken and unsupported
# Bug: "sudo: Argument list too long" - causes complete failure
_legacy_found=0
for legacy_bin in /usr/local/bin/netreaper /usr/local/bin/netreaper-install; do
    if [[ -f "$legacy_bin" ]]; then
        if [[ $_legacy_found -eq 0 ]]; then
            echo "[!] Legacy install detected - removing broken v5.1.0 monolith" >&2
            _legacy_found=1
        fi
        sudo rm -f "$legacy_bin" 2>/dev/null || rm -f "$legacy_bin" 2>/dev/null || {
            echo "[!] ERROR: Could not remove $legacy_bin - run with sudo" >&2
        }
    fi
done
[[ $_legacy_found -eq 1 ]] && echo "[*] Modular version (v6.x) will be installed" >&2 || true

#═══════════════════════════════════════════════════════════════════════════════
# INSTALLER
#═══════════════════════════════════════════════════════════════════════════════
if [[ ! -x "$SCRIPT_DIR/bin/netreaper-install" ]]; then
    echo "ERROR: bin/netreaper-install not found or not executable"
    exit 1
fi

exec "$SCRIPT_DIR/bin/netreaper-install" "$@"
