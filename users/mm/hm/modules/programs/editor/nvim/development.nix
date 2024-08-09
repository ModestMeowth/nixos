{config, lib, ...}: {
  config = lib.mkIf (config.hm-mm.editor.nvim.profile == "development") {
    hm-mm.editor.nvim = {
      enable = true;
      cloak = true;
      dracula = true;
      fidget = true;
      lsp = true;
      suda = true;
      telescope = true;
      treesitter = true;
      trouble = true;
      undotree = true;
    };
  };
}
