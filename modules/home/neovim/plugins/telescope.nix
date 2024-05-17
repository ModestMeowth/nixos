{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      plenary-nvim
    ];

    extraPackages = with pkgs; [
      ripgrep
      fd
    ];

    extraLuaConfig =
      /*
      lua
      */
      ''
        -- Telescope
        require "telescope".setup {
          defaults = {
            layout_config = {
              horizontal = {
                width = 0.9,
              },
            },
          },
        }
        local builtin = require "telescope.builtin"
        vim.keymap.set("n", "<leader>pf", builtin.find_files)
        vim.keymap.set("n", "<C-p>", builtin.git_files)
        vim.keymap.set("n", "<leader>vh", builtin.help_tags)
      '';
  };
}
