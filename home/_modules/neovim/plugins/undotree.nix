{ config, lib, pkgs, ... }: with lib; let
  cfg = config.modules.neovim.plugins.undotree;
in
{
  options.modules.neovim.plugins.undotree.enable = mkEnableOption "undotree";

  config = mkIf cfg.enable {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.undotree ];

      extraLuaConfig = # lua
        ''
          vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        '';
    };
  };
}
