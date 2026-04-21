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
  lib' = import ../lib.nix { inherit lib; };
  font = config.stylix.fonts.serif.name;
  fontMono = config.stylix.fonts.monospace.name;
  ts = osConfig.services.tailscale;
in
{
  home.packages = with pkgs; [
    hyprpolkitagent
    hyprpicker

    bluetui
    grim
    libxkbcommon # xkbcli
    playerctl
    satty
    slurp
    terminaltexteffects
    wayfreeze
  ];

  services = {
    hyprpaper.enable = true;
    hyprpolkitagent.enable = true;
    hyprsunset.enable = true;

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

  xdg = {
    configFile = lib'.mkBinFiles "waybar" [
      "idle-indicator.sh"
      "notification-silence-indicator.sh"
      "screen-recording-indicator.sh"
    ];

    portal.extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
