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
    unstable.hyprpolkitagent
    unstable.hyprpicker

    bluetui
    grim
    libxkbcommon # xkbcli
    playerctl
    satty
    slurp
    wayfreeze
  ];

  services = {
    hyprpaper = {
      enable = true;
      package = pkgs.unstable.hyprpaper;
    };

    hyprpolkitagent = {
      enable = true;
      package = pkgs.unstable.hyprpolkitagent;
    };

    hyprsunset = {
      enable = true;
      package = pkgs.unstable.hyprsunset;
    };

    mako = {
      enable = true;
      extraConfig = ''
        font=${font}
      '' + readFile ../../dotfiles/mako/config;
    };

    tailscale-systray = lib.mkIf ts.enable {
      enable = true;
      package = ts.package;
    };

    swayosd.enable = true;
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = importJSON ../../dotfiles/waybar/config.jsonc;
    style = readFile ../../dotfiles/waybar/style.css;
  };
}
