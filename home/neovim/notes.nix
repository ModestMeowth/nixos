{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [ outline-nvim ];
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
