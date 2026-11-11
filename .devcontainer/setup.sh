#!/usr/bin/env bash
# Runs once, when the codespace is created.
set -eu

here="$(cd "$(dirname "$0")/.." && pwd)"

# Our commands, available everywhere.
for f in "$here"/bin/*; do
  sudo install -m 0755 "$f" "/usr/local/bin/$(basename "$f")"
done

mkdir -p "$HOME/Downloads" "$HOME/.fluxbox"

# Right-click menu of the desktop.
cat > "$HOME/.fluxbox/menu" <<'EOF'
[begin] (Packet Tracer)
    [exec] (Packet Tracer) {pt-start}
    [exec] (Install Packet Tracer) {pt-install --now}
    [exec] (Firefox) {firefox}
    [exec] (Terminal) {xterm}
    [separator]
    [restart] (Restart desktop)
[end]
EOF

# Launcher buttons on the bottom bar, so a phone needs no right-click.
init="$HOME/.fluxbox/init"
touch "$init"
sed -i '/^session\.screen0\.toolbar\.tools:/d; /^session\.screen0\.toolbar\.button\./d' "$init"
cat >> "$init" <<'EOF'
session.screen0.toolbar.tools: button.pt, button.web, button.term, iconbar, systemtray, clock
session.screen0.toolbar.button.pt.label: [ Packet Tracer ]
session.screen0.toolbar.button.pt.commands: Exec pt-start
session.screen0.toolbar.button.web.label: [ Firefox ]
session.screen0.toolbar.button.web.commands: Exec firefox
session.screen0.toolbar.button.term.label: [ Terminal ]
session.screen0.toolbar.button.term.commands: Exec xterm
EOF

# Reload the desktop's settings if it is already running.
pkill -HUP -x fluxbox 2>/dev/null || true
