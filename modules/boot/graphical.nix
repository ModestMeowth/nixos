{ den, ... }:
{
  den.aspects.boot.graphical = {
    includes = with den.aspects; [ boot ];

    nixos =
      {lib, pkgs, ...}:
      let
        inherit (lib) mkDefault;
      in
      {
        boot = {
          plymouth = {
            enable = mkDefault true;
            theme = mkDefault "catppuccin-mocha";
            themePackages = mkDefault [ (pkgs.catppuccin-plymouth.override { variant = "mocha"; }) ];
          };

          consoleLogLevel = mkDefault 3;
          kernelParams = [
            "quiet"
            "splash"
            "boot.shell_on_fail"
            "udev.log_priority=3"
            "rd.systemd.show_status=auto"
          ];
        };

        stylix.targets.plymouth.enable = false;
      };
  };
}
