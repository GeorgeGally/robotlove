#!/bin/bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "$DIR" > "$HOME/.robots_repo"

ROBOT=$(cat <<'ROBOT_EOF'
░░        ░
                          ▓▓▓▓▒        ░░░░░░░      ░░░     ▒
                            ░░░░░░░▓▓▓▓▓▓▓▓▓▓▒     ░░      ░░░
                        ░░░░░░   ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░
                                 ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
                      ▒▒▒▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓░    ░▒░░░ ░░░░░
              ░▒▓ ▓▓▒▓░    ▓▓▓▓▓▓▓▒▒░▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
                ▓░    ░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓░    ░░░░░░░
                ▒░    ░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░  ░▒░ ░░░░░
                ▒░    ░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░ ░▒▒
                ▒░  ░ ▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒░░▒░▒░░▒▒▒▒▒▒░▒▒░    ░▒▒▒░░░░
                ▒░   ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░▒▒▒▒▒▒░▓▓▒▒▒▒▒▒▒▒▓▒▒▒▒▒
                ▒░ ░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░▒░░░░░▒   ░░▒ ░▓▓▒  ░░░░░░░░░░  ░
        ░░      ▒░   ▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▒   ▒▒▒▒▒▒▒▒▒▓░░░░▒        ▒▒       ░░
              ░░  ▓▓▓▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░       ░▒▓ ░     ▒
                ▓░  ░▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓       ▓▓▓▓▓▒    ▓░
                ▓░  ░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓░   ▓▓      ░▓░
       ░   ░░ ░ ▓░▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░        ▓▓ ▓▒▓▒ ▒▓
        ▒ ▓ ▒▓  ░░▓░ ▓▓▓▓▓▓▒▒░░▒▒▒░░▒░░░░░░░░░░░░░░░           ░░ ░▒▒▒ ░▒▒
              ▒▒▓▓▓░ ▓▓▓▓░           ▒▒▒░░▒░░░░░▒           ▒░░▒▒ ░░▒▓▒▓▓▓▒░▒ ▒▓▓▒ ▒
            ▒▒▓▓▓▓▓  ▓▓▓░            ▓▓▒▒▒▒▒▒▒▒░             ░▒▓▓ ░▒▒▓▒▓░░░
             ░▓▓▒▓▓░ ▓▓▓    ░░▒▒▒░    ▓▓▒▒▒▒▒▒▒     ░▒▒▒░░     ▒▓ ░▒▒▓░▓▓▓░░
     ░       ░▓▓▒▓▒░ ▓▓▒░░▓▓▓█████▓▓▓▓▓▓▒▒▒▒▒▒▓  ▓▓▓█████▓▓▓▓▓▓▓▓▓▓▓▒▓░▓░ ▒▒ ▒▒▒▒░
              ░▓░▒▒░ ▓▓▓     ░░░░    ░▓▓▒▒▒▒▒░░     ░░░░░    ░▒▓▓ ░▒▒▒ ▒░
              ▒░ ░▒░ ░▓▓▓           ░▓▓▒▒▒▒▒▒▒▒▓            ░░▓▓   ▒░▒ ▒
               ░▒░░   ▒▓▓▓▒      ░▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒        ░░░▒▒▒   ░░░░░
              ░░░░░   ░▓▓▓▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒  ▒▒▒░▒▒▓▓▓▓▒▒▒▓▓▓      ░▒    ░░ ░░░░░
                  ▒      ▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░   ▒
                ░░░░▒  ▓░░ ░▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓   ░▒▒▒▒░   ▒▒   ░░▒▒▒▒▒░ ▒▒ ░▒▒
                   ░░░░▓▓░   ░▒ ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░        ░░ ░
                       ▓▓░  ▒ ▓░░▒░  ░░░░▒▒▓▓▓▒▒▒▒▒░  ▓ ░░ ░░▒▓
                      ▒▒▓▓▓ ░ ░░░▒░░░░░░░░░░░░░░ ░░   ░    ░░░   ░░ ░░░░░ ░░░
                ▒▒▒░  ▓▓▓▓░    ▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░ ▒      ▒▒░▒▓    ░░ ░
                      ░░░▓▓▒   ░▒▒▒               ░▒ ░   ░░░░░░░░░░░▒
         ░ ▒░ ▒▒▒▒░▓▒ ░▒  ▓▓▓░  ▒▒  ░▓▓▓▓▓▓▓▓▓▓▓▒  ░░░  ░░▒▒▓▒▓▒▒
                       ░▒▒ ░▓▒▓░▒ ░░ ▓░░░░░░░░░░▒    ░░ ░░░    ░
              ▒░░▒           ▓▓▓▓░▓░░▓▒▒▒▒░▒▒░▒    ░  ░▒
                           ░░░░▓▓▒▓▒░▓▒▒▒▒▒▒▒▒▒▒▒░░▒░░░ ▒▓░  ▒▓▒▒ ▓ ░░▓░
                   ▓▓▒░░▓ ░▒░   ░░▓▒░▓▓▒▒▒▒▒▒▒▒▓▒░▒▒     ░
                                  ▒▓░▓▓▓▓▒▒▒▒▒▒▒░░▒    ░ ░░▒░ ░░░░
                          ▓▒▒░▓▒▒    ░░           ▒▒▒░
                             ░▒ ░░▒▒▒        ░░░░▒▒░ ░░
                                        ▓▓▓▓▓░▒▓
ROBOT_EOF
)

ROBOT2='  .%%%%%%..%%..%%...%%%%...%%%%%%...%%%%...%%......%%......%%%%%%..%%%%%..
  ...%%....%%%.%%..%%........%%....%%..%%..%%......%%......%%......%%..%%.
  ...%%....%%.%%%...%%%%.....%%....%%%%%%..%%......%%......%%%%....%%..%%.
  ...%%....%%..%%......%%....%%....%%..%%..%%......%%......%%......%%..%%.
  .%%%%%%..%%..%%...%%%%.....%%....%%..%%..%%%%%%..%%%%%%..%%%%%%..%%%%%..
  ........................................................................'

install_cli() {
  local dest="$1"
  cp "$DIR/cli/robots" "$dest"
  chmod +x "$dest"
  local dir; dir=$(dirname "$dest")
  cp "$DIR/cli/llm.py" "$dir/llm.py"
  chmod +x "$dir/llm.py" 2>/dev/null || true
}

if cp "$DIR/cli/robots" /usr/local/bin/robots 2>/dev/null; then
  install_cli /usr/local/bin/robots
  DEST="/usr/local/bin/robots"
else
  mkdir -p "$HOME/bin"
  install_cli "$HOME/bin/robots"
  DEST="$HOME/bin/robots"
  if ! echo "$PATH" | tr ':' '\n' | grep -qx "$HOME/bin"; then
    touch "$HOME/.bashrc"
    echo 'export PATH="$PATH:$HOME/bin"' >> "$HOME/.bashrc"
    export PATH="$PATH:$HOME/bin"
  fi
fi

echo "$ROBOT"
echo ""
echo "$ROBOT2"
echo ""
echo "  robots installed to $DEST"
echo ""

auto_detect() {
  for d in "$HOME" /var/www /usr/share/nginx/html /usr/local/www; do
    find "$d" -maxdepth 3 -name robots.txt -type f 2>/dev/null
  done
}

ALL_FOUND=$(auto_detect | sort -u)
if [ -z "$ALL_FOUND" ]; then
  echo "  no robots.txt found."
  echo ""
  echo "  let's find one."
  echo ""
  "$DEST" setup
else
  files=()
  while IFS= read -r f; do
    [ -n "$f" ] && files+=("$f")
  done <<< "$ALL_FOUND"
  if [ "${#files[@]}" -eq 1 ]; then
    echo "ROBOTS=${files[0]}" > "$HOME/.robots_conf"
    echo "  found robots.txt at: ${files[0]}"
    echo ""
    echo "  robots \"your message here\""
  else
    echo "  found ${#files[@]} robots.txt files:"
    echo ""
    for i in "${!files[@]}"; do
      printf "  %d) %s\n" $((i + 1)) "${files[$i]}"
    done
    echo ""
    read -r -p "  choose (1-${#files[@]}): " choice
    idx=$((choice - 1))
    echo "ROBOTS=${files[$idx]}" > "$HOME/.robots_conf"
    echo "  configured: ${files[$idx]}"
    echo ""
    echo "  robots \"your message here\""
  fi
fi
echo ""
echo "  robots update   — pull latest version"
