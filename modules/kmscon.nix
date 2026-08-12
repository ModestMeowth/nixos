{
  den.aspects.kmscon = {
    nixos =
      {pkgs, ...}:
      {
        fonts.packages = [ pkgs.nerd-fonts._0xproto ];
        services.kmscon = {
          enable = true;
          config = {
            hwaccel = true;
          };
        };
      };
  };
}
