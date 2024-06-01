{inputs, ...}: {
  programs = {
    wezterm.enable = true;
  };

  xdg.configFile = {
    "wezterm/wezterm.lua".source = "${inputs.mm.outputs.dotfiles}/dot_config/wezterm/wezterm.lua";
    "wezterm/wayland_gnome.lua".source = "${inputs.mm.outputs.dotfiles}/dot_config/wezterm/wayland_gnome.lua";
    "wezterm/keybinds.lua".source = "${inputs.mm.outputs.dotfiles}/dot_config/wezterm/keybinds.lua";
    "wezterm/colors/dracula.toml".source = "${inputs.dracula.outputs.wezterm}/dracula.toml";
  };
}
