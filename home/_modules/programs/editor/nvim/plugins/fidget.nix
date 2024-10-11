{config, lib, pkgs, ...}: {
  options.hm-mm.editor.nvim.fidget = lib.mkEnableOption "fidget-nvim";

  config = lib.mkIf config.hm-mm.editor.nvim.fidget {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.fidget-nvim ];

      extraLuaConfig = /* lua */ ''
          -- Fidget
          require "fidget".setup {}
        '';
    };
  };
}
