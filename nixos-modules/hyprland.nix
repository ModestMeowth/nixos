{inputs, pkgs, ...}: {
  imports = [inputs.walker.nixosModules.default];
  environment.systemPackages = with pkgs; [
    hyprlock
    hypridle
    hyprpaper
    hyprpicker
    hyprsunset
    libnotify
    mako
    waybar
    wl-clipboard
  ];

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    walker.enable = true;
  };
}
