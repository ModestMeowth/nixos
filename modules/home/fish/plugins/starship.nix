{inputs, pkgs, ...}: {
  programs.starship = {
    enable = true;
    enableTransience = true;
  };

  xdg.configFile."starship.toml".source = "${inputs.mm.outputs.dotfiles}/dot_config/starship.toml.tmpl";
}
