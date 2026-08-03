#!/usr/bin/env bash
# Renames the "Project" template to a real project name.
#
#   scripts/rename.sh NewName [bundle.identifier]
#
# NewName must be alphanumeric and start with a letter (it becomes the target,
# scheme, and package names). Without a bundle identifier, the bundle id
# becomes work.hungryfoolish.NewName.
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
name="${1:-}"
bundle="${2:-}"

if [[ -z "$name" ]]; then
  echo "usage: scripts/rename.sh NewName [bundle.identifier]" >&2
  exit 1
fi
if [[ ! "$name" =~ ^[A-Za-z][A-Za-z0-9]*$ ]]; then
  echo "error: name must be alphanumeric and start with a letter (got '$name')" >&2
  exit 1
fi
if [[ -n "$bundle" && ! "$bundle" =~ ^[A-Za-z][A-Za-z0-9-]*(\.[A-Za-z][A-Za-z0-9-]*)+$ ]]; then
  echo "error: '$bundle' does not look like a bundle identifier" >&2
  exit 1
fi
if [[ ! -d "$root/app/Project.xcodeproj" ]]; then
  echo "error: nothing to rename (app/Project.xcodeproj not found — already renamed?)" >&2
  exit 1
fi

# Rewrite file contents. "Project" is replaced only at the start of a word so
# pbxproj tokens like PBXProject and preferredProjectObjectVersion survive.
# This script excludes itself so it stays runnable from a fresh checkout.
echo "Renaming Project -> $name"
grep -rIl 'Project' "$root" \
  --exclude-dir=.git --exclude-dir=.build --exclude-dir=.swiftpm \
  --exclude-dir=xcuserdata --exclude-dir=DerivedData \
  --exclude=rename.sh |
while IFS= read -r file; do
  if [[ -n "$bundle" ]]; then
    sed -i '' "s/work\.hungryfoolish\.Project/$bundle/g" "$file"
  fi
  sed -E -i '' "s/(^|[^A-Za-z])Project/\\1$name/g" "$file"
  echo "  rewrote ${file#"$root"/}"
done

# Rename files and directories, deepest first so parents rename last.
find "$root" -depth -name '*Project*' \
  -not -path '*/.git/*' -not -path '*/.build/*' -not -path '*/.swiftpm/*' \
  -not -path '*/xcuserdata/*' -not -path '*/DerivedData/*' |
while IFS= read -r path; do
  base="$(basename "$path")"
  mv "$path" "$(dirname "$path")/${base//Project/$name}"
  echo "  renamed ${path#"$root"/}"
done

echo "Done. Next steps:"
echo "  - open app/$name.xcodeproj and confirm it builds (or run: make build)"
echo "  - review app/Config/Shared.xcconfig (display name, category, team)"
echo "  - delete scripts/rename.sh and commit"
