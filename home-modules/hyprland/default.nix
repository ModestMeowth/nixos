{ezModules, ... }:
{
  imports = [
    ezModules.tte
    ezModules.walker

    ./hypridle.nix
    ./scripts.nix
    ./shell.nix
  ];

  home.sessionPath = [ "$HOME/.local/bin" ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.variables = ["--all"];
    settings = {
      source = [
        "~/.config/hypr/hyprland.conf.d/*"
      ];
      input.follow_mouse = 2;
    };
  };

  xdg.configFile."hypr/hyprland.conf.d" = {
    source = ../../dotfiles/hypr/hyprland.conf.d;
    recursive = true;
  };
}
