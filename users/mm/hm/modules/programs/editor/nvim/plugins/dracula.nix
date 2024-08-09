{config, lib, pkgs, ...}: {
  options.hm-mm.editor.nvim.dracula = lib.mkEnableOption "dracula-nvim";

  config = lib.mkIf config.hm-mm.editor.nvim.dracula {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.dracula-nvim ];

      extraLuaConfig = /* lua */ ''
        vim.cmd("colorscheme dracula")
      '';
    };
  };
}
