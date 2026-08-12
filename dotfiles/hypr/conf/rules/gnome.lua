hl.window_rule({
  match = { class = "^(gnome-calculator)$" },
  tag = "+floating-window"
})

hl.window_rule({
  match = { class = "^(org\\.gnome\\.Nautilus)$" },
  tag = "+floating-window"
})
