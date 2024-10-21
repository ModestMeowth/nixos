{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.neovim.plugins.dracula;
in
{
  options.modules.neovim.plugins.dracula.enable = mkEnableOption "dracula-nvim";

  config = mkIf cfg.enable {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.dracula-nvim ];

      extraLuaConfig = # lua
        ''
          vim.cmd("colorscheme dracula")
        '';
    };
  };
}
