{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    plugins = with pkgs.yaziPlugins; {
      git = git;
      mediainfo = mediainfo;
      mount = mount;
      ouch = ouch;
      rich-preview = rich-preview;
      starship = starship;
      time-travel = time-travel;
      yatline = yatline;
      yatline-catppuccin = yatline-catppuccin;
    };

    initLua = ''
      local catppuccin_theme = require("yatline-catppuccin"):setup("macchiato")
      require("yatline"):setup({
        theme = catppuccin_theme,
      })
    '';
  };
}
