{ config, lib, inputs, ... }: with lib; let
  cfg = config.modules.shell.fish.plugins.starship;
in
{
  options.modules.shell.fish.plugins.starship.enable = mkEnableOption "fish-starship";

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableTransience = true;
    };

    xdg.configFile."starship.toml".source = "${inputs.mm.outputs.dotfiles}/dot_config/starship.toml.tmpl";
  };
}
