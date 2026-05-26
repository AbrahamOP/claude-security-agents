# Usage Examples

Claude Code automatically routes your task to the right agent. Just describe what you need in natural language.

---

## Blue Team

### Write detection rules
```
"Write a Sigma rule for detecting DCSync attacks via Event ID 4662"
→ blue-detection-rules
→ Output: Sigma YAML with ATT&CK T1003.006, SPL translation, FP tuning notes
```

### Triage SIEM alerts
```
"I have a Wazuh alert for rule 5712 — multiple auth failures from 185.220.101.x. Triage it."
→ blue-siem-analyst
→ Output: Triage report with verdict, IOCs, correlation, recommended actions
```

### Hunt for threats
```
"Hunt for signs of credential dumping in these Windows event logs"
→ blue-threat-hunter
→ Output: Hunt report with hypothesis, queries (SPL/KQL), findings, ATT&CK mapping
```

### Tune IDS rules
```
"This Suricata SID 2024897 is firing on legitimate traffic to our CDN. Tune it."
→ blue-ids-tuner
→ Output: Updated rule with threshold/suppress, validation steps
```

### Analyze suspicious email
```
"Analyze this email — the From says support@microsoft.com but Reply-To is different"
→ blue-email-analyst
→ Output: Verdict (MALICIOUS/SUSPICIOUS/LEGITIMATE), SPF/DKIM/DMARC, IOCs
```

### Parse logs
```
"Parse these Apache access logs and identify brute force attempts, path traversal, and SQLi"
→ blue-log-analyzer
→ Output: Structured events, timeline, correlation, IOCs extracted
```

### Live triage
```
"This server may be compromised — collect volatile data before we image it"
→ blue-forensics-triage
→ Output: Triage checklist with commands, collected artifacts, initial findings
```

---

## Red Team

### Reconnaissance
```
"Enumerate the attack surface for target.example.com — subdomains, open ports, tech stack"
→ red-recon
→ Output: Recon report with hosts, services, technologies, attack surface summary
```

### Web application testing
```
"Test this login form for SQL injection and authentication bypass"
→ red-webapp
→ Output: Findings with OWASP category, severity, PoC, remediation
```

### API security testing
```
"Test this GraphQL API for IDOR, broken authorization, and injection"
→ red-api-security
→ Output: API security findings with severity, PoC requests, remediation
```

### Active Directory attacks
```
"Enumerate this AD environment and find a path to Domain Admin"
→ red-ad-attack
→ Output: Attack path with BloodHound analysis, Kerberoast results, lateral movement options
```

### Privilege escalation
```
"I have a shell as www-data on Ubuntu 22.04. What are my privesc options?"
→ red-privesc
→ Output: Ranked escalation paths with commands, reliability, and noise level
```

### Cloud attacks
```
"I found AWS credentials in a public repo. Map the attack paths."
→ red-cloud-attack
→ Output: IAM escalation paths, data exposure assessment, lateral movement options
```

### Payload crafting
```
"I need a Python reverse shell that bypasses basic AV detection"
→ red-payload-craft
→ Output: Payload options with encoding, evasion techniques, detection notes
```

---

## Purple Team

### Attack-to-detection mapping
```
"Map T1059.001 (PowerShell) — show me both the attack procedure and the detection rule"
→ purple-attack-detect-map
→ Output: Dual document — attack commands on one side, Sigma + SPL rules on the other
```

### Adversary emulation
```
"Plan an adversary emulation exercise based on APT29 TTPs for our SOC team"
→ purple-adversary-emulation
→ Output: Emulation plan with phases, TTP table, detection expectations
```

### Threat modeling
```
"Threat model this microservices architecture with a public API, queue, and database"
→ purple-threat-model
→ Output: STRIDE analysis, ranked threat table, data flow diagram, mitigations
```

### Detection gap analysis
```
"Assess our SIEM detection coverage against ATT&CK and find the top 10 gaps"
→ purple-detection-gap
→ Output: ATT&CK coverage heatmap assessment, prioritized gap list with recommended rules
```

---

## DevSecOps

### Security code review
```
"Review this Python Flask app for security vulnerabilities"
→ devsecops-code-review
→ Output: Findings with CWE, OWASP mapping, file:line, severity, remediation
```

### Container hardening
```
"Audit this Dockerfile and docker-compose.yml for security issues"
→ devsecops-container
→ Output: CIS Docker Benchmark findings with remediated Dockerfile
```

### Pipeline security
```
"Review this GitHub Actions workflow for security risks"
→ devsecops-pipeline
→ Output: Pipeline audit with SLSA assessment, secret handling, action pinning
```

### IaC scanning
```
"Scan this Terraform config for AWS security misconfigurations"
→ devsecops-iac-scanner
→ Output: IaC findings with CIS reference, resource:line, fix snippets
```

### Secrets scanning
```
"Search this repo for leaked credentials — check git history too"
→ devsecops-secrets-scanner
→ Output: Found secrets with location, type, rotation instructions
```

### Kubernetes security
```
"Audit this Kubernetes deployment for pod security and RBAC issues"
→ devsecops-k8s-security
→ Output: CIS K8s Benchmark findings, RBAC review, network policy recommendations
```

---

## GRC & Compliance

### Compliance audit
```
"Map our current controls against NIST 800-53 and identify gaps"
→ grc-compliance-auditor
→ Output: Compliance matrix with gap analysis and prioritized remediation
```

### Policy writing
```
"Draft an incident response policy for a mid-size SaaS company"
→ grc-policy-writer
→ Output: Complete policy document with sections, roles, escalation, review schedule
```

### Risk assessment
```
"Run a risk assessment on our cloud infrastructure using FAIR methodology"
→ grc-risk-assessor
→ Output: Risk register with quantified risk scores and treatment options
```

### Audit preparation
```
"Prepare us for the upcoming SOC 2 Type II audit — what evidence do we need?"
→ grc-audit-prep
→ Output: Evidence checklist, gap remediation plan, interview prep guide
```

---

## IR & Forensics

### Incident handling
```
"Lateral movement detected from a compromised workstation — coordinate the response"
→ ir-incident-handler
→ Output: IR report with P1-P4 severity, timeline, containment actions, IOCs
```

### Digital forensics
```
"Walk me through analyzing a disk image for signs of data exfiltration"
→ ir-forensics
→ Output: Forensics report with evidence inventory, timeline, chain of custody
```

### Malware analysis
```
"I have a suspicious PE binary — analyze it"
→ ir-malware-analyst
→ Output: Analysis report with IOCs, capabilities, YARA rule, ATT&CK mapping
```

### Threat intelligence
```
"Enrich these IOCs: 185.220.101.42, evil-domain.xyz, SHA256:a1b2c3..."
→ ir-threat-intel
→ Output: TI report with Diamond Model, enrichment from VT/Shodan/AbuseIPDB
```

### Playbook building
```
"Build an IR playbook for ransomware incidents"
→ ir-playbook-builder
→ Output: Structured playbook with decision tree, containment, recovery steps
```
