{ pkgs, ... }: {
  services.greetd = {
    enable = true;
    settings.default_session.command = ''
      ${pkgs.tuigreet}/bin/tuigreet --time --time-format "%R" --cmd Hyprland
    '';
    useTextGreeter = true;
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    hyprlock
    hypridle
    hyprpaper
    hyprpicker
    hyprsunset
    hyprutils
    kitty
    libnotify
    mako
    walker
    waybar
    wl-clipboard
  ];
}
