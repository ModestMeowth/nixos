{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    age
    sops
  ];

  sops = {
    defaultSopsFile = ../../../secrets.yaml;
    age.generateKey = true;
    age.keyFile = "/var/lib/sops-nix/key.txt";
  };
}
