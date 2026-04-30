#!/usr/bin/env bash
set -euo pipefail

verbose=0
for arg in "$@"; do
  case "$arg" in
    -v|--verbose) verbose=1 ;;
    -h|--help)
      echo "Usage: $(basename "$0") [-v|--verbose]"
      echo "  Lists all skills in the repo by folder name."
      echo "  With -v/--verbose, also prints each skill's YAML frontmatter."
      exit 0
      ;;
    *)
      echo "error: unknown argument: $arg" >&2
      echo "Usage: $(basename "$0") [-v|--verbose]" >&2
      exit 1
      ;;
  esac
done

REPO="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO"

find . -name SKILL.md -not -path '*/node_modules/*' | sort | while IFS= read -r skill_md; do
  name="$(basename "$(dirname "$skill_md")")"
  if [ "$verbose" -eq 1 ]; then
    printf '%s\n' "$name"
    awk '
      /^---[[:space:]]*$/ {
        fm++
        if (fm == 2) exit
        next
      }
      fm == 1 { print "  " $0 }
    ' "$skill_md"
    printf '\n'
  else
    printf '%s\n' "$name"
  fi
done