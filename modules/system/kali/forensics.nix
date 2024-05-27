{pkgs, ...}: {
  environmnet.systemPackages = with pkgs; [
    ghidra
  ];
}
