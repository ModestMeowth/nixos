{inputs, config, lib, ...}: with lib; let

  cfg = config.modules.term.wezterm;
  dotfiles = inputs.mm.outputs.dotfiles;
  theme = inputs.dracula.outputs.wezterm;

in {
  options.modules.term.wezterm.enable = mkEnableOption "wezterm";

  config = mkIf cfg.enable {
    programs.wezterm.enable = true;

    xdg.configFile =  {
      "wezterm/wezterm.lua".source = "${dotfiles}/dot_config/wezterm/wezterm.lua";
      "wezterm/wayland_gnome.lua".source = "${dotfiles}/dot_config/wezterm/wayland_gnome.lua";
      "wezterm/keybinds.lua".source = "${dotfiles}/dot_config/wezterm/keybinds.lua";
      "wezterm/colors/dracula.toml".source = theme;
    };
  };
}
