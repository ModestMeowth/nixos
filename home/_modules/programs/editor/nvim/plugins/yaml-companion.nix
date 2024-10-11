{config, lib, myPkgs, ...}: {
  options.hm-mm.editor.nvim.yaml-companion = lib.mkEnableOption "yaml-companion-nvim";

  config = lib.mkIf config.hm-mm.editor.nvim.yaml-companion {
    hm-mm.editor.nvim.telescope = true;

    programs.neovim = {
      plugins = [ myPkgs.nvim-plugins.yaml-companion-nvim ];

      extraLuaConfig = /* lua */ ''
        require "yaml-companion".setup {}
        require "telescope".load_extension("yaml_schema")
      '';
    };
  };
}
