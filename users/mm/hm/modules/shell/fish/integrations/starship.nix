{inputs, config, lib, ...}: {
  options.hm-mm.shell.fish.starship = lib.mkEnableOption "fish-starship";

  config = lib.mkIf config.hm-mm.shell.fish.starship {
    programs.starship = {
      enable = true;
      enableTransience = true;
    };

    xdg.configFile."starship.toml".source = "${inputs.mm.outputs.dotfiles}/dot_config/starship.toml.tmpl";
  };
}
