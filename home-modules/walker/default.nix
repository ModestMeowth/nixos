{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
  inherit (builtins) readFile;
in
{
  imports = [
    ./elephant.nix
    ./walker.nix
  ];

  programs = {
    walker = {
      enable = true;
      settings = fromTOML (readFile ../../dotfiles/walker/config.toml);
    };
  };

  wayland.windowManager.hyprland.settings.bind = [
    {
      _args = [
        "SUPER+SPACE"
        (
          # lua
          lua ''hl.dsp.exec_cmd("launch-walker")''
        )
        { description = "App launcher"; }
      ];
    }
  ];

  xdg.configFile = {
    "walker/themes/sytle/style.css".text =
      readFile ../../dotfiles/walker/themes/catppuccin.css + readFile ../../dotfiles/walker/themes/style.css;
    "walker/themes/style/layout.xml".source = ../../dotfiles/walker/themes/layout.xml;

    "elephant" = {
      source = ../../dotfiles/elephant;
      recursive = true;
    };
  };
}
