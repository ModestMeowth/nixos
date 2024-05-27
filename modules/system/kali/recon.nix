{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    dnsenum
    dnsrecon
    hping
    netcat
    nmap
    ntopng
    wireshark
  ];
}
