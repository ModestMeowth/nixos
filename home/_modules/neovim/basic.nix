{ config, lib, ... }:
with lib;
let
  cfg = config.modules.neovim;
in
{
  config = mkIf (cfg.profile == "basic") {
    modules.neovim.plugins = {
      cloak.enable = true;
      dracula.enable = true;
      fidget.enable = true;
      suda.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      undotree.enable = true;
    };
  };
}
