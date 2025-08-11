{
  programs = {
    # Nvidia
    nix-ld = { enable = true; };
  };

  # Nvidia
  environment.shellAliases.nvidia-smi =
    "NIX_LD_LIBRARY_PATH=/usr/lib/wsl/lib /usr/lib/wsl/lib/nvidia-smi";

  shares = {
    ha-config.enable = true;
    pwnyboy-media.enable = true;
  };
}
