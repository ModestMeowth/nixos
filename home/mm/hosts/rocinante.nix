{ pkgs, ... }:
let
  k9s-theme = pkgs.dracula.k9s.theme;
in
{
  programs.chromium.enable = true;
  programs.firefox.enable = true;

  programs.wezterm.enable = true;
  programs.k9s.enable = true;
  programs.k9s.settings.k9s.skin = "dracula";
  xdg.configFile."k9s/skins/dracula.yaml".text = k9s-theme;

  home.packages = with pkgs; [
    virt-manager
  ];

  services.syncthing.enable = true;
  gaming.retroarch.enable = true;
}
