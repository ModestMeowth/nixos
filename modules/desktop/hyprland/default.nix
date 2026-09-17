{ den, ... }:
{
  den.aspects.desktop._.hyprland = {
    includes = with den.aspects.desktop._; [ wayland ];

    nixos =
      { config, pkgs, ... }:
      let
        dm = config.services.displayManager;
      in
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
            withUWSM = !dm.gdm.enable;
          };

          uwsm.enable = !dm.gdm.enable;
        };
      };

    homeManager =
      { osConfig, ...}:
      let
        dm = osConfig.services.displayManager;
      in
      {
        wayland.windowManager.hyprland = {
          systemd = {
            enable = dm.gdm.enable;
            variables = [
              "DISPLAY"
              "HYPRLAND_INSTANCE_SIGNATURE"
              "WAYLAND_DISPLAY"
              "XDG_CURRENT_DESKTOP"
              "XDG_SESSION_TYPE"
              "PATH"
            ];
          };
        };
      };
  };
}
