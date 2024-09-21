{pkgs, ...}: {
  imports = [
    ./cluster
    ./hw
    ./misc
    ./programs
    ./utils
  ];

  system.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  documentation.man.generateCaches = true;

  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 5";
      };
    };

    command-not-found.enable = false;
    nix-index.enable = true;
    vim.defaultEditor = true;
    tmux.enable = true;
  };

  environment.systemPackages = with pkgs; [
    curl
    direnv
    git
    pciutils
  ];
}
