local name = "Resize"
hl.bind("SUPER+R", hl.dsp.submap(name), { description = name .. " Submap" })
hl.define_submap(name, function()
  hl.bind("H", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
  hl.bind("J", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
  hl.bind("K", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
  hl.bind("L", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))

  hl.bind(
    "SHIFT+SLASH",
    hl.dsp.exec_cmd("keybind-menu " .. name),
    { description = "Show Keymap for " .. name .. " Submenu" }
  )
  hl.bind("ESCAPE", hl.dsp.submap("reset"), { description = "Exit " .. name .. " Submap" })
end, { description = name .. " Submap" })
