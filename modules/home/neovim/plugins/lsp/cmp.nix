{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-cmdline
      cmp_luasnip
      cmp-nvim-lsp
      cmp-path
      luasnip
      nvim-cmp
    ];

    extraLuaConfig =
      /*
      lua
      */
      ''
        -- CMP
        local cmp = require "cmp"

        cmp.setup {
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert {
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = false,
                },
            },
            sources = cmp.config.sources {
                { name = "nvim-lsp" },
                { name = "buffer" },
                { name = "path" },
            },
        }
      '';
  };
}
