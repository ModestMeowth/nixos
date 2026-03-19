let
  inherit (builtins) fromTOML readFile;
in
{
  services.walker = {
    enable = true;
    systemd.enable = true;

    settings = fromTOML (readFile ../dotfiles/walker/config.toml);
  };

  xdg.configFile = {
    "walker/themes/style/style.css".text =
      readFile ../dotfiles/walker/themes/catppuccin.css + readFile ../dotfiles/walker/themes/style.css;
    "walker/themes/style/layout.xml".source = ../dotfiles/walker/themes/layout.xml;
  };
}
