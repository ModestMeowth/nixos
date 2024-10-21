{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.modules.neovim.plugins.fidget;
in
{
  options.modules.neovim.plugins.fidget.enable = mkEnableOption "fidget-nvim";

  config = mkIf cfg.enable {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.fidget-nvim ];

      extraLuaConfig = # lua
        ''
          -- Fidget
          require "fidget".setup {}
        '';
    };
  };
}
