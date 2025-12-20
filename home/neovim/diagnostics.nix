{
  programs.nixvim = {
    diagnostic.settings = {
      virtual_text = false;
      virtual_lines = {
        only_current_line = false;
        highlight_whole_line = true;
      };
    };

    keymaps = [
      {
        key = "<leader>l";
        action = ''require("lsp_lines").toggle'';
        options.desc = "Toggle lsp_lines";
      }
    ];

    plugins.lsp-lines.enable = true;
  };
}
