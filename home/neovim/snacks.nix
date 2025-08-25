{ pkgs, ... }: {

  programs.nixvim = {
    dependencies = {
      git.enable = true;
      imagemagick.enable = true;
      lazygit.enable = true;
      ripgrep.enable = true;
    };

    plugins.snacks = {
      enable = true;
      settings = {
        dim.enabled = true;
        explorer.enabled = true;
        git.enabled = true;
        image.enabled = true;
        indent.enabled = true;
        input.enabled = true;
        lazygit.enabled = true;
        picker = {
          enabled = true;
          db.sqlite3_path = "${pkgs.sqlite.out}/lib/libsqlite3.so";
        };
        win.enabled = true;
        words.enabled = true;
      };
    };

    keymaps = [
      {
        action.__raw = # lua
          ''function() Snacks.picker.smart() end'';
        options.desc = "Smart find files";
        key = "<leader>.";
      }
      {
        action.__raw = # lua
          ''function() Snacks.picker.smart { matcher = { frecency = true } } end'';
        options.desc = "Recently opened files";
        key = "<leader>fr";
      }
      {
        action.__raw = # lua
          ''function() Snacks.explorer() end'';
        options.desc = "File Explorer";
        key = "<leader>e";
      }
      {
        action.__raw = # lua
          ''function() Snacks.git.blame_line() end'';
        options.desc = "Git blame line";
        key = "<leader>gb";
      }
      {
        action.__raw = # lua
          ''function() Snacks.terminal.toggle() end'';
        options.desc = "Toggle terminal window";
        key = "<leader>ot";
      }
    ];

    extraPackages = with pkgs; [
      fd
      ghostscript_headless
      mermaid-cli
      sqlite
      texlive.combined.scheme-basic
    ];
  };
}
