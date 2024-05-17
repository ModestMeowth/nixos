{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      undotree
    ];

    extraLuaConfig =
      /*
      lua
      */
      ''
        -- Undotree
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
      '';
  };
}
