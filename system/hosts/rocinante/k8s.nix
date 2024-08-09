{pkgs, ...}: let
  masterIP = "192.168.0.116";
  masterHostname = "api.kube";
  masterPort = 6443;
in {
  environment.systemPackages = with pkgs; [
    fluxcd
    kompose
    kubernetes
    kubectl
  ];

  services.kubernetes = {
    masterAddress = masterIP;
    roles = ["master" "node"];
    easyCerts = true;
    apiserverAddress = "https://${masterHostname}:${toString masterPort}";
    apiserver = {
      securePort = masterPort;
      advertiseAddress = masterIP;
    };

    addons.dns.enable = true;
  };

  networking.extraHosts = "${masterIP} ${masterHostname}";

  sops.secrets = {
    "cloudflare-token" = {
      group = "wheel";
      mode = "0440";
    };

    "gh-flux-token" = {
      group = "wheel";
      mode = "0440";
    };
  };
}
