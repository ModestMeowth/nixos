{den, lib, ...}:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.hw.yubikey = {
    nixos = {
      programs.yubikey-manager.enable = true;
    };

    u2f = {
      includes = with den.aspects; [ hw.yubikey ];

      nixos = {
        security.pam = {
          u2f = {
            enable = mkDefault true;
            settings.cue = mkDefault true;
          };

          services = {
            login.u2fAuth = mkDefault false; # login with password to unlock keyring
            kde.u2fAuth = mkDefault false; # prevents unlocking from yubikey
          };
        };

        services.pcscd.enable = true;
      };
    };
  };
}
