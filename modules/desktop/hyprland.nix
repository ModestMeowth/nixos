{ pkgs, ... }: {
  services.greetd = {
    enable = true;
    settings.default_session.command = ''
      ${pkgs.tuigreet}/bin/tuigreet --time --time-format "%R" --theme "border=blue;text=white;prompt=white;time=yellow;action=green;button=white;container=black;input=magenta" --cmd Hyprland
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
