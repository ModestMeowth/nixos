{
  programs.nixvim = {
    plugins.lspconfig.enable = true;

    lsp.servers = {
      lua_ls.enable = true;
      nixd.enable = true;
      taplo.enable = true;
      yamlls.enable = true;
    };
  };
}
