{pkgs, ...}:
{
  home.packages = with pkgs; [
    curl
    dig
    nmap
  ];
}
