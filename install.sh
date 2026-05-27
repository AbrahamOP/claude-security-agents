#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://raw.githubusercontent.com/AbrahamOP/claude-security-agents/main/agents"
AGENTS_DIR="./agents"
SCOPE_GUARD="_scope-guard.md"
VERSION="1.3.0"

# All agent filenames (alphabetical)
ALL_AGENTS=(
  audit-api.md audit-c-cpp.md audit-go.md audit-infra-code.md
  audit-java.md audit-javascript.md audit-php.md audit-python.md
  audit-ruby.md audit-rust.md
  blue-detection-rules.md blue-email-analyst.md blue-forensics-triage.md
  blue-ids-tuner.md blue-log-analyzer.md blue-siem-analyst.md
  blue-threat-hunter.md blue-vuln-manager.md
  devsecops-code-review.md devsecops-container.md
  devsecops-iac-scanner.md devsecops-k8s-security.md
  devsecops-pipeline.md devsecops-sbom.md devsecops-secrets-scanner.md
  grc-audit-prep.md grc-compliance-auditor.md grc-policy-writer.md
  grc-risk-assessor.md
  ir-evidence-handler.md ir-forensics.md ir-incident-handler.md
  ir-malware-analyst.md ir-playbook-builder.md ir-threat-intel.md
  purple-adversary-emulation.md purple-attack-detect-map.md
  purple-detection-gap.md purple-threat-model.md
  red-ad-attack.md red-api-security.md red-cloud-attack.md
  red-payload-craft.md red-privesc.md red-recon.md
  red-social-engineer.md red-webapp.md red-wireless.md
)

usage() {
  cat <<EOF
claude-security-agents installer v${VERSION}

Usage: install.sh [OPTIONS]

Options:
  --global           Install to ~/.claude/agents/ (default)
  --project          Install to ./.claude/agents/ (current project)
  --category LIST    Comma-separated: red,blue,purple,devsecops,grc,ir,audit
  --lite             Use Claude Haiku instead of Sonnet (cheaper)
  --uninstall        Remove installed agents
  --status           Show installed agents
  --help             Show this help

Examples:
  install.sh --global                    # Install all 24 agents globally
  install.sh --project --category blue   # Install Blue Team agents in project
  install.sh --global --lite             # Install all with Haiku model
  install.sh --uninstall                 # Remove all installed agents
EOF
  exit 0
}

# Parse args
DEST="$HOME/.claude/agents"
CATEGORIES=""
LITE=false
UNINSTALL=false
STATUS=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --global)  DEST="$HOME/.claude/agents"; shift ;;
    --project) DEST="./.claude/agents"; shift ;;
    --category) CATEGORIES="$2"; shift 2 ;;
    --lite)    LITE=true; shift ;;
    --uninstall) UNINSTALL=true; shift ;;
    --status)  STATUS=true; shift ;;
    --help|-h) usage ;;
    *) echo "Unknown option: $1"; usage ;;
  esac
done

# Status
if $STATUS; then
  echo "Installed agents in $DEST:"
  for f in "${ALL_AGENTS[@]}"; do
    if [ -f "$DEST/$f" ]; then
      echo "  [installed] $f"
    fi
  done
  exit 0
fi

# Uninstall
if $UNINSTALL; then
  removed=0
  for f in "${ALL_AGENTS[@]}" "$SCOPE_GUARD"; do
    if [ -f "$DEST/$f" ]; then
      rm "$DEST/$f"
      removed=$((removed + 1))
    fi
    # Also check other common location
    alt="$HOME/.claude/agents/$f"
    if [ "$alt" != "$DEST/$f" ] && [ -f "$alt" ]; then
      rm "$alt"
      removed=$((removed + 1))
    fi
  done
  echo "Removed $removed agent file(s)"
  exit 0
fi

# Filter by category
filter_agents() {
  if [ -z "$CATEGORIES" ]; then
    echo "${ALL_AGENTS[@]}"
    return
  fi
  local filtered=()
  IFS=',' read -ra cats <<< "$CATEGORIES"
  for agent in "${ALL_AGENTS[@]}"; do
    for cat in "${cats[@]}"; do
      prefix="${cat}-"
      if [[ "$agent" == ${prefix}* ]]; then
        filtered+=("$agent")
        break
      fi
    done
  done
  echo "${filtered[@]}"
}

SELECTED=($(filter_agents))
if [ ${#SELECTED[@]} -eq 0 ]; then
  echo "No agents match the selected categories: $CATEGORIES"
  echo "Available: red, blue, purple, devsecops, grc, ir"
  exit 1
fi

# Check if scope guard needed
NEED_SCOPE=false
for agent in "${SELECTED[@]}"; do
  if [[ "$agent" == red-* ]] || [[ "$agent" == purple-* ]]; then
    NEED_SCOPE=true
    break
  fi
done

mkdir -p "$DEST"

# Source: local clone or remote
use_remote=true
if [ -d "$AGENTS_DIR" ] && [ -f "$AGENTS_DIR/${ALL_AGENTS[0]}" ]; then
  use_remote=false
fi

install_file() {
  local filename="$1"
  local dest_path="$DEST/$filename"

  if $use_remote; then
    local content
    content=$(curl -sfL "$REPO_URL/$filename") || { echo "  [error]  $filename — download failed"; return 1; }
  else
    local content
    content=$(cat "$AGENTS_DIR/$filename") || { echo "  [error]  $filename — read failed"; return 1; }
  fi

  # Lite mode: swap model
  if $LITE; then
    content=$(echo "$content" | sed 's/^model: sonnet$/model: haiku/')
  fi

  # Check if unchanged
  if [ -f "$dest_path" ]; then
    existing=$(cat "$dest_path")
    if [ "$content" = "$existing" ]; then
      echo "  [unchanged] $filename"
      return 0
    fi
    echo "  [updated]   $filename"
  else
    echo "  [new]       $filename"
  fi

  echo "$content" > "$dest_path"
}

echo "Installing ${#SELECTED[@]} agents to $DEST"
echo ""

new=0 updated=0 unchanged=0 errors=0

# Scope guard first
if $NEED_SCOPE; then
  install_file "$SCOPE_GUARD" && true
fi

for agent in "${SELECTED[@]}"; do
  install_file "$agent" && true
done

echo ""
echo "Done. ${#SELECTED[@]} agents installed to $DEST"
if $NEED_SCOPE; then
  echo "Scope guard installed (required by red/purple agents)"
fi
if $LITE; then
  echo "Lite mode: all agents set to Claude Haiku"
fi
echo ""
echo "Open Claude Code and describe a security task — agents route automatically."
