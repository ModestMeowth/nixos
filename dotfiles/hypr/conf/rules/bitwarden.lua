hl.window_rule({
  match = { class = "^(Bitwarden)$" },
  no_screen_share = true,
  tag = "+floating-window"
})

hl.window_rule({
  match = { class = "chrome-nngceckbapebfimnlniiiahkandclblb-.*" },
  no_screen_share = true,
  tag = "+floating-window"
})
