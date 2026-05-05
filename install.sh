#!/usr/bin/env bash
# install.sh — Install git-ape-aws-skills plugin into a target repository
# Usage: ./install.sh [target-repo-path]
#   target-repo-path: Path to a Git-Ape enabled repository (default: current directory)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-.}"
SKILLS_SRC="$SCRIPT_DIR/skills"
SKILLS_DST="$TARGET/.github/skills"
INSTALLED_MANIFEST="$SKILLS_DST/.aws-skills-installed.json"

# Validate source
if [[ ! -d "$SKILLS_SRC" ]]; then
  echo "❌ Skills source not found at $SKILLS_SRC"
  exit 1
fi

# Validate target is a git-ape repo
if [[ ! -f "$TARGET/plugin.json" ]]; then
  echo "❌ Target does not appear to be a Git-Ape repository (no plugin.json found)"
  echo "   Run this from a Git-Ape enabled repo, or pass the repo path as an argument."
  exit 1
fi

# Create skills directory if needed
mkdir -p "$SKILLS_DST"

echo "🔌 Installing git-ape-aws-skills into $SKILLS_DST"
echo ""

INSTALLED=()
SKIPPED=()

for skill_dir in "$SKILLS_SRC"/aws-*/; do
  skill_name=$(basename "$skill_dir")
  dst="$SKILLS_DST/$skill_name"

  if [[ -d "$dst" ]]; then
    # Overwrite existing (update)
    cp -r "$skill_dir" "$SKILLS_DST/"
    SKIPPED+=("$skill_name (updated)")
  else
    cp -r "$skill_dir" "$SKILLS_DST/"
    INSTALLED+=("$skill_name")
  fi
done

# Record what was installed for clean uninstall
jq -n \
  --arg version "1.0.0" \
  --arg date "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  --argjson skills "$(printf '%s\n' "$SKILLS_SRC"/aws-*/ | xargs -I{} basename {} | jq -R . | jq -s .)" \
  '{plugin: "git-ape-aws-skills", version: $version, installed_at: $date, skills: $skills}' \
  > "$INSTALLED_MANIFEST"

echo "✅ Installed: ${#INSTALLED[@]} new skills"
if [[ ${#SKIPPED[@]} -gt 0 ]]; then
  echo "🔄 Updated:   ${#SKIPPED[@]} existing skills"
fi
echo ""
echo "Skills installed:"
for s in "${INSTALLED[@]}" "${SKIPPED[@]}"; do
  echo "  • $s"
done
echo ""
echo "📋 Installation manifest saved to $INSTALLED_MANIFEST"
echo ""
echo "Next steps:"
echo "  1. Verify with: ls $SKILLS_DST/aws-*"
echo "  2. Run /prereq-check to validate AWS CLI and auth"
echo "  3. Start using: @git-ape followed by any AWS skill"
