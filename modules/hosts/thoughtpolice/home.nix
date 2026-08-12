{ den, ... }:
{
  den.homes.x86_64-linux."mm@thoughtpolice" = { };

  den.aspects.mm._.thoughtpolice = {
    includes = with den.aspects.desktop._; [
      dms._.hyprland
      chromium
      ghostty
    ];

    homeManager = {
      nixpkgs.config.cudaSupport = true;

      wayland.windowManager.hyprland.settings = {
        config.opengl.nvidia_anti_flicker = true;

        monitor = [
          {
            output = "DP-1";
            mode = "3440x1440@60";
            position = "0x0";
          }
          {
            output = "HDMI-A-1";
            mode = "1920x1080";
            position  = "3440x0";
            transform = 1;
          }
        ];

        workspace_rule = [
          {
            workspace = "1";
            monitor = "DP-1";
          }
          {
            workspace = "2";
            monitor = "HDMI-A-1";
          }
        ];
      };
    };
  };
}
