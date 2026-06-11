#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "$DIR" > "$HOME/.robots_repo"

cp "$DIR/cli/robots" /usr/local/bin/robots 2>/dev/null && chmod +x /usr/local/bin/robots && echo "Installed. Usage: robots \"your message\"" && exit 0

for dir in "$HOME/.local/bin" "$HOME/bin"; do
  if echo "$PATH" | tr ':' '\n' | grep -qx "$dir"; then
    mkdir -p "$dir"
    cp "$DIR/cli/robots" "$dir/robots"
    chmod +x "$dir/robots"
    echo "Installed. Usage: robots \"your message\""
    exit 0
  fi
done

mkdir -p "$HOME/bin"
cp "$DIR/cli/robots" "$HOME/bin/robots"
chmod +x "$HOME/bin/robots"
touch "$HOME/.bashrc"
echo 'export PATH="$PATH:$HOME/bin"' >> "$HOME/.bashrc"
export PATH="$PATH:$HOME/bin"
echo "Installed. Usage: robots \"your message\""
exec "$SHELL"
