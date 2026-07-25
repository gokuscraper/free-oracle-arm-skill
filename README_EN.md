# Free Oracle ARM Skill

[![简体中文](https://img.shields.io/badge/简体中文-red)](README.md)
[![English](https://img.shields.io/badge/English-blue)](README_EN.md)
[![License](https://img.shields.io/badge/License-MIT-yellow)](LICENSE)
[![Free](https://img.shields.io/badge/free-forever-success)](https://github.com/gokuscraper/free-oracle-arm-skill)
[![AI Agent](https://img.shields.io/badge/AI%20Agent-Skill-orange)](#)

> **Auto-grab Oracle Cloud Free Tier ARM instances.** A complete workflow covering environment setup, OCI CLI configuration, deploying the grabber script, WeChat notification, and post-creation backup & anti-reclaim steps.

---

## What Is This?

<p align="center">
  <img src="assets/terminal-screenshot.jpg" alt="Grabber script running, auto-polling every 60s">
  <br>
  <em>The grabber script running on a Linux server, retrying every 60 seconds</em>
</p>

<p align="center">
  <img src="assets/wechat-notification.jpg" alt="Server酱 WeChat push notification">
  <br>
  <em>Real-time WeChat notification when an instance is created</em>
</p>

An **AI agent skill** that empowers Claude Code, OpenClaw, Cursor, Codex, Gemini CLI, and other AI assistants with the ability to automatically grab Oracle Cloud Free Tier ARM instances.

Oracle Cloud's Always Free tier offers Ampere A1 (ARM) instances, currently at **2 OCPU / 12 GB RAM / 200 GB storage** (new policy since June 2026). Popular regions are often out of capacity, making manual creation nearly impossible.

---

## Why Use This Skill Instead of Doing It Manually?

| | Manual (refresh the console) | With This Skill |
|---|---|---|
| **Time** | You stare at the screen 24/7 | Submit once, AI runs in background |
| **Skill required** | OCI console, SSH, Linux | Zero experience needed, AI guides every step |
| **Success rate** | Can't watch 24/7, miss releases | Auto-retry every 60s, never misses |
| **Notification** | No way to know when you get one | Server酱 pushes to your WeChat |

---

## How It Works

```
User provides Oracle region + configuration
      ↓
AI guides installing OCI CLI + configuring API keys
      ↓
Deploys grab_arm.sh to a Linux server
      ↓
Every 60s → OCI API checks capacity → Available? → Create instance → WeChat notification
                    ↓ Not available
                Wait 60s, retry
```

---

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

---

*Keywords: oracle cloud free tier, arm instance grabber, oci arm autograb, oracle always free arm, free oracle vps, image to vector alternative, potrace alternative, auto tracer*
