{den, ...}:
{
  den.aspects.desktop._.dms._.hyprland = {
    includes = [
      den.aspects.desktop
      den.aspects.desktop._.dms
      den.aspects.desktop._.hyprland
    ];

    nixos = {
      services.displayManager.dms-greeter.compositor = {
        name = "hyprland";
        customConfig = ''
          hl.env("DMS_RUN_GREETER", "1")

          hl.config({
            misc = { disable_hyprland_logo = true }
          })
        '';
      };
    };

    homeManager =
    let
      inherit (builtins) readFile;
    in
    {
      wayland.windowManager.hyprland.extraConfig = readFile ./bindings.lua;
    };
  };
}
