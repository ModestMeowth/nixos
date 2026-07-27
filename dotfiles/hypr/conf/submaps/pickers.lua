local name = "Pickers"
hl.bind("SUPER+P", hl.dsp.submap(name), { description = name .. " Submap" })
hl.define_submap(name, "reset", function()
  hl.bind("E", hl.dsp.exec_cmd("launch-walker -m symbols"), { description = "Emoji picker" })
  hl.bind("C", hl.dsp.exec_cmd("launch-menu capture"), { description = "Capture menu" })
  hl.bind("V", hl.dsp.exec_cmd("launch-walker -m clipboard"), { description = "Clipboard menu" })
  hl.bind("Q", hl.dsp.exec_cmd("launch-menu system"), { description = "System menu" })

  hl.bind(
    "SHIFT+SLASH",
    hl.dsp.exec_cmd("keybind-menu " .. name),
    { description = "Show Keymap for " .. name .. " Submenu" }
  )
  hl.bind("ESCAPE", hl.dsp.submap("reset"), { description = "Exit " .. name .. " Submap" })
end, { description = name .. " Submap" })
