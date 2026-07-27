{ inputs, ... }:
{
  den.aspects.dev._.helix = {
    homeManager =
      { lib, pkgs, ... }:
      let
        conf = lib.importTOML (inputs.self + /dotfiles/helix/config.toml);
      in
      {
        programs.helix = {
          enable = true;
          defaultEditor = true;
          extraPackages = with pkgs; [
            harper
            markdown-oxide
            nixd
          ];

          settings = conf;
        };
      };
  };
}
