{pkgs, ...}: {
  plugin = pkgs.nvimPlugins.nvim-cmp;
  configFile = ./cmp.lua;
  dependencies = with pkgs.nvimPlugins; [
    cmp-nvim-lsp
    cmp-buffer
    cmp-cmdline
    cmp-luasnip
    cmp-path
    lspkind
    nvim-cmp
    luasnip
  ];
}
