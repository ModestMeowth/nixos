{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [ lazy-nvim ];
    extraPackages = with pkgs; [
      inotify-tools

      lua51Packages.lua
      lua51Packages.luarocks
      (python3.withPackages (p: [ p.pip ]))

      gcc

      lua51Packages.lua-lsp
      harper
      nil
      bash-language-server
    ];
  };
}
