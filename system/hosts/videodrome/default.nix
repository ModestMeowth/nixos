{
  lib,
  pkgs,
  ...
}: {
  imports =
    [
      ./users.nix
    ]
    ++ (let
      p = ../../../modules/system;
    in [
      (p + "/wsl.nix")
      (p + "/ssh.nix")
    ]);

  wsl = {
    wslConf = {
      network = {
        hostname = "videodrome";
        generateHosts = false;
        generateResolvConf = false;
      };
      user.default = "mm";
    };
    defaultUser = "mm";
  };

  networking = {
    nameservers = [
      "100.100.100.100"
    ];
    search = [
      "cat-alkaline.ts.net"
    ];
  };

  environment.systemPackages = with pkgs; [
  ];

  services = {
    openssh.listenAddresses = [
      {addr = "100.67.248.24";}
      {addr = "fd7a:115c:a1e0::301:f818";}
    ];
  };

  systemd.services.sshd = {
    overrideStrategy = "asDropin";
    unitConfig.After = lib.mkForce "tailscaled.service";
  };
}
