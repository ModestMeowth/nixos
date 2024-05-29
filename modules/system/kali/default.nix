{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ghidra
    nmap
    vulnix
    wireshark
  ];
}
