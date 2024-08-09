{config, lib, pkgs, ...}: {
  options.hm-mm.editor.nvim.suda = lib.mkEnableOption "suda-vim";

  config = lib.mkIf config.hm-mm.editor.nvim.suda {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.vim-suda ];

      extraLuaConfig =
        /*
        lua
        */
        ''
          -- Suda
          vim.keymap.set("c", "r!!", "SudaRead %")
          vim.keymap.set("c", "w!!", "SudaWrite %")
        '';
    };
  };
}
