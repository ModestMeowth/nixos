{ ... }:
{
  den.homes.x86_64-linux."mm@pwnyboy" = { };

  den.aspects.mm._.pwnyboy = {
    includes = [ ];

    homeManager =
      { pkgs, ... }:
      {
        catppuccin.cursors.enable = false;

        home.packages = with pkgs; [
          curl
          doggo
          nmap
        ];
      };
  };
}
