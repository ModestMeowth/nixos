{den, lib, ...}:
let
  inherit (lib) mkDefault;
in
{
  den.aspects.profile.server = {
    includes = with den.aspects; [
      profile
      boot
    ];

    nixos = {
      environment.enableAllTerminfo = mkDefault true;
    };
  };
}
