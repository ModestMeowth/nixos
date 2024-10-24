{ inputs, pkgs, ... }:
{
  programs.firefox.enable = true;
  modules.neovim.profile = "development";
  modules.term.wezterm.enable = true;

  programs.gh.enable = true;
  home.packages = [ pkgs.commitizen ];

  modules.wm.gnome = {
    enable = true;

    dracula.enable = true;
    forge.enable = true;
    gsconnect.enable = true;
    no-overview.enable = true;
    user-themes.enable = true;
  };

  xdg.configFile."k9s/skins/dracula.yaml".source = inputs.dracula.k9s;
  programs.k9s = {
    enable = true;
    settings.k9s.skin = "dracula";
  };

  services.syncthing.enable = true;
  modules.gaming.retroarch.enable = true;
}
