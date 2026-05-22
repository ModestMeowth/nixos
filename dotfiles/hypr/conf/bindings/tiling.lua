hl.bind("SUPER+W",       hl.dsp.window.close(),                 { description = "Close Window"      })
hl.bind("SUPER+SHIFT+Q", hl.dsp.exec_cmd("hyprshutdown"),       { description = "Exit Hyprland"     })
hl.bind("SUPER+F",       hl.dsp.window.fullscreen({ mode = 1 }), { description = "Toggle Fullscreen" })

for w = 1, 6 do
    local key = "code:" .. tostring(w + 9)
    hl.bind("SUPER+" .. key, hl.dsp.focus({workspace = tostring(w)},                                 { description = "Switch to Workspace" .. w }                ))
    hl.bind("SUPER+SHIFT+" .. key, hl.dsp.window.move({workspace = tostring(w)},                     { description = "Move Window to Workspace" .. w }           ))
    hl.bind("SUPER+SHIFT+ALT+" .. key, hl.dsp.window.move({workspace = tostring(w), follow = false}, { description = "Silently move Window to Workspace" .. w }  ))
end

hl.bind("SUPER+H",       hl.dsp.focus({direction = "l"}),       { description = "Move Window Focus Left"     })
hl.bind("SUPER+SHIFT+H", hl.dsp.window.swap({direction = "l"}), { description = "Swap Window to the Left"    })
hl.bind("SUPER+J",       hl.dsp.focus({direction = "d"}),       { description = "Move Window Focus Downward" })
hl.bind("SUPER+SHIFT+J", hl.dsp.window.swap({direction = "d"}), { description = "Swap Window Downward"       })
hl.bind("SUPER+K",       hl.dsp.focus({direction = "u"}),       { description = "Move Window Focus Upward"   })
hl.bind("SUPER+SHIFT+K", hl.dsp.window.swap({direction = "u"}), { description = "Swap Window Upward"         })
hl.bind("SUPER+L",       hl.dsp.focus({direction = "r"}),       { description = "Move Window Focus Right"    })
hl.bind("SUPER+SHIFT+L", hl.dsp.window.swap({direction = "r"}), { description = "Swap Window to the Right"   })

hl.bind("SUPER+M", function()
    if hl.get_config("general.layout") == "dwindle" then
        hl.config({ general = { layout = "master" }})
    else
        hl.config({ general = { layout = "dwindle" }})
    end
end, { description = "Toggle between Dwindle and Master layouts"})
