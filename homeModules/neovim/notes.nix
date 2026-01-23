{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ outline-nvim ];

    autoCmd = [
      {
        event = "FileType";
        pattern = [
          "markdown"
          "tex"
        ];
        callback.__raw = "function() vim.opt_local.conceallevel=2 end";
      }
    ];

    plugins = {
      img-clip = {
        enable = true;
        settings.default = {
          url_encode_path = true;
        };
      };

      markdown-preview.enable = true;

      obsidian = {
        enable = true;
        settings = {
          legacy_commands = false;
          workspaces = [
            {
              name = "Notes";
              path = "~/Notes";
            }
          ];
        };
      };
    };
  };
}
