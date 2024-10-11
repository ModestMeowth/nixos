{config, lib, pkgs, ...}: {
  options.hm-mm.editor.nvim.trouble = lib.mkEnableOption "trouble-nvim";

  config = lib.mkIf config.hm-mm.editor.nvim.trouble {
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [ trouble-nvim ];

      extraLuaConfig =
        /*
        lua
        */
        ''
          require "trouble".setup {}
          vim.keymap.set("n", "<leader>tt", function()
              require "trouble".toggle()
          end)

          vim.keymap.set("n", "[t", function()
              require "trouble".next {
                  skip_groups = true,
                  jump = true,
              }
          end)

          vim.keymap.set("n", "]t", function()
              require "trouble".previous {
                      skip_groups = true,
                      jump = true,
                  }
          end)
        '';
    };
  };
}
