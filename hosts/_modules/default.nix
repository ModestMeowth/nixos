{ inputs
, lib
, pkgs
, ...
}:
with lib;
{
  imports = [
    ./hw
    ./cluster
    ./monitoring
    ./services
    ./shares
    ./wm
  ];

  documentation.nixos.enable = false;
  system.stateVersion = "24.05";

  nix.registry = {
    stable.flake = inputs.nixpkgs;
    unstable.flake = inputs.unstable;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.log-lines = mkDefault 25;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 5";
  };

  time.timeZone = mkDefault "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.direnv.enable = true;
  programs.fish.enable = true;
  programs.git.enable = true;
  programs.tmux.enable = true;
  programs.vim.defaultEditor = true;

  environment.systemPackages = with pkgs; [
    age
    sops
  ];

  sops = {
    defaultSopsFile = ../../global.sops.yaml;
    age.generateKey = true;
    age.keyFile = "/var/lib/sops-nix/key.txt";
  };

  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "5424288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };
}
