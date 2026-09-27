Mac-style Cmd shortcuts

  Debian 13 / KDE Plasma / X11 / QEMU-UTM guest. Run in a terminal inside the VM.

  ────────────────────────────────────────

  1. Install keyd

  sudo apt-get install -y keyd

  ────────────────────────────────────────

  2. Write /etc/keyd/default.conf

  sudo cat >/etc/keyd/default.conf <<'EOF'
  [ids]
  *
  [main]
  [meta]
  c = C-insert
  v = S-insert
  x = C-x
  z = C-z
  a = C-a
  EOF

  Rationale: Mac Command arrives as leftmeta. Copy/paste use Ctrl+Insert / Shift+Insert so Cmd+C copies in terminals instead of sending SIGINT.

  ────────────────────────────────────────

  3. Enable keyd and reload config

  Debian may start keyd during install before the config exists. Always reload:

  sudo systemctl enable --now keyd
  sudo keyd.rvaiya reload

  On Debian the binary is keyd.rvaiya, not keyd.

  ────────────────────────────────────────

  4. Verify keyboard remap

  No reboot needed. Test Cmd+C / Cmd+V in a GUI app.

  Optional monitor:

  sudo keyd.rvaiya monitor

  Press Command. You should see leftmeta down/up.

  Troubleshooting:
  • Nothing for Command, but normal keys work → host/VM is capturing Cmd. Enable input capture / Cmd-forwarding in UTM/QEMU.
  • Cmd+V opens Klipper → remap not active; run sudo keyd.rvaiya reload again.
  • After editing the config later, always run sudo keyd.rvaiya reload.
