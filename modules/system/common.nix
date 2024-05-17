{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.05";
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  time.timeZone = "America/Chicago";

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
    agenix
    pciutils
    git
    curl
    age
    direnv
  ];

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = true;
    };
    doas.enable = false;
  };

  services = {
    tailscale.enable = true;
  };
}
