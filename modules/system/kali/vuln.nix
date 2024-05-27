{pkgs, ...}: {
  environmnet.systemPackages = with pkgs; [
    grype
    lynix
    vulnix
  ];
}
