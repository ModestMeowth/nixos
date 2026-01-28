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
    defaultUser = "mm";
    startMenuLaunchers = true;
    useWindowsDriver = true;

    wslConf = {
      user.default = "mm";
      network = {
        generateHosts = false;
        generateResolvConf = false;
      };
    };
  };

  fleet.isWsl = true;

  environment.shellAliases.nvidia-smi = "NIX_LD_LIBRARY_PATH=/usr/lib/wsl/lib /usr/lib/wsl/lib/nvidia-smi";

  networking = {
    firewall.enable = lib.mkForce false;
    nftables.enable = lib.mkForce false;

    hostName = "videodrome";

    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];

    search = [
      "cat-alkaline.ts.net"
      "home.arpa"
    ];
  };

  programs = {
    dconf.enable = true;
    nix-ld.enable = true;
  };

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

  shares.pwnyboy-media.enable = true;
}
