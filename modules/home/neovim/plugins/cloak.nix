{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      cloak-nvim
    ];

    extraLuaConfig =
      /*
      lua
      */
      ''
        -- Cloak
        require "cloak".setup {
          enabled = true,
          cloak_character = "*",
          highlight_group = "Comment",
          patterns = {
            {
              file_pattern = {
                ".env*"
              },
              cloak_pattern = "=.+",
            },
          },
        }
      '';
  };
}
