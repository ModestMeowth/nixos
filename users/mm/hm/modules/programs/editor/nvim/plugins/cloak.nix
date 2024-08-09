{config, lib, pkgs, ...}: {
  options.hm-mm.editor.nvim.cloak = lib.mkEnableOption "cloak-nvim";

  config = lib.mkIf config.hm-mm.editor.nvim.cloak {
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
