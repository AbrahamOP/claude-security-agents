# Tier System

## Overview

Agents are split into two tiers based on their capabilities and risk profile.

## Tier 1 — Advisory Only

**No command execution.** These agents analyze, advise, and produce documents but never run commands against targets.

- Safe to use without scope declaration
- Produce reports, checklists, threat models, policies
- Can read and analyze files, logs, and configurations
- Tools: typically `Read, Grep, Glob` (no `Bash`, no `Write`)

**Agents**: `blue-siem-analyst`, `blue-email-analyst`, `blue-log-analyzer`, `red-privesc`, `red-cloud-attack`, `red-social-engineer`, `red-payload-craft`, `purple-adversary-emulation`, `purple-threat-model`, `purple-detection-gap`, `devsecops-code-review`, `devsecops-pipeline`, `grc-compliance-auditor`, `grc-risk-assessor`, `grc-audit-prep`, `ir-forensics`, `ir-malware-analyst`

## Tier 2 — Execution-Capable

**Can execute commands and write files.** These agents interact with systems, write detection rules, run scanning tools, or produce output files.

- **Scope declaration required** for offensive agents (red-*, purple-attack-detect-map)
- Enforce the [Scope Guard](../agents/_scope-guard.md) rules
- Tag commands with OPSEC level (PASSIVE/LIGHT/ACTIVE/LOUD)
- Must explain commands before execution

**Agents**: `blue-detection-rules`, `blue-threat-hunter`, `blue-ids-tuner`, `blue-forensics-triage`, `red-recon`, `red-webapp`, `red-api-security`, `red-ad-attack`, `purple-attack-detect-map`, `devsecops-container`, `devsecops-iac-scanner`, `devsecops-secrets-scanner`, `devsecops-k8s-security`, `grc-policy-writer`, `ir-incident-handler`, `ir-threat-intel`, `ir-playbook-builder`

## Quick Reference

| Category | Agent | Tier |
|----------|-------|------|
| **Blue Team** | blue-detection-rules | T2 |
| | blue-siem-analyst | T1 |
| | blue-threat-hunter | T2 |
| | blue-ids-tuner | T2 |
| | blue-email-analyst | T1 |
| | blue-log-analyzer | T1 |
| | blue-forensics-triage | T2 |
| **Red Team** | red-recon | T2 |
| | red-webapp | T2 |
| | red-api-security | T2 |
| | red-ad-attack | T2 |
| | red-privesc | T1 |
| | red-cloud-attack | T1 |
| | red-social-engineer | T1 |
| | red-payload-craft | T1 |
| **Purple Team** | purple-adversary-emulation | T1 |
| | purple-threat-model | T1 |
| | purple-attack-detect-map | T2 |
| | purple-detection-gap | T1 |
| **DevSecOps** | devsecops-code-review | T1 |
| | devsecops-container | T2 |
| | devsecops-pipeline | T1 |
| | devsecops-iac-scanner | T2 |
| | devsecops-secrets-scanner | T2 |
| | devsecops-k8s-security | T2 |
| **GRC** | grc-compliance-auditor | T1 |
| | grc-policy-writer | T2 |
| | grc-risk-assessor | T1 |
| | grc-audit-prep | T1 |
| **IR & Forensics** | ir-incident-handler | T2 |
| | ir-forensics | T1 |
| | ir-malware-analyst | T1 |
| | ir-threat-intel | T2 |
| | ir-playbook-builder | T2 |
