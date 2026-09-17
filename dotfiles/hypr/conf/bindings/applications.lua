hl.bind("SUPER+RETURN", hl.dsp.exec_cmd("xdg-terminal-exec"), { description = "Open Terminal" })
hl.bind("SUPER+E", hl.dsp.exec_cmd("~/.local/bin/launch-file-manager"), { description = "Open File Manager" })
hl.bind("SUPER+D", hl.dsp.exec_cmd('~/.local/bin/launch-browser --profile="Default"'), { description = "Open Browser" })
hl.bind("SUPER+J", hl.dsp.exec_cmd('~/.local/bin/launch-browser --profile="Work"'), { description = "Open Browser (Work profile)" })
