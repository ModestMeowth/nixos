{ ... }:
{
  den.homes.x86_64-linux."mm@pwnyboy" = { };

  den.aspects.mm._.pwnyboy = {
    includes = [ ];

    homeManager =
      { lib, pkgs, ... }:
      {
        dconf.enable = false;
        stylix.icons.enable = lib.mkForce false;
        home.pointerCursor.enable = lib.mkForce false;
        home.packages = with pkgs; [
          curl
          doggo
          nmap
        ];
      };
  };
}
