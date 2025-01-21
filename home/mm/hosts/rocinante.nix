{ pkgs, ... }:
let
  k9s-theme = pkgs.dracula.k9s.theme;
in
{
  xdg.configFile."k9s/skins/dracula.yaml".text = k9s-theme;

  dconf.settings."org/gnome/desktop/applications/terminal".exec = "ghostty";

  programs = {
    chromium.enable = true;
    ghostty.enable = true;
    k9s.enable = true;
    k9s.settings.k9s.skin = "dracula";
  };

  home = {
    packages = with pkgs; [
      virt-manager
    ];
  };

  services = {
    syncthing.enable = true;
  };
}
