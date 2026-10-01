{den, inputs, ...}:
{
  den.aspects.desktop._.plasma = {
    includes = with den.aspects; [
      desktop
      desktop._.wayland
    ];

    nixos =
      { lib, pkgs, ... }:
      {
        services = {
          desktopManager.plasma6 = {
            enable = true;
            notoPackage = pkgs.nerd-fonts.noto;
          };

          displayManager.plasma-login-manager.enable = lib.mkDefault true;
        };
      };

    homeManager =
      { system, ...}: {
        imports = [ inputs.plasma-manager.homeModules.plasma-manager ];      

        home.packages = [ inputs.plasma-manager.packages.${system}.rc2nix ];
      };
  };
}
