{config, lib, pkgs, ...}: with lib; let
  cfg = config.modules.neovim.plugins.cloak;
in {
  options.modules.neovim.plugins.cloak.enable = mkEnableOption "cloak-nvim";

  config = mkIf cfg.enable {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.cloak-nvim ];

      extraLuaConfig = /* lua */ ''
        -- Cloak
        require "cloak".setup {
          enabled = true,
          cloak_character = "*";
          highlight_group = "Comment",
          patterns = {
            {
              file_pattern = {
                ".env*",
              },
              cloak_pattern = "=.+",
            },
          },
        }
      '';
    };
  };
}
