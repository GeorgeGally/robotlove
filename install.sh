#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "$DIR" > "$HOME/.robots_repo"

install_cli() {
  local dest="$1"
  cp "$DIR/cli/robots" "$dest"
  chmod +x "$dest"
  echo "Installed to $dest"
}

if cp "$DIR/cli/robots" /usr/local/bin/robots 2>/dev/null; then
  install_cli /usr/local/bin/robots
else
  mkdir -p "$HOME/bin"
  install_cli "$HOME/bin/robots"
  if ! echo "$PATH" | tr ':' '\n' | grep -qx "$HOME/bin"; then
    touch "$HOME/.bashrc"
    echo 'export PATH="$PATH:$HOME/bin"' >> "$HOME/.bashrc"
    export PATH="$PATH:$HOME/bin"
  fi
fi

auto_detect() {
  for d in "$HOME" /var/www /usr/share/nginx/html /usr/local/www; do
    found=$(find "$d" -maxdepth 3 -name robots.txt -type f 2>/dev/null | head -1)
    if [ -n "$found" ]; then
      echo "$found"
      return 0
    fi
  done
  return 1
}

echo ""
FOUND=$(auto_detect)
if [ -n "$FOUND" ]; then
  echo "ROBOTS=$FOUND" > "$HOME/.robots_conf"
  echo "Found robots.txt at: $FOUND"
  echo "Configured. Use: robots \"your message\""
else
  echo "No robots.txt found. After creating one, run:"
  echo "  robots setup /path/to/robots.txt"
fi
