{
  programs.nixvim = {
    colorschemes.catppuccin.settings.integrations.cmp = true;

    plugins.cmp = {
      autoEnableSources = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        keymap.preset = "default";
        appearance.nerd_font_variant = "mono";
        fuzzy.implementation = "prefer_rust_with_warning";
      };
    };
  };
}
