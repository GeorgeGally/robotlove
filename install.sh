#!/bin/bash
set -euo pipefail

echo "$(pwd)" > "$HOME/.robotlove_repo"

cp cli/robotlove /usr/local/bin/robotlove 2>/dev/null && chmod +x /usr/local/bin/robotlove && echo "Installed. Usage: robotlove \"your message\"" && exit 0

for dir in "$HOME/.local/bin" "$HOME/bin"; do
  if echo "$PATH" | tr ':' '\n' | grep -qx "$dir"; then
    mkdir -p "$dir"
    cp cli/robotlove "$dir/robotlove"
    chmod +x "$dir/robotlove"
    echo "Installed. Usage: robotlove \"your message\""
    exit 0
  fi
done

mkdir -p "$HOME/bin"
cp cli/robotlove "$HOME/bin/robotlove"
chmod +x "$HOME/bin/robotlove"
touch "$HOME/.bashrc"
echo 'export PATH="$PATH:$HOME/bin"' >> "$HOME/.bashrc"
export PATH="$PATH:$HOME/bin"
echo "Installed. Usage: robotlove \"your message\""
exec "$SHELL"
