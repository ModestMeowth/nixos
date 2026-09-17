{
  den.aspects.yubikey = {
    nixos = {
      programs.yubikey-manager.enable = true;
    };

    _.u2f = {
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
