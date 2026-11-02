{ den, lib, ... }:
let
  inherit (lib) mkDefault;
  stateVersion = "26.11";
in
{
  den.default = {
    includes = with den._; [
      define-user
      hostname
    ]
    ++
    (with den.aspects; [
      apps
    ]);

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
          fwupd.enable = true;

          logind.settings.Login = {
            HandlePowerKey = mkDefault "suspend";
            LidSwitchIgnoreInhibited = "no";
          };

          pipewire = {
            enable = mkDefault true;
            pulse.enable = mkDefault true;
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
