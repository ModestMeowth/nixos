{pkgs, ...}: {
  imports = [
    ./cmp.nix
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      SchemaStore-nvim
    ];

    extraPackages = with pkgs;
      [
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
      ]
      ++ (with pkgs.nodePackages; [
        bash-language-server
        dockerfile-language-server-nodejs
        prettier
        pyright
        typescript-language-server
        vim-language-server
        vscode-langservers-extracted
      ]);

    extraLuaConfig =
      /*
      lua
      */
      ''
        -- LSP
        local lspconfig = require "lspconfig"
        local telescope = require "telescope.builtin"
        local schemastore = require "schemastore"

        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open diagnostics" })
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
                vim.keymap.set({"n", "v"}, "<leader>a", vim.lsp.buf.code_action, opts("Code actions"))
                vim.keymap.set("n", "<leader>r", telescope.lsp_references, opts("Open references picker"))
                vim.keymap.set("n", "<C-f>", function()
                    vim.lsp.buf.format({ async = true })
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
                        enable = true
                    },
                },
            },
        }
        lspconfig.yamlls.setup {
            settings = {
                yaml = {
                    schemas = schemastore.yaml.schemas(),
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                },
            },
        }

        lspconfig.bashls.setup {}
        lspconfig.dockerls.setup {}
        lspconfig.terraformls.setup {}

        lspconfig.pyright.setup {}
        lspconfig.gopls.setup {}
        lspconfig.rust_analyzer.setup {}
        lspconfig.tsserver.setup {}
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
