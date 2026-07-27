{ den, lib, ... }:
let
  stateVersion = "26.11";
in
{
  den.default = {
    includes = with den._; [
      define-user
      hostname
    ];

    nixos =
      { pkgs, ... }:
      {
        system.stateVersion = stateVersion;

        networking.hostId = "00bab10c";

        i18n.defaultLocale = "en_US.UTF-8";
        time.timeZone = "America/Chicago";

        documentation = {
          doc.enable = false;
          info.enable = false;
          man.cache.enable = false;
          nixos.enable = false;
        };

        services = {
          logind.settings.Login = {
            HandlePowerKey = lib.mkDefault "suspend";
            LidSwitchIgnoreInhibited = "no";
          };

          power-profiles-daemon.enable = true;
        };

        security.pam.loginLimits = [
          {
            domain = "@wheel";
            item = "nofile";
            type = "soft";
            value = "5424288";
          }
          {
            domain = "@wheel";
            item = "nofile";
            type = "hard";
            value = "1048576";
          }
        ];

        environment.localBinInPath = true;

        fonts.packages = [ pkgs.nerd-fonts.symbols-only ];

        hardware.bluetooth.enable = true;
      };

    homeManager =
      { ... }:
      {
        home.stateVersion = stateVersion;
      };
  };
}
