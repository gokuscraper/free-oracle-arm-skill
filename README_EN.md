# Free Oracle ARM Skill

[![简体中文](https://img.shields.io/badge/简体中文-red)](README.md)
[![English](https://img.shields.io/badge/English-blue)](README_EN.md)
[![License](https://img.shields.io/badge/License-MIT-yellow)](LICENSE)

> **Auto-grab Oracle Cloud Free Tier ARM instances.** A complete workflow covering environment setup, OCI CLI configuration, deploying the grabber script, WeChat notification, and post-creation backup & anti-reclaim steps.

## What Is This?

An **AI agent skill** that empowers Claude Code, OpenClaw, Cursor, Codex, Gemini CLI, and other AI assistants with the ability to automatically grab Oracle Cloud Free Tier ARM instances.

Oracle Cloud's Always Free tier offers Ampere A1 (ARM) instances, currently at **2 OCPU / 12 GB RAM / 200 GB storage** (new policy since June 2026). Popular regions are often out of capacity, making manual creation nearly impossible.

This skill guides the AI through the complete process:

- Environment check (confirm you have a Linux machine)
- Install OCI CLI + configure API keys
- Deploy the auto-retry grabber script (polls every 60s)
- Configure Server酱 WeChat push notification (optional)
- Run in background + monitor progress
- Post-creation setup (backup, firewall, anti-reclaim)
- Troubleshooting common issues

## Why Use This Skill?

- ✅ **Fully automated** — AI guides you step by step, no need to research docs manually
- ✅ **60s polling** — Retries automatically every 60 seconds, never misses released capacity
- ✅ **WeChat notification** — Real-time push via Server酱 when you get an instance
- ✅ **Anti-reclaim** — Built-in light CPU load to reduce risk of Oracle reclaiming your instance
- ✅ **Beginner friendly** — No SSH or Linux experience needed, AI holds your hand the whole way

---

## Installation

### OpenClaw (Recommended)

```bash
clawhub install free-oracle-arm-skill
```

Or search inside OpenClaw chat:

> "Install the free oracle arm skill from clawhub"

### Claude Code

```bash
npx skills i gokuscraper/free-oracle-arm-skill
```

### Other AI Assistants (Cursor, Codex, Gemini CLI, Windsurf)

```bash
# Universal installer — auto-detects your AI assistant
npx skills i gokuscraper/free-oracle-arm-skill
```

### openskills

```bash
npx openskills install gokuscraper/free-oracle-arm-skill
```

### Manual

Place the `free-oracle-arm-skill/` directory into your project's `.agents/skills/` folder.

---

## How to Use

After loading the skill, the AI will guide you through the process. Just follow the prompts and provide the requested information. **Even if you know nothing about Linux or SSH, the AI will tell you exactly what to do at every step.**

## Prerequisites

- An [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/) account (free to sign up)

> No technical background required. Don't have a Linux machine? The AI will guide you through using your free Oracle E2.1.Micro instance. Don't know SSH? The AI will teach you. Everything from scratch.

## Project Structure

```
free-oracle-arm-skill/
├── SKILL.md              ← AI instruction file
├── README.md             ← Chinese README
├── README_EN.md          ← English README
└── scripts/
    └── grab_arm.sh       ← Grabber script (ready to use)
```

## FAQ

**Q: Do I need a Linux machine to use this?**
Yes. The grabber script needs to run continuously on a Linux server (polls every 60s). But if you don't have one, the AI will guide you through setting it up on your free Oracle E2.1.Micro instance.

**Q: Do I need OCI CLI installed?**
The AI will guide you through installation and configuration. Nothing to prepare in advance.

**Q: I know nothing about Linux or SSH. Can I still use this?**
Absolutely. This skill is designed for beginners. The AI will walk you through every command and every step.

**Q: How long does it take to grab an instance?**
It varies. Popular regions (Osaka, Seoul) may take days or weeks. Less popular regions may succeed in minutes. The script keeps retrying until it succeeds.

**Q: Will Oracle reclaim my ARM instance?**
Oracle may reclaim long-idle ARM instances. The script includes a light CPU load feature to reduce the risk of reclaim.

**Q: Does the grabber script consume a lot of resources?**
No. The script itself is very lightweight — it just calls the OCI API once every 60 seconds. The CPU load script is also very light.

---

## License

MIT
