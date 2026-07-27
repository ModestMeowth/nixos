{ lib, ... }:
{
  den.aspects.dev = {
    nixos = {
      programs.neovim = {
        enable = true;
        defaultEditor = lib.mkDefault true;
        viAlias = lib.mkDefault true;
        vimAlias = lib.mkDefault true;
      };
    };

    homeManager =
      { pkgs, ... }:
      {
        programs.jq.enable = true;
        home.packages = [ pkgs.yq ];
      };
  };
}
