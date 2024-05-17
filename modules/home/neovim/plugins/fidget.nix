{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      fidget-nvim
    ];

    extraLuaConfig =
      /*
      lua
      */
      ''
        -- Fidget
        require "fidget".setup {}
      '';
  };
}
