{ pkgs, lib, ... }: {
  imports = [ ./audio.nix ./fonts.nix ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    hyprlock
    hypridle
    hyprpaper
    hyprpicker
    hyprsunset
    hyprutils
    kitty
    libnotify
    mako
    waybar
    wl-clipboard
    wofi
  ];
}
