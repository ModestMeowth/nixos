{ pkgs, ... }: {
  wsl = {
    enable = true;
    wslConf.interop.appendWindowsPath = true;
  };

  programs = {
    # Nvidia
    nix-ld = {
      enable = true;
      libraries = [ pkgs.unstable.linuxPackages.nvidia_x11 ];
    };
  };

  # Nvidia
  environment.shellAliases.nvidia-smi = "NIX_LD_LIBRARY_PATH=/usr/lib/wsl/lib /usr/lib/wsl/lib/nvidia-smi";
}
