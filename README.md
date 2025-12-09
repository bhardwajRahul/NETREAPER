<div align="center">

# **NETREAPER**
 _   _      _   _____   _____  _____  _____   _____  _____  
| \ | |    | \ |  _  | |_   _||  ___||  _  | |  _  ||  _  | 
|  \| | ___|  \| | | |   | |  | |__  | | | | | |/' || | | | 
| . ` |/ _ \ . ` | | |   | |  |  __| | | | | |  /| || | | | 
| |\  |  __/ |\  \ \_/ /  _| |_ | |___\ \_/ / \ |_/ /\ \_/ / 
\_| \_/\___\_| \_/\___/   \___/ \____/ \___/   \___/  \___/  

### **Version 5.3.1 — Phantom Protocol**

<br>

![Version](https://img.shields.io/badge/Version-5.3.1-blueviolet?style=for-the-badge)  
![License](https://img.shields.io/badge/License-Apache_2.0-green?style=for-the-badge)  
![Status](https://img.shields.io/badge/Status-Active-red?style=for-the-badge)  
![Framework](https://img.shields.io/badge/Type-Offensive_Security-black?style=for-the-badge)

</div>

---

NETREAPER is an offensive-security framework built from necessity.  
It consolidates reconnaissance, wireless operations, scanning, exploitation, credential attacks, and post-exploitation utilities into a single, structured, menu-driven CLI.

---

## 🔥 Origin

NETREAPER began as a small wrapper to streamline repetitive device-testing workflows.  
Managing multiple tools, terminals, and commands quickly became inefficient, so the wrapper expanded — one tool at a time — until it evolved into a complete offensive-security framework.

The philosophy has always stayed the same:

> **Make the work faster.  
Make the work cleaner.  
Make the work easier.**

---

## ⚡ Features

- 70+ integrated security tools  
- Organized categories: Recon, Wireless, Scanning, Exploitation, Credentials, Post-Exploitation  
- Centralized logs, configs, and sessions at `~/.netreaper/`  
- Install everything or only the categories you need  
- Fast, lightweight, predictable CLI  
- Designed for **authorized** network & Wi-Fi assessments  

---

## 🚀 Installation

```bash
git clone https://github.com/Nerds489/NETREAPER.git
cd NETREAPER
sudo bash ./install.sh
netreaper
```

Install specific categories:

```bash
netreaper-install wireless
netreaper-install recon
netreaper-install scanning
```

---

## 📟 Menu Structure

```text
[ NETREAPER ]
----------------------------
1) Recon            2) Wireless
3) Scanning         4) Exploitation
5) Credentials      6) Post-Exploit
7) Sessions         8) Config
9) Logs             10) Exit
```

---

## 🧰 Arsenal Overview

| Category        | Description |
|-----------------|-------------|
| **Recon**       | Subdomain enumeration, OSINT, host discovery, service fingerprinting |
| **Wireless**    | Monitor mode, WPA handshake capture, deauth operations, cracking tools |
| **Scanning**    | Port scans, vulnerability scans, network mapping |
| **Exploitation**| Payload runners, exploit helpers, vulnerability modules |
| **Credentials** | Brute-forcing, dictionary attacks, credential utilities |
| **Post-Exploit**| Cleanup, persistence helpers, reporting utilities |
| **Utility**     | Logging tools, session management, config editing |

---

## ⚠️ Legal Use Only

NETREAPER is intended **solely** for authorized penetration testing and device assessment.

- Do **NOT** use this on networks or systems without explicit permission.  
- No warranty is provided.  
- You assume full responsibility for your actions.  

Unauthorized use may violate local, state, federal, or international laws.

---

## 🛠 Troubleshooting

- View logs at:  
  `~/.netreaper/logs/`  
- Help commands:  
  `netreaper --help`  
  `netreaper-install --help`  
- Ensure required tools are in `PATH`  
- Confirm your distribution supports dependencies  
- Submit issues or requests on GitHub  

---

## 📅 Roadmap

- **5.x** — refactoring, stability, improved validation  
- **5.5** — user profiles, favorites, alias support  
- **6.0** — plugin & module architecture for extensions  

(Roadmap subject to change.)

---

## 🤝 Contributing

Contributions are welcome:

- Keep code modular, readable, and maintainable  
- Document new modules and commands  
- Maintain consistency with existing patterns  
- Open an issue before large feature additions  

Pull requests are reviewed on a rolling basis.

---

## 📜 License & Attribution

NETREAPER is licensed under the **Apache License 2.0**.

- Copyright © 2025  
  **OFFTRACKMEDIA Studios** (ABN: 84 290 819 896)

Full license:  
See the `LICENSE` file in this repository.

Project notices & third-party attributions:  
See the `NOTICE` file.

Use of this project constitutes acceptance of the Apache 2.0 license and all applicable laws.
