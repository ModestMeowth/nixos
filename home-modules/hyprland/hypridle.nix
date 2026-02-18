{
  services.hypridle.enable = true;
  xdg.configFile."hypr/hypridle.conf".text = builtins.readFile ../../dotfiles/hypr/hypridle.conf;
}
