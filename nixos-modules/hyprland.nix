{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gpu-screen-recorder
    ffmpeg
    v4l-utils
    wl-clipboard
    wl-clip-persist
  ];

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };

    hyprlock.enable = true;
  };

  programs.uwsm = {
    enable = true;
    waylandCompositors = { };
  };
}
