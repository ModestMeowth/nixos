{ pkgs, ... }:
let
  k9s-theme = pkgs.dracula.k9s.theme;
in
{
  xdg.configFile."k9s/skins/dracula.yaml".text = k9s-theme;

  programs = {
    chromium.enable = true;
    firefox.enable = true;

    wezterm.enable = true;
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

  gaming.retroarch.enable = true;
}
