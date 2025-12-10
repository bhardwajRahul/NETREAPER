```
 ███╗   ██╗███████╗████████╗██████╗ ███████╗ █████╗ ██████╗ ███████╗██████╗
 ████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
 ██╔██╗ ██║█████╗     ██║   ██████╔╝█████╗  ███████║██████╔╝█████╗  ██████╔╝
 ██║╚██╗██║██╔══╝     ██║   ██╔══██╗██╔══╝  ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
 ██║ ╚████║███████╗   ██║   ██║  ██║███████╗██║  ██║██║     ███████╗██║  ██║
 ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝

```

**v6.2.4 — Phantom Protocol**

70+ security tools. One CLI. Stop juggling terminals. v6.2.4 introduces modular dispatcher architecture, a centralized logging system with configurable levels and audit trails, smart privilege handling, comprehensive target validation with safety gates, and confirmation prompts for dangerous operations.

## v6.2.4 Changes

* **Modular Architecture:** Thin dispatcher (`bin/netreaper`) sources modular libs in dependency order
* **Logging System:** Centralized logging with levels (DEBUG–FATAL), daily log rotation, file logging under `~/.netreaper/logs/`, and audit trail for security operations
* **Privilege Handling:** Smart sudo helpers (`is_root`, `require_root`, `run_with_sudo`, `elevate_if_needed`, `can_get_root`) with clear error messages and non-interactive support
* **Safety Framework:** Target validation system with IP/CIDR/hostname validation, public IP warnings, protected IP blocking, and `NR_UNSAFE_MODE` bypass
* **Confirmation System:** `confirm()`, `confirm_dangerous()`, `prompt_input()`, `select_option()` with keyword gates for dangerous operations
* **Error Handling:** Unified exit codes, stack traces, `die()`, `assert()`, `try()` functions
* **Safe File Operations:** `safe_rm()`, `safe_mkdir()`, `safe_copy()`, `safe_move()` with protected path blocking

## v6.2.x Highlights

* Executables now live in `bin/` and are fronted by root-level wrappers (`netreaper`, `netreaper-install`) so CI, first-run tests, and legacy scripts that call `./netreaper` keep working.
* `install.sh` simply dispatches to `bin/netreaper-install`, keeping the repository root clean while exposing wrappers for local runs.
* Non-interactive mode detects `NR_NON_INTERACTIVE=1` or the absence of a TTY, skips the wizard, auto-accepts legal text, and keeps CI from hanging.
* Documentation, quickstart, and helper docs were rewritten to match the new layout; everything now lives under `docs/`.
* Official Bash, Zsh, and Fish completions ship in `completions/`; copy them into your shell's completion directory to enable them.
* Smoke tests under `tests/smoke/` validate the wrapper binaries plus `--version`/`--help`, mirroring how CI executes the toolkit.
* Apache 2.0 is the only license—there is no separate EULA or interactive legal prompt for automated environments.

## Installation

```bash
git clone https://github.com/Nerds489/NETREAPER.git
cd NETREAPER
sudo ./install.sh
```

`install.sh` now delegates straight to `bin/netreaper-install`. The repository root stays tidy while still exposing wrapper scripts (`./netreaper`, `./netreaper-install`) that mirror the system-wide binaries.

### Install options

```bash
sudo ./netreaper-install essentials  # Core tools (~500MB) from the repo wrapper
sudo ./netreaper-install all         # Everything (~3-5GB)
sudo ./netreaper-install wireless    # WiFi arsenal
sudo ./netreaper-install scanning    # Port scanners
sudo ./netreaper-install exploit     # Exploitation tools
sudo ./netreaper-install creds       # Password crackers
sudo ./netreaper-install osint       # Reconnaissance
```

After installation these wrappers land in `/usr/local/bin/`, so `sudo netreaper-install ...` works everywhere without the leading `./`.

**Works on:** Kali, Parrot, Ubuntu, Debian, Fedora, RHEL, Arch, Manjaro, openSUSE, Alpine

## First 60 Seconds

Running directly from the clone? Use `./netreaper` (wrapper) instead of `netreaper`. Both forward to the same `bin/` executable once installed.

```bash
# 1. See what's installed and ready
netreaper status

# 2. Run a quick network scan
sudo netreaper scan 192.168.1.0/24

# 3. Check your logs
ls ~/.netreaper/logs/

# 4. Get help
netreaper --help
```

## Non-Interactive & CI Mode

* NETREAPER treats `NR_NON_INTERACTIVE=1` or the absence of a TTY as a non-interactive session.
* Wrapper scripts in the repo root (`./netreaper`, `./netreaper-install`) mirror the installed binaries so CI can keep invoking the historical `./netreaper ...` paths.
* Simple prompts (`confirm`, `prompt_input`) use default values; dangerous operations are **blocked by default**.

### Authorization in Non-Interactive Mode

Authorization does **not** auto-accept by default in non-interactive mode. To enable auto-authorization for CI pipelines:

```bash
# Both flags are required for auto-authorization
NR_AUTO_AUTHORIZE_NON_INTERACTIVE=1 NR_UNSAFE_MODE=1 ./netreaper scan 192.168.1.1
```

### Dangerous Operations in Non-Interactive Mode

`confirm_dangerous()` blocks by default in non-interactive mode. To allow dangerous operations:

```bash
# Option 1: Enable unsafe mode (allows all dangerous ops)
NR_NON_INTERACTIVE=1 NR_UNSAFE_MODE=1 ./netreaper scan 8.8.8.8

# Option 2: Use NR_FORCE_DANGEROUS for specific scripts
NR_NON_INTERACTIVE=1 NR_FORCE_DANGEROUS=1 ./netreaper scan 8.8.8.8
```

### Menu Selections in Non-Interactive Mode

`select_option()` requires an explicit default index:

```bash
# Select option at index 0 (first option)
NR_NON_INTERACTIVE=1 NR_NON_INTERACTIVE_DEFAULT_INDEX=0 ./netreaper
```

## Why NETREAPER?

| Problem | NETREAPER Solution |
|---------|-------------------|
| 47 terminal windows, 20 tools, zero consistency | One entrypoint, unified logging, shared config |
| Reinstalling your stack on every new machine | Single installer, reproducible setup for fleets |
| Forgetting which flags work with which tool | Consistent interface, built-in presets |
| Scattered output files everywhere | Organized session-based output in `~/.netreaper/` |

## Logging System

NETREAPER provides centralized logging with configurable levels and automatic file logging.

### Log Levels

Control verbosity with `NETREAPER_LOG_LEVEL`:

```bash
NETREAPER_LOG_LEVEL=0 netreaper status   # DEBUG: show everything
NETREAPER_LOG_LEVEL=1 netreaper status   # INFO: default
NETREAPER_LOG_LEVEL=4 netreaper status   # ERROR: errors only
```

| Level | Value | Shows |
|-------|-------|-------|
| DEBUG | 0 | Everything including debug messages |
| INFO | 1 | Normal operation messages (default) |
| SUCCESS | 2 | Success messages and above |
| WARNING | 3 | Warnings and errors |
| ERROR | 4 | Errors only |
| FATAL | 5 | Fatal errors only |

### File Logging

Logs are written to two locations:

* **Session log:** `~/.netreaper/logs/netreaper_YYYYMMDD.log` — all log messages
* **Audit log:** `~/.netreaper/logs/audit_YYYYMMDD.log` — security-relevant operations only

Disable file logging with `NETREAPER_FILE_LOGGING=0`:

```bash
NETREAPER_FILE_LOGGING=0 netreaper scan 192.168.1.1
```

### Log Functions

| Function | Purpose |
|----------|---------|
| `log_debug` | Debug messages (level 0) |
| `log_info` | Informational messages (level 1) |
| `log_success` | Success messages (level 2) |
| `log_warning` | Warning messages (level 3) |
| `log_error` | Error messages (level 4) |
| `log_fatal` | Fatal error messages (level 5) |
| `log_audit` | Write to audit log regardless of level |

## Privilege Handling

NETREAPER provides smart privilege management with clear error messages.

### Functions

| Function | Purpose |
|----------|---------|
| `is_root` | Check if running as root (exit code only) |
| `require_root` | Exit with error if not root |
| `run_with_sudo` | Run a command with sudo if not already root |
| `elevate_if_needed` | Re-exec the script with sudo if not root |
| `can_get_root` | Check if sudo is available and user can elevate |

### Non-Interactive Behavior

In non-interactive mode (`NR_NON_INTERACTIVE=1`):
* `require_root` exits immediately if not root (no prompt)
* `run_with_sudo` attempts sudo without password prompt
* `elevate_if_needed` fails gracefully if sudo requires a password

```bash
# Running as non-root in CI will fail cleanly instead of hanging
NR_NON_INTERACTIVE=1 netreaper wifi monitor wlan0
```

## Target Validation & Safety

NETREAPER validates all targets before operations to prevent accidental damage.

### Validation System

`validate_target()` performs:

1. **Format validation:** IP address, CIDR range, or hostname
2. **DNS resolution:** Hostnames are resolved to verify reachability
3. **Public/Private detection:** Private RFC1918 addresses pass; public IPs trigger warnings
4. **Protected IP blocking:** Loopback, multicast, broadcast, link-local, and reserved ranges are blocked

### Public IP Confirmation

When targeting a public IP, NETREAPER requires explicit confirmation:

```bash
$ netreaper scan 8.8.8.8
[WARNING] Target 8.8.8.8 is a PUBLIC IP address
[WARNING] Scanning public IPs may be illegal without authorization
Type 'I HAVE PERMISSION' to confirm: I HAVE PERMISSION
[INFO] Proceeding with scan...
```

### Unsafe Mode

Bypass safety checks with `NR_UNSAFE_MODE`. Accepts: `1`, `true`, `yes`, `y` (case-insensitive):

```bash
# Skip all target validation and confirmations
NR_UNSAFE_MODE=1 netreaper scan 8.8.8.8

# Alternative truthy values
NR_UNSAFE_MODE=true netreaper scan 8.8.8.8
NR_UNSAFE_MODE=yes netreaper scan 8.8.8.8

# Useful for scripting with known-safe targets
NR_UNSAFE_MODE=1 netreaper scan 192.168.1.0/24
```

### Protected IP Ranges

The following ranges are always blocked (even with `NR_UNSAFE_MODE`):

* `127.0.0.0/8` — Loopback
* `224.0.0.0/4` — Multicast
* `255.255.255.255` — Broadcast
* `169.254.0.0/16` — Link-local
* `0.0.0.0/8` — Reserved

## Confirmation System

NETREAPER provides confirmation prompts for user interaction.

### Functions

| Function | Purpose |
|----------|---------|
| `confirm` | Yes/no prompt, returns 0 for yes |
| `confirm_dangerous` | Requires typing a keyword to confirm |
| `prompt_input` | Prompt for text input with optional validation |
| `select_option` | Display numbered menu and get selection |

### Examples

```bash
# Simple yes/no (default: no)
if confirm "Proceed with scan?"; then
    run_scan
fi

# Dangerous operation requiring keyword
if confirm_dangerous "Delete all captures?" "DELETE"; then
    rm -rf "$CAPTURE_DIR"/*
fi
```

### Non-Interactive Mode

All confirmation functions respect `NR_NON_INTERACTIVE`:

* `confirm` — Returns the default value (configurable)
* `confirm_dangerous` — **Blocked by default**; auto-accepts only if `NR_UNSAFE_MODE` or `NR_FORCE_DANGEROUS` is set
* `prompt_input` — Returns default or empty string
* `select_option` — Requires `NR_NON_INTERACTIVE_DEFAULT_INDEX` to be set; fails otherwise

## Dry-Run Mode

Preview what commands would run without executing:

```bash
netreaper --dry-run scan 192.168.1.0/24
sudo netreaper --dry-run wifi monitor wlan0
```

All commands print with `[DRY-RUN]` prefix instead of executing. Safe to test.

## Shell Completions

NETREAPER ships shell completions in `completions/`—copy them into your shell's completion path and reload.

### Bash

```bash
sudo cp completions/netreaper.bash /etc/bash_completion.d/netreaper
source /etc/bash_completion
```

### Zsh

```bash
mkdir -p ~/.zsh/completions
cp completions/netreaper.zsh ~/.zsh/completions/_netreaper
echo 'fpath=(~/.zsh/completions $fpath)' >> ~/.zshrc
autoload -U compinit && compinit
```

### Fish

```bash
mkdir -p ~/.config/fish/completions
cp completions/netreaper.fish ~/.config/fish/completions/netreaper.fish
```

## Usage

```bash
sudo netreaper                      # Interactive menu
sudo netreaper scan 192.168.1.0/24  # Scan subnet
sudo netreaper wifi monitor wlan0   # Enable monitor mode
sudo netreaper wizard scan          # Guided wizard
sudo netreaper status               # Show tool status
netreaper --help                    # Full help
netreaper config path               # Show config directory
```

### Advanced Examples

```bash
# Preview scan without executing
netreaper --dry-run scan 10.0.0.0/24

# Scan public IP with confirmation
sudo netreaper scan 203.0.113.1
# Type 'I HAVE PERMISSION' when prompted

# Bypass safety for scripting (accepts 1, true, yes, y)
NR_UNSAFE_MODE=1 sudo netreaper scan 192.168.1.0/24
NR_UNSAFE_MODE=true sudo netreaper scan 192.168.1.0/24

# Debug output with file logging disabled
NETREAPER_LOG_LEVEL=0 NETREAPER_FILE_LOGGING=0 netreaper status

# CI/headless with full auto-authorization (dangerous operations allowed)
NR_NON_INTERACTIVE=1 NR_UNSAFE_MODE=1 NR_AUTO_AUTHORIZE_NON_INTERACTIVE=1 \
    sudo netreaper scan 192.168.1.1

# CI/headless with menu selection (select first option)
NR_NON_INTERACTIVE=1 NR_NON_INTERACTIVE_DEFAULT_INDEX=0 netreaper

# Force dangerous operations in non-interactive mode
NR_NON_INTERACTIVE=1 NR_FORCE_DANGEROUS=1 sudo netreaper scan 8.8.8.8
```

## What's In It

| Category | Tools |
|----------|-------|
| Recon | nmap, masscan, rustscan, netdiscover, dnsenum, sslscan |
| Wireless | aircrack-ng, wifite, bettercap, reaver, hcxdumptool, mdk4 |
| Exploit | metasploit, sqlmap, nikto, gobuster, nuclei, wpscan |
| Creds | hashcat, john, hydra, medusa, crackmapexec |
| Traffic | tcpdump, wireshark, tshark, hping3, iperf3 |
| OSINT | theharvester, recon-ng, shodan, amass, subfinder |

Plus 40+ more. Run `netreaper status` for the full list.

## Testing & QA

* `tests/smoke/test_help.sh` and `tests/smoke/test_version.sh` exercise the wrapper binaries exactly how CI calls them.
* Set `NR_NON_INTERACTIVE=1` (or rely on the default TTY detection) so the wizard and legal prompts are skipped automatically.
* Full Bats coverage still lives under `tests/*.bats` for module-level validation.

```bash
chmod +x tests/smoke/*.sh
NR_NON_INTERACTIVE=1 tests/smoke/test_help.sh
NR_NON_INTERACTIVE=1 tests/smoke/test_version.sh
bats tests/*.bats
```

## Architecture

```
NETREAPER/
├── netreaper              # Root wrapper → bin/netreaper
├── netreaper-install      # Root wrapper → bin/netreaper-install
├── bin/
│   ├── netreaper              # Thin dispatcher (sources libs, routes commands)
│   └── netreaper-install      # Arsenal installer
├── lib/
│   ├── version.sh             # VERSION + NETREAPER_ROOT (single source of truth)
│   ├── core.sh                # Logging, colors, paths, sudo helpers, error handling
│   ├── ui.sh                  # Banners, menus, confirmation prompts, input validators
│   ├── safety.sh              # Target validation (IP/CIDR/hostname, public/private)
│   ├── detection.sh           # Distro and package manager detection
│   └── utils.sh               # File operations, tool checks, helpers
├── modules/
│   ├── recon.sh               # Network reconnaissance
│   ├── wireless.sh            # WiFi operations
│   ├── scanning.sh            # Port scanning
│   ├── exploit.sh             # Exploitation tools
│   ├── credentials.sh         # Password cracking
│   ├── traffic.sh             # Packet analysis
│   └── osint.sh               # OSINT gathering
├── tests/
│   ├── smoke/                 # Quick validation tests
│   └── *.bats                 # Full test suite
├── docs/                      # Documentation set
├── completions/               # Shell completions (bash, fish, zsh)
├── VERSION                    # Version number (read by lib/version.sh)
└── install.sh                 # Wrapper installer (delegates to bin/)
```

### Library Responsibilities

| Library | Purpose |
|---------|---------|
| `version.sh` | Exports `VERSION` and `NETREAPER_ROOT`; sourced first |
| `core.sh` | Logging (`log_*`), colors, exit codes, error handling (`die`, `assert`, `try`), sudo helpers |
| `ui.sh` | Banners, menus, `confirm()`, `confirm_dangerous()`, `prompt_input()`, `select_option()`, input validators |
| `safety.sh` | `validate_target()`, IP/CIDR validation, public IP warnings, authorization checks |
| `detection.sh` | `detect_system()`, distro family detection, package manager selection |
| `utils.sh` | `safe_rm()`, `safe_mkdir()`, `safe_copy()`, `safe_move()`, tool path helpers |

### Environment Variables

| Variable | Purpose | Default |
|----------|---------|---------|
| `NR_UNSAFE_MODE` | Bypass target validation and dangerous op gates (accepts: `1`, `true`, `yes`, `y`) | `0` |
| `NR_NON_INTERACTIVE` | Skip interactive prompts, use defaults | `0` |
| `NR_DRY_RUN` | Preview commands without executing | `0` |
| `NR_FORCE_DANGEROUS` | Auto-accept `confirm_dangerous()` in non-interactive mode | `0` |
| `NR_AUTO_AUTHORIZE_NON_INTERACTIVE` | Allow auto-authorization in non-interactive mode (requires `NR_UNSAFE_MODE`) | `0` |
| `NR_NON_INTERACTIVE_DEFAULT_INDEX` | Default option index (0-based) for `select_option()` in non-interactive mode | unset |
| `NETREAPER_LOG_LEVEL` | Minimum log level (0-5) | `1` (INFO) |
| `NETREAPER_FILE_LOGGING` | Enable file logging | `1` |

## What It Does

* Wraps dozens of tools with unified logging/output.
* Organizes everything under `~/.netreaper/` per session.
* Validates targets and blocks obviously dangerous operations by default.
* Logs each command in timestamped audit trails (`~/.netreaper/logs/audit_*.log`).
* Centralized logging system with configurable log levels (DEBUG–FATAL).
* Smart privilege handling with clear error messages when root is required.
* Detects your distro and runs the appropriate package manager.

## What It Doesn't Do

* Replace your knowledge of the underlying tools.
* Give you permission to test things you don't own.
* Make unauthorized access legal.

## Project History

NETREAPER has been in active development and private use since early 2025 as an internal penetration testing toolkit. The public GitHub repository was created on December 9, 2025 after an OS reflash; prior commit history exists only in local backups. Expect rapid iteration until the v6.x module-based architecture fully stabilizes.

## Legal

Apache License 2.0 — see `LICENSE`. Authorized testing only; you need written permission for any system you test. You are responsible for your actions. No EULA. No additional terms.

## Support

If NETREAPER saves you time, consider sponsoring or opening a discussion/issue for feedback.

---

© 2025 OFFTRACKMEDIA Studios — Apache 2.0
