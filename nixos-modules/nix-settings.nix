{
  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "pwnyboy";
        sshUser = "mm";
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
      }
      {
        hostName = "thoughtpolice";
        sshUser = "mm";
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
      }
    ];

    settings = {
      experimental-features = "nix-command flakes";

      auto-optimise-store = true;
      keep-outputs = true;
      keep-derivations = true;

      allowed-users = [ "@wheel" ];
      trusted-users = [ "@wheel" ];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];

      extra-substituters = [
        "https://lanzaboote.cachix.org"
        "https://hyprland.cachix.org"
        "https://catppuccin.cachix.org"
        "https://walker.cachix.org"
        "https://walker-git.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      extra-trusted-public-keys = [
        "lanzaboote.cachix.org-1:Nt9//zGmqkg1k5iu+B3bkj3OmHKjSw9pvf3faffLLNk="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      ];
    };
  };
}
