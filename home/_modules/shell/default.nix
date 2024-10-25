{
  imports = [
    ./fish.nix
    ./fzf.nix
    ./starship.nix
    ./zellij.nix
  ];

  programs = {
    direnv.enable = true;
    eza.enable = true;
    zoxide.enable = true;

    fzf.enable = true;
    fd = {
      enable = true;
      hidden = true;
      ignores = [ ".git/*" "*.bak" ];
    };

    starship.enable = true;
    zellij.enable = true;
  };
}
