local name = "NAME"
hl.bind("KEYBIND", hl.dsp.submap(name), { description = name .. " Submap" })
hl.define_submap(name, "reset", function()
    -- Bindings for submap here

    -- Common bindings for all submaps
    hl.bind("SHIFT+SLASH", hl.dsp.exec_cmd("keybind-menu " .. name), { description = "Show Keymap for " .. name .. " Submenu" })
    hl.bind("ESCAPE", hl.dsp.submap("reset"), { description = "Exit " .. name .. " Submap" })
end, { description = name .. " Submap" })
