hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd("osd-client --output-volume raise"),
  { description = "Volume up", locked = true, repeating = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd("osd-client --output-volume lower"),
  { description = "Volume down", locked = true, repeating = true }
)
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd("osd-client --output-volume mute-toggle"),
  { description = "Mute", locked = true, repeating = true }
)
hl.bind(
  "XF86AudioMicMute",
  hl.dsp.exec_cmd("audio-input-mute"),
  { description = "Mute microphone", locked = true, repeating = true }
)
