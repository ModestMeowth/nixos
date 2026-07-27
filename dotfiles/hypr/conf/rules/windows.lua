hl.window_rule({
  match = { class = ".*" },
  suppress_event = "maximize",
  tag = "+default_opacity",
})

hl.window_rule({
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = true,
    pin = false,
  },
  no_focus = true,
})

hl.window_rule({
  match = { tag = "default-opacity" },
  opacity = "0.97 0.9",
})
