{ den, ... }:
{
  den.default = {
    includes = [
      (den._.unfree [
        "ventoy"
      ])
      (den._.insecure [
        "ventoy-1.1.12"
      ])
    ];

    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          age
          curl
          eza
          fd
          fzf
          killall
          lsof
          pciutils
          ripgrep
          sops
          usbutils
          wget
        ];

        programs = {
          bat.enable = true;
          git.enable = true;
          htop.enable = true;

          mosh = {
            enable = true;
            openFirewall = true;
          };

          nh.enable = true;
          neovim = {
            enable = true;
            defaultEditor = true;
          };

          tmux.enable = true;
        };

        services = {
          udisks2.enable = true;
          upower.enable = true;
        };
      };

    homeManager =
      { config, pkgs, ... }:
      let
        inherit (config.catppuccin) accent;
      in
      {
        home.packages = with pkgs; [
          just
          unzip
        ];

        programs = {
          bat = {
            enable = true;
            extraPackages = [ pkgs.bat-extras.core ];
          };

          eza.enable = true;
          fd.enable = true;
          fzf.enable = true;
          ripgrep.enable = true;
          starship.enable = true;

          yazi = {
            enable = true;
            shellWrapperName = "y";

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

            initLua = # lua
              ''
                local catppuccin_theme = require("yatline-catppuccin"):setup("${accent}")
                require("yatline"):setup({
                  theme = catppuccin_theme,
                })
              '';
          };

          zoxide.enable = true;
        };
      };
  };
}
