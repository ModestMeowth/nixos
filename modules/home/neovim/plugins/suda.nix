{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      suda-vim
    ];

    extraLuaConfig =
      /*
      lua
      */
      ''
        -- Suda
        vim.keymap.set("c", "r!!", "SudaRead %")
        vim.keymap.set("c", "w!!", "SudaWrite %")
      '';
  };
}
