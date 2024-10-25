{ config, lib, inputs, ... }: with lib; let
  cfg = config.programs.starship;
in
{
  config = mkIf cfg.enable {
    programs.starship.enableTransience = true;
    xdg.configFile."starship.toml".source = "${inputs.mm.outputs.dotfiles}/dot_config/starship.toml.tmpl";
  };
}
