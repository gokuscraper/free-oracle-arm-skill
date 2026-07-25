# Free Oracle ARM Skill

[![简体中文](https://img.shields.io/badge/简体中文-red)](README.zh.md)
[![English](https://img.shields.io/badge/English-blue)](README.md)

> **Auto-grab Oracle Cloud Free Tier ARM instances.** A complete workflow covering environment setup, OCI CLI configuration, deploying the grabber script, WeChat notification, and post-creation backup & anti-reclaim steps.

## What Is This?

An **AI agent skill** that empowers Claude Code, Cursor, OpenClaw, and other AI assistants with the ability to automatically grab Oracle Cloud Free Tier ARM instances.

Oracle Cloud's Always Free tier offers Ampere A1 (ARM) instances, currently at **2 OCPU / 12 GB RAM / 200 GB storage** (new policy since June 2026). Popular regions are often out of capacity, making manual creation nearly impossible.

This skill guides the AI through the complete process:

- Environment check (confirm you have a Linux machine)
- Install OCI CLI + configure API keys
- Deploy the auto-retry grabber script (polls every 60s)
- Configure Server酱 WeChat push notification (optional)
- Run in background + monitor progress
- Post-creation setup (backup, firewall, anti-reclaim)
- Troubleshooting common issues

## Installation

### Claude Code

```bash
npx skills i gokuscraper/free-oracle-arm-skill
```

### Manual

Place the `free-oracle-arm-skill/` directory into your project's `.agents/skills/` folder.

## How to Use

After loading the skill, the AI will guide you through a 7-step workflow:

```
Step 0: Environment check
Step 1: Install OCI CLI + configure API
Step 2: Deploy the grabber script
Step 3: Configure WeChat notification (optional)
Step 4: Run in background
Step 5: Post-creation steps
Step 6: Troubleshooting
```

Just follow the AI's prompts and provide the requested information (SSH connection details, OCIDs, API keys, etc.).

## Prerequisites

- An [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/) account
- A Linux machine accessible via SSH (your free E2.1.Micro instance works)
- Basic SSH knowledge

## Project Structure

```
free-oracle-arm-skill/
├── SKILL.md              ← AI instruction file
├── README.zh.md          ← Chinese README
├── README.md             ← English README
└── scripts/
    └── grab_arm.sh       ← Grabber script (ready to use)
```

## Related

- [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/) — Oracle Cloud free tier
- [Server酱](https://sct.ftqq.com/) — WeChat push notification service
- [oci-arm-host-capacity](https://github.com/hitrov/oci-arm-host-capacity) — PHP-based grabber (1285 ⭐)

## License

MIT
