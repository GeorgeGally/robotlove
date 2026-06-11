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

echo ""
echo "Now point robots at your robots.txt:"
echo ""
echo "  robots setup /path/to/robots.txt"
echo ""
echo "Common paths:"
echo "  Dreamhost: /home/YOUR_USER/YOUR_DOMAIN/robots.txt"
echo "  Apache:    /var/www/html/robots.txt"
echo "  Nginx:     /usr/share/nginx/html/robots.txt"
echo ""
echo -n "Enter path (or press enter to do it later): "
read -r ROBOTS_PATH
if [ -n "$ROBOTS_PATH" ]; then
  if [ -f "$ROBOTS_PATH" ]; then
    echo "ROBOTS=$ROBOTS_PATH" > "$HOME/.robots_conf"
    echo "Configured: $ROBOTS_PATH"
    echo "Ready. Use: robots \"your message\""
  else
    echo "File not found: $ROBOTS_PATH"
    echo "Run later: robots setup $ROBOTS_PATH"
  fi
fi
