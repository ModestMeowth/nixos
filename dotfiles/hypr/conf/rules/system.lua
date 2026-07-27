hl.window_rule({
  match = { tag = "floating-window" },
  float = true,
  center = true,
  size = { 875, 600 },
})

hl.window_rule({
  match = { class = "(dev.meowth.bluetui|dev.meowth.impala|dev.meowth.wiremix|dev.meowth.terminal|imv|mpv)" },
  tag = "+floating-window",
})

hl.window_rule({
  match = {
    class = "(xdg-desktop-portal-gtk|org.gnome.nautilus)",
    title = "^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save].*|[C|c]hoose.*)",
  },
  tag = "+floating-window",
})

hl.window_rule({
  match = {
    "^vlc|mpv|org.kde.kdenlive|com.obsproject.Studio|com.github.PintaProject.Pinta|imv|org.gnome.NautilusPreviewer)$",
  },
  tag = "-default-opacity",
  opacity = "1 1",
})

hl.window_rule({
  match = { tag = "pop" },
  rounding = 8,
})

hl.window_rule({
  match = { tag = "noidle" },
  idle_inhibit = "always",
})

hl.window_rule({
  match = { class = "dev.meowth.screensaver" },
  fullscreen = true,
  float = true,
  animation = "slide",
})
