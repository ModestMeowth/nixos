{
  config,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./secrets.nix
  ];

  wsl = {
    enable = true;

    wslConf.network = {
      hostname = "videodrome";
      generateHosts = false;
      generateResolvConf = false;
    };
  };

  environment.shellAliases.nvidia-smi = "NIX_LD_LIBRARY_PATH=/usr/lib/wsl/lib /usr/lib/wsl/lib/nvidia-smi";

  networking = {
    firewall.enable = lib.mkForce false;
    nftables.enable = lib.mkForce false;

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];

    search = [
      "cat-alkaline.ts.net"
      "home.arpa"
    ];

    # Tailscale breaks ssh without MTU 1500
    # interfaces.eth0.mtu = 1500;
  };

  programs = {
    dconf.enable = true;
    nix-ld.enable = true;
  };

  # # Allow NOPASSWD to set MTU if it drifts
  # security.sudo.extraRules = [
  #   {
  #     groups = [ "wheel" ];
  #     commands = [
  #       {
  #         command = "/run/current-system/sw/bin/ip link set dev eth0 mtu 1500";
  #         options = [
  #           "SETENV"
  #           "NOPASSWD"
  #         ];
  #       }
  #     ];
  #   }
  # ];

  services = {
    tailscale =
      let
        flags = [
          "--ssh"
          "--operator=mm"
        ];
      in
      {
        enable = true;
        authKeyFile = config.sops.secrets."tskey".path;
        extraUpFlags = flags ++ [ "--reset" ];
        extraSetFlags = flags;
      };
  };
}
