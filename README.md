# NETREAPER

```
 ███╗   ██╗███████╗████████╗██████╗ ███████╗ █████╗ ██████╗ ███████╗██████╗
 ████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗
 ██╔██╗ ██║█████╗     ██║   ██████╔╝█████╗  ███████║██████╔╝█████╗  ██████╔╝
 ██║╚██╗██║██╔══╝     ██║   ██╔══██╗██╔══╝  ██╔══██║██╔═══╝ ██╔══╝  ██╔══██╗
 ██║ ╚████║███████╗   ██║   ██║  ██║███████╗██║  ██║██║     ███████╗██║  ██║
 ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝
```

**Network Security & Penetration Testing Toolkit**

70+ tools. One CLI. Stop juggling terminals.

[![Version](https://img.shields.io/github/v/tag/Nerds489/NETREAPER?label=version&style=flat-square&color=ff0040)](https://github.com/Nerds489/NETREAPER/releases)
[![CI](https://github.com/Nerds489/NETREAPER/actions/workflows/ci.yml/badge.svg)](https://github.com/Nerds489/NETREAPER/actions)
[![License](https://img.shields.io/badge/license-Apache_2.0-00d4ff?style=flat-square)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Linux-ffaa00?style=flat-square)](https://github.com/Nerds489/NETREAPER)
[![Sponsor](https://img.shields.io/badge/sponsor-♥-ff69b4?style=flat-square)](https://github.com/sponsors/Nerds489)

---

## Installation

```bash
git clone https://github.com/Nerds489/NETREAPER.git
cd NETREAPER
sudo ./install.sh
```

Install tools:
```bash
sudo netreaper-install essentials  # Core tools (~500MB)
sudo netreaper-install all         # Everything (~3-5GB)
sudo netreaper-install wireless    # WiFi arsenal
sudo netreaper-install scanning    # Port scanners
sudo netreaper-install exploit     # Exploitation tools
sudo netreaper-install creds       # Password crackers
sudo netreaper-install osint       # Reconnaissance
```

---

## First 60 Seconds

```bash
# 1. See what's installed
netreaper status

# 2. Run a quick scan
sudo netreaper scan 192.168.1.0/24

# 3. Check your logs
ls ~/.netreaper/logs/

# 4. Get help
netreaper --help
```

---

## Why NETREAPER?

| Problem | Solution |
|---------|----------|
| 47 terminal windows, 20 tools, zero consistency | One entrypoint, unified logging, shared config |
| Reinstalling your stack on every new machine | Single installer, reproducible setup |
| Forgetting which flags work with which tool | Consistent interface, built-in presets |
| Scattered output files everywhere | Organized session-based output in `~/.netreaper/` |

---

## Dry-Run Mode

Preview commands without executing:

```bash
netreaper --dry-run scan 192.168.1.0/24
sudo netreaper-install --dry-run all
```

All commands print with `[DRY-RUN]` prefix instead of running.

---

## Features

- **70+ integrated tools** -- nmap, aircrack-ng, hashcat, hydra, and more
- **Multi-distro support** -- Debian, Ubuntu, Kali, Fedora, Arch, and more
- **Session management** -- Organized output in timestamped directories
- **Comprehensive logging** -- Full audit trail of all commands
- **Smart installer** -- Auto-detects distro, installs dependencies
- **Modular architecture** -- Easy to extend and customize

---

## Supported Distributions

| Family | Distros |
|--------|---------|
| Debian | Ubuntu, Kali, Parrot, Mint |
| RHEL | Fedora, CentOS, Rocky, Alma |
| Arch | Arch, Manjaro, EndeavourOS |
| SUSE | openSUSE Tumbleweed/Leap |

---

## Project Structure

```
NETREAPER/
├── bin/                 # Executables
│   ├── netreaper
│   └── netreaper-install
├── lib/                 # Core libraries
├── modules/             # Tool modules
├── tests/               # Test suites
├── docs/                # Documentation
└── completions/         # Shell completions
```

---

## Project History

NETREAPER has been in active development since early 2025 as an internal penetration testing toolkit.

The public GitHub repository was created December 9, 2025. Prior commit history exists only in local backups.

Expect rapid iteration until the v6.x architecture stabilizes.

---

## License

**Apache License 2.0** -- See [LICENSE](LICENSE)

No EULA. No additional terms. Use freely.

**Legal Notice:** Use only on systems you own or have explicit written permission to test. Unauthorized access is illegal.

---

## Links

- [Contributing](CONTRIBUTING.md)
- [Security Policy](SECURITY.md)
- [Support](docs/SUPPORT.md)
- [Releases](https://github.com/Nerds489/NETREAPER/releases)
- [Issues](https://github.com/Nerds489/NETREAPER/issues)

---

**© 2025 OFFTRACKMEDIA Studios**
