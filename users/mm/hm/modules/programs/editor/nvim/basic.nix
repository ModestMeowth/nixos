{config, lib, ...}: {
  config = lib.mkIf (config.hm-mm.editor.nvim.profile == "basic") {
    hm-mm.editor.nvim = {
      enable = true;
      cloak = true;
      dracula = true;
      fidget = true;
      suda = true;
      telescope = true;
      treesitter = true;
      undotree = true;
    };
  };
}
