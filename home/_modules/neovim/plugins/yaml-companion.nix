{ config, lib, pkgs, ... }: with lib; let
  cfg = config.modules.neovim.plugins.yaml-companion;
in
{
  options.modules.neovim.plugins.yaml-companion.enable = mkEnableOption "yaml-companion-nvim";

  config = lib.mkIf cfg.enable {
    modules.neovim.plugins.telescope.enable = true;

    programs.neovim = {
      plugins = [ pkgs.neovim-plugins.yaml-companion-nvim ];

      extraLuaConfig = # lua
        ''
          require "yaml-companion".setup {}
          require "telescope".load_extension("yaml_schema")
        '';
    };
  };
}
