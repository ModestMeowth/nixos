{den, inputs, ...}:
{
  den.aspects.desktop._.plasma = {
    includes = with den.aspects; [
      desktop
    ];

    homeManager =
      { lib, system, ... }:
      let
        inherit (lib) mkDefault;
      in
      {
        imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

        home.packages = [ inputs.plasma-manager.packages.${system}.rc2nix ];

        programs.plasma = {
          enable = true;
          overrideConfig = mkDefault true;
        };
      };
  };
}
