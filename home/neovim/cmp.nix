{
  programs.nixvim = {
    plugins.cmp = {
      enable = true;
      settings = {
        keymap.preset = "default";
        appearance.nerd_font_variant = "mono";
        fuzzy.implementation = "prefer_rust_with_warning";
      };
    };
  };
}
