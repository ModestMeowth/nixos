{ pkgs, ... }:
let
  k9s-theme = pkgs.dracula.k9s.theme;
in
{
  programs.chromium.enable = true;
  programs.firefox.enable = true;

  modules.neovim.profile = "development";
  modules.term.wezterm.enable = true;
  modules.virt-man.enable = true;

  programs.gh.enable = true;

  modules.wm.gnome = {
    enable = true;

    dracula.enable = true;
    forge.enable = true;
    gsconnect.enable = true;
    no-overview.enable = true;
    user-themes.enable = true;
  };

  xdg.configFile."k9s/skins/dracula.yaml".text = k9s-theme;
  programs.k9s = {
    enable = true;
    settings.k9s.skin = "dracula";
  };

  services.syncthing.enable = true;
  modules.gaming.retroarch.enable = true;
}
