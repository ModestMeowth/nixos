{ pkgs, ... }: let
  k9s-theme = pkgs.dracula.k9s.theme;
in {
  programs = {
    k9s.enable = true;
    k9s.settings.k9s.skin = "dracula";
  };
  xdg.configFile."k9s/skins/dracula.yaml".text = k9s-theme;
}
