#!/usr/bin/env bash
# uninstall.sh — Remove git-ape-aws-skills plugin from a target repository
# Usage: ./uninstall.sh [target-repo-path]

set -euo pipefail

TARGET="${1:-.}"
SKILLS_DST="$TARGET/.github/skills"
INSTALLED_MANIFEST="$SKILLS_DST/.aws-skills-installed.json"

if [[ ! -f "$INSTALLED_MANIFEST" ]]; then
  echo "❌ No AWS skills installation found (missing $INSTALLED_MANIFEST)"
  echo "   The plugin may not be installed, or was installed manually."
  exit 1
fi

echo "🔌 Uninstalling git-ape-aws-skills from $SKILLS_DST"
echo ""

REMOVED=0
while IFS= read -r skill_name; do
  skill_dir="$SKILLS_DST/$skill_name"
  if [[ -d "$skill_dir" ]]; then
    rm -rf "$skill_dir"
    echo "  ✖ Removed $skill_name"
    ((REMOVED++))
  fi
done < <(jq -r '.skills[]' "$INSTALLED_MANIFEST")

rm -f "$INSTALLED_MANIFEST"

echo ""
echo "✅ Removed $REMOVED AWS skills"
echo "📋 Installation manifest cleaned up"
