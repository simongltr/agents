#!/usr/bin/env bash
set -euo pipefail

# Links all skills in the repository to ~/.claude/skills and ~/.agents/skills,
# so that they can be used by local agent CLIs.
#
# - If a destination already has a symlink with the same name, replace it.
# - If a destination already has a real folder (hardcoded skill), skip it
#   and report so the user can resolve the conflict manually.

REPO="$(cd "$(dirname "$0")/.." && pwd)"
DESTS=("$HOME/.claude/skills" "$HOME/.agents/skills")

# Refuse to run if a destination is itself a symlink pointing into this repo
for dest in "${DESTS[@]}"; do
  if [ -L "$dest" ]; then
    resolved="$(readlink -f "$dest")"
    case "$resolved" in
      "$REPO"|"$REPO"/*)
        echo "error: $dest is a symlink into this repo ($resolved)." >&2
        echo "Remove it (rm \"$dest\") and re-run." >&2
        exit 1
        ;;
    esac
  fi
done

for dest in "${DESTS[@]}"; do
  mkdir -p "$dest"
  echo "${dest/#$HOME/~}"

  linked=0 replaced=0 unchanged=0 skipped=0

  while IFS= read -r -d '' skill_md; do
    src="$(dirname "$skill_md")"
    name="$(basename "$src")"
    target="$dest/$name"

    if [ -L "$target" ]; then
      current="$(readlink "$target")"
      if [ "$current" = "$src" ]; then
        echo "  = $name (already linked)"
        unchanged=$((unchanged + 1))
      else
        ln -sfn "$src" "$target"
        echo "  ~ $name (replaced symlink)"
        replaced=$((replaced + 1))
      fi
    elif [ -d "$target" ]; then
      echo "  ! $name (skipped: real folder exists)"
      skipped=$((skipped + 1))
    else
      ln -sn "$src" "$target"
      echo "  + $name"
      linked=$((linked + 1))
    fi
  done < <(find "$REPO/skills" -name SKILL.md -not -path '*/node_modules/*' -print0)

  echo "  $linked new, $replaced replaced, $unchanged unchanged, $skipped skipped"
done