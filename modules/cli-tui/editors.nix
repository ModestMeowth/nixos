{ pkgs, ... }: {
  imports = [ ../shared/fonts.nix ];
  environment.systemPackages = with pkgs; [
    emacs
    emacsPackages.mu4e

    # Doom Emacs
    (aspellWithDicts (p: with p; [ en en-computers en-science ]))
    fd
    imagemagick
    ripgrep
    texlive.combined.scheme-small
    vips
  ];

  services.emacs.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
