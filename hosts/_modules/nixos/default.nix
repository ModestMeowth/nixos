{
  imports = [
    ./nix.nix
    ./sops.nix

    ./hw
    ./cluster
    ./monitoring
    ./services
    ./wm
  ];

  documentation.nixos.enable = false;
  system.stateVersion = "24.05";

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
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
}
