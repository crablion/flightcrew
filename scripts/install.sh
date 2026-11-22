#!/usr/bin/env bash
# Flightcrew installer
# Usage: bash install.sh [target-project-dir]
# Installs Flightcrew skills, crew agents, and templates into a project for
# VS Code (GitHub Copilot) and Claude Code.
# Safe to re-run: changed files are backed up with a .bak suffix before being replaced,
# and nothing under .flightcrew/flights/ or your manual is ever touched.

set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-.}"
TARGET="$(cd "$TARGET" && pwd)"

if [ ! -d "$TARGET/.git" ]; then
  echo "Warning: $TARGET is not a git repository. Flightcrew works best inside one."
fi

copy_file() {
  local from="$1" to="$2"
  mkdir -p "$(dirname "$to")"
  if [ -f "$to" ] && ! cmp -s "$from" "$to"; then
    cp "$to" "$to.bak"
    echo "  backed up $to -> $to.bak"
  fi
  cp "$from" "$to"
}

echo "Installing Flightcrew into $TARGET"

echo "- Skills (VS Code Copilot: .github/skills, Claude Code: .claude/skills)"
for d in "$SRC"/skills/fc-*; do
  name="$(basename "$d")"
  copy_file "$d/SKILL.md" "$TARGET/.github/skills/$name/SKILL.md"
  copy_file "$d/SKILL.md" "$TARGET/.claude/skills/$name/SKILL.md"
done

echo "- Crew agents (VS Code Copilot: .github/agents, Claude Code: .claude/agents)"
for f in "$SRC"/agents/copilot/*.agent.md; do
  copy_file "$f" "$TARGET/.github/agents/$(basename "$f")"
done
for f in "$SRC"/agents/claude/*.md; do
  copy_file "$f" "$TARGET/.claude/agents/$(basename "$f")"
done

echo "- Templates"
for f in "$SRC"/templates/*.md; do
  copy_file "$f" "$TARGET/.flightcrew/templates/$(basename "$f")"
done

mkdir -p "$TARGET/.flightcrew/flights"

echo ""
echo "Flightcrew is installed. Cleared for takeoff."
echo ""
echo "Next, in VS Code Copilot Chat (agent mode) or Claude Code:"
echo "  /fc-manual                 set up your ops manual"
echo "  /fc-survey                 existing codebase? map it first"
echo "  /fc-flightplan <intent>    start your first flight"
