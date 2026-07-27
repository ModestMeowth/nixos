{ den, ... }:
{
  den.aspects.desktop._.hyprland = {
    includes = with den.aspects.desktop._; [ wayland ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          egl-wayland
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

          uwsm = {
            enable = true;
            waylandCompositors = { };
          };
        };
      };

    homeManager =
      { ... }:
      {

      };
  };
}
