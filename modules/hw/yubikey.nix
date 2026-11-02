{den, ...}:
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
            enable = true;
            settings.cue = true;
          };
          services.login.u2fAuth = false; # login with password to unlock keyring
        };

        services.pcscd.enable = true;
      };
    };
  };
}
