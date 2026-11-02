{
  den.aspects.svc.kmscon = {
    nixos =
      {lib, pkgs, ...}:
      let
        inherit (lib) mkDefault;
      in
      {
        fonts.packages = [ pkgs.nerd-fonts._0xproto ];
        services.kmscon = {
          enable = true;
          config = {
            hwaccel = mkDefault true;
            multi-monitor = mkDefault "largest";
          };
        };
      };
  };
}
