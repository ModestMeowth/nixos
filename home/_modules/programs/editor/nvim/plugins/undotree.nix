{config, lib, pkgs, ...}: {
  options.hm-mm.editor.nvim.undotree = lib.mkEnableOption "undotree";

  config = lib.mkIf config.hm-mm.editor.nvim.undotree {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.undotree ];

      extraLuaConfig = /* lua */ ''
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
      '';
    };
  };
}
