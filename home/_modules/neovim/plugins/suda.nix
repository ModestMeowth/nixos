{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.modules.neovim.plugins.suda;
in
{
  options.modules.neovim.plugins.suda.enable = lib.mkEnableOption "suda-vim";

  config = mkIf cfg.enable {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.vim-suda ];

      extraLuaConfig = # lua
        ''
          -- Suda
          vim.keymap.set("c", "r!!", "SudaRead %")
          vim.keymap.set("c", "w!!", "SudaWrite %")
        '';
    };
  };
}
