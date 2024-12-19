{ pkgs, ... }: {
  wsl.enable = true;
  wsl.wslConf.interop.appendWindowsPath = true;
  wsl.startMenuLaunchers = true;

  # Nvidia
  programs.nix-ld = {
    enable = true;
    libraries = [ pkgs.unstable.linuxPackages.nvidia_x11 ];
  };

  environment.shellAliases.nvidia-smi = "NIX_LD_LIBRARY_PATH=/usr/lib/wsl/lib /usr/lib/wsl/lib/nvidia-smi";
}
