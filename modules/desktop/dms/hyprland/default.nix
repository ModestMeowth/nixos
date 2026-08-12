{den, ...}:
{
  den.aspects.desktop._.dms._.hyprland = {
    includes = [
      den.aspects.desktop._.dms
      den.aspects.desktop._.hyprland
    ];

    nixos = {
      services.displayManager.dms-greeter.compositor.name = "hyprland";
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
