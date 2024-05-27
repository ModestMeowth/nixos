{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    crowbar
    hashcat
    john
    dsniff
  ];
}
