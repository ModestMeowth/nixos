{
  den.aspects.yubikey = {
    nixos = {
      programs.yubikey-manager.enable = true;
    };

    _.u2f = {
      nixos = {
        security.pam.u2f = {
          enable = true;
          settings.cue = true;
        };

        services.pcscd.enable = true;
      };
    };
  };
}
