hl.window_rule({
  match = { class = "((google-)?[cC]hrom(e|ium)|[bB]rave-browser)|[mM]icrosoft]-edge|Vivalide-stable|helium)" },
  tag = "+chromium-based-browser",
})

hl.window_rule({
  match = { class = "([fF]irefox|zen|librewolf)" },
  tag = "+firefox-based-browser",
})

hl.window_rule({
  match = { tag = "chromium-based-browser" },
  tag = "-default-opacity",
  tile = true,
  opacity = "1.0 0.97",
})

hl.window_rule({
  match = { tag = "firefox-based-browser" },
  tag = "-default-opacity",
  tile = true,
  opacity = "1.0 0.97",
})

hl.window_rule({
  match = { title = ".*is sharing.*" },
  workspace = "special silent",
})
