# Free Oracle ARM Skill

[![简体中文](https://img.shields.io/badge/简体中文-red)](README.md)
[![English](https://img.shields.io/badge/English-blue)](README_EN.md)

> **在 Oracle Cloud Free Tier 上自动抢 ARM 实例。** 引导你完成从环境准备、OCI CLI 配置、部署抢机脚本、微信通知，到抢到后的备份与防回收的全流程。

## 这是什么？

一个 **AI agent skill**，让 Claude Code、Cursor、OpenClaw 等 AI 助手具备自动抢 Oracle Cloud 免费 ARM 实例的能力。

Oracle Cloud 的 Always Free 层提供 Ampere A1（ARM）实例，但目前免费额度为 **2 OCPU / 12 GB 内存 / 200 GB 存储**（2026年6月起新政策）。由于热门区域资源紧张，手动创建经常会遇到 `Out of host capacity`。

这个 skill 会引导 AI 助手一步步完成抢机全流程：

- 环境检测（确认有可用的 Linux 机器）
- 安装 OCI CLI + 配置 API 密钥
- 部署自动抢机脚本（每60秒重试）
- 配置 Server酱 微信通知（抢到自动推送）
- 后台运行 + 查看进度
- 抢到后的备份、防火墙、防回收处理
- 常见故障排查

## 安装

### Claude Code

```bash
npx skills i gokuscraper/free-oracle-arm-skill
```

### 手动

将 `free-oracle-arm-skill/` 目录放入项目的 `.agents/skills/` 文件夹中。

## 使用方法

加载 skill 后，AI 会自动引导你操作。你只需要根据 AI 的提示提供信息即可。

## 先决条件

- 一个 [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/) 账号
- 一台可以 SSH 连接的 Linux 机器（可以是甲骨文赠送的 E2.1.Micro 实例）
- 基本的 SSH 使用经验

## 项目结构

```
free-oracle-arm-skill/
├── SKILL.md              ← AI 指令文件
├── README.md             ← 中文说明
├── README_EN.md          ← English README
└── scripts/
    └── grab_arm.sh       ← 抢机脚本（可直接使用）
```

## 相关项目

- [Oracle Cloud Free Tier](https://www.oracle.com/cloud/free/) — 甲骨文云免费套餐
- [Server酱](https://sct.ftqq.com/) — 微信推送服务
- [oci-arm-host-capacity](https://github.com/hitrov/oci-arm-host-capacity) — PHP 版抢机脚本（1285 ⭐）

## License

MIT
