local name = "Utilities"
hl.bind("SUPER+U", hl.dsp.submap(name), { description = name .. " Submap" })
hl.define_submap(name, "reset", function()
  hl.bind("A", hl.dsp.exec_cmd("launch-audio"), { description = "Audio Controls" })
  hl.bind("B", hl.dsp.exec_cmd("launch-bluetooth"), { description = "Bluetooth Controls" })
  hl.bind("T", hl.dsp.exec_cmd("launch-sysmon"), { description = "Activity" })
  hl.bind("W", hl.dsp.exec_cmd("launch-wifi"), { description = "Wifi Controls" })

  hl.bind("I", hl.dsp.exec_cmd("toggle-idle"), { description = "Toggle Idle-Inhibit" })
  hl.bind("N", hl.dsp.exec_cmd("toggle-nightlight"), { description = "Toggle Nightlight" })

  hl.bind(
    "SHIFT+SLASH",
    hl.dsp.exec_cmd("keybind-menu" .. name),
    { description = "Show keymap for " .. name .. " Submap" }
  )
  hl.bind("ESCAPE", hl.dsp.submap("reset"), { description = "Exit " .. name .. " Submap" })
end, { description = name .. " Submap" })
