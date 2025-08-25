{
  program.nixvim.keymaps = [
    {
      action = "<nop>";
      key = "Q";
      mode = "n";
    }
    {
      action = ''"+y'';
      key = "<leader>y";
      mode = [ "n" "v" ];
    }
    {
      action = ''"+Y'';
      key = "<leader>Y";
      mode = "n";
    }
    {
      action = ''"+p'';
      key = "<leader>p";
      mode = [ "n" "v" ];
    }
    {
      action = ''"+P'';
      key = "<leader>P";
      mode = [ "n" "v" ];
    }
    {
      action = "vim.lsp.buf.hover";
      key = "<leader>k";
      mode = "n";
    }
  ];
}
