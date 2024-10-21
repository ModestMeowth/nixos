{ config, lib, ... }:
with lib;
let
  cfg = config.modules.neovim;
in
{
  config = mkIf (cfg.profile == "development") {
    programs.neovim.enable = true;
    modules.neovim.plugins = {
      cloak.enable = true;
      dracula.enable = true;
      fidget.enable = true;
      lsp.enable = true;
      suda.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      trouble.enable = true;
      undotree.enable = true;
      yaml-companion.enable = true;
    };
  };
}
