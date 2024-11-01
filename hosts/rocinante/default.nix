{ hostname, pkgs, ... }: {
  networking.hostName = hostname;

  imports = [
    ./filesystems.nix
    ./hardware.nix
    ./secrets.nix
    ./users.nix
  ] ++ builtins.map (n: toString ./vms + "/${n}") (builtins.attrNames (builtins.readDir ./vms));

  modules.virt.enable = true;

  modules.monitoring.node-exporter.enable = true;
  modules.monitoring.smartd.enable = true;

  modules.services.chrony.enable = true;

  modules.services.ssh.enable = true;

  modules.services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
    authKey = /run/secrets/tskey;
  };

  modules.wm.gnome.enable = true;

  services.fwupd.enable = true;

  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  modules.shares.pwnyboy-share = {
    enable = true;
    mountpoint = "/persist/share";
  };

}
