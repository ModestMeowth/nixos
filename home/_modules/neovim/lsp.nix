{ config, lib, pkgs, ... }:
let
  cfg = config.programs.neovim;
in
{
  programs.neovim = lib.mkIf cfg.enable {
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-cmdline
      cmp_luasnip
      cmp-nvim-lsp
      cmp-path
      luasnip
      nvim-cmp
      nvim-lspconfig
      SchemaStore-nvim
    ];

    extraPackages =
      with pkgs;
      [
        # 4.10 is broken in stable but not unstable
        vscode-langservers-extracted
        alejandra
        clang-tools
        gopls
        lua-language-server
        nil
        marksman
        rust-analyzer
        tailwindcss-language-server
        taplo
        terraform-ls
        tflint
        yaml-language-server
        zls
      ] ++ (with pkgs.nodePackages; [
        bash-language-server
        dockerfile-language-server-nodejs
        prettier
        pyright
        typescript-language-server
        vim-language-server
      ]);

    extraLuaConfig = # lua
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

        -- LSP
        local lspconfig = require "lspconfig"
        local schemastore = require "schemastore"

        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
        vim.keymap.set("n", "<C-f>", "<nop>")

        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("UserLspConfig", {}),
          callback = function(ev)
            local function opts(desc)
              return { buffer = ev.buf, desc = desc }
            end

            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Goto declaration"))
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Goto definition"))
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Goto implementation"))
            vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts("Hover"))
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("Show signature"))
            vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, opts("Rename symbol"))
            vim.keymap.set({"n", "v"}, "<leader>a", vim.lsp.buf.code_action, opts("Code action"))
            if tbuiltin then
              vim.keymap.set("n", "<leader>r", tbuiltin.lsp_references, opts("Open references picker"))
            end
            vim.keymap.set("n", "<C-f>", function()
              vim.lsp.buf.format({async = true})
            end, opts("Format buffer"))
          end,
        })

        lspconfig.vimls.setup {}
        lspconfig.lua_ls.setup {
          settings = {
            Lua = {
              diagnostics = {
                globals = {
                  "vim"
                },
              },
            },
          },
        }

        lspconfig.nil_ls.setup {
          settings = {
            ['nil'] = {
              formatting = {
                command = {
                  "alejandra",
                  "-qq",
                },
              },
            },
          },
        }

        lspconfig.taplo.setup {}
        lspconfig.jsonls.setup {
          settings = {
            json = {
              schemas = schemastore.json.schemas(),
              validate = {
                enable = true,
              },
            },
          },
        }

        if yaml_companion == nil then
          lspconfig.yamlls.setup {
            settings = {
              yaml = {
                customTags = {
                  "!include_dir_list",
                  "!include_dir_merge_list",
                  "!include_dir_merge_named",
                  "!include_dir_named",
                },
                schemas = schemastore.yaml.schemas(),
                schemaStore = {
                  enable = false,
                  url = "",
                },
              },
            },
          }
        else
          lspconfig.yamlls.setup(yaml_companion)
        end

        lspconfig.bashls.setup {}
        lspconfig.dockerls.setup {}
        lspconfig.terraformls.setup {}

        lspconfig.pyright.setup {}
        lspconfig.gopls.setup {}
        lspconfig.rust_analyzer.setup {}
        lspconfig.ts_ls.setup {}
        lspconfig.clangd.setup {}
        lspconfig.zls.setup {}

        lspconfig.marksman.setup {}
        lspconfig.ltex.setup {}

        lspconfig.html.setup {}
        lspconfig.cssls.setup {}
        lspconfig.tailwindcss.setup {}
        lspconfig.htmx.setup {}
      '';
  };
}
