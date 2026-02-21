{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;
  inherit (lib) importJSON;
  font = config.stylix.fonts.serif.name;
  ts = osConfig.services.tailscale;
in
{

  home.packages = with pkgs; [
    bluetui
  ];

  services.mako = {
    enable = true;
    extraConfig = ''
      font=${font}
    ''
    + readFile ../../dotfiles/mako/config;
  };

  services.swayosd.enable = true;

  services.tailscale-systray = lib.mkIf ts.enable {
    enable = true;
    package = ts.package;
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = importJSON ../../dotfiles/waybar/config.jsonc;
    style = readFile ../../dotfiles/waybar/style.css;
  };
  xdg.configFile."waybar/screen-recording-indicator.sh" = {
    source = ../../dotfiles/waybar/screen-recording-indicator.sh;
    executable = true;
  };
}
