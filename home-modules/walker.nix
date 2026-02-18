{ inputs, ... }:
let
  inherit (builtins) fromTOML readFile;
in
{
  imports = [ inputs.walker.homeManagerModules.default ];

  programs.walker = {
    enable = true;
    runAsService = true;

    config = fromTOML (readFile ../dotfiles/walker/config.toml);
    themes."style" = {
      style =
        readFile ../dotfiles/walker/themes/catppuccin.css + readFile ../dotfiles/walker/themes/style.css;
      layouts."layout" = readFile ../dotfiles/walker/themes/layout.xml;
    };
  };
}
