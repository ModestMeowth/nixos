{ inputs, pkgs, ... }:
{
  imports = [ inputs.hyprland.nixosModules.default ];

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
    };

    hyprlock.enable = true;
  };

  programs.uwsm = {
    enable = true;
    waylandCompositors = { };
  };
}
