{den, ...}:
{
  den.aspects.wm.plasma = {
    includes = with den.aspects; [
      desktop.wm
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
  };
}
