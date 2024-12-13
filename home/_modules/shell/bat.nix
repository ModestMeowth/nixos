{ pkgs, ... }:
let
  theme = pkgs.dracula.sublime.theme;
in
{
  programs.bat = {
    enable = true;
    config.theme = "Dracula";
    extraPackages = with pkgs.bat-extras; [
      batman
      batdiff
      prettybat
    ];
  };

  xdg.configFile."bat/themes/Dracula.tmTheme".text = theme;
}
