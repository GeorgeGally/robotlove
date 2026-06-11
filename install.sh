#!/bin/bash
set -euo pipefail

cp cli/robotlove /usr/local/bin/robotlove 2>/dev/null && echo "Installed to /usr/local/bin/robotlove" && chmod +x /usr/local/bin/robotlove && echo "Usage: robotlove \"your message\"" && exit 0

mkdir -p "$HOME/bin"
cp cli/robotlove "$HOME/bin/robotlove"
chmod +x "$HOME/bin/robotlove"
echo "Installed to $HOME/bin/robotlove"

if ! echo "$PATH" | tr ':' '\n' | grep -q "$HOME/bin"; then
  echo "Add to your shell rc file: export PATH=\$PATH:\$HOME/bin"
fi

echo "Usage: robotlove \"your message\""
