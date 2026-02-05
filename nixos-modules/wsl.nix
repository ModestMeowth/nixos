{inputs, lib, ...}: {
  imports = [
    inputs.wsl.nixosModules.wsl
  ];

  services = {
    chrony.enable = lib.mkForce false;
    udisks2.enable = lib.mkForce false;
    upower.enable = lib.mkForce false;
  };

  networking = {
    firewall.enable = lib.mkForce false;
    nftables.enable = lib.mkForce false;
  };

  wsl = {
    enable = true;
    defaultUser = lib.mkDefault "mm";
    startMenuLaunchers = lib.mkDefault true;
    useWindowsDriver = lib.mkDefault true;

    wslConf = {
      user.default = lib.mkDefault "mm";
      network =  {
        generateHosts = lib.mkDefault false;
        generateResolvConf = lib.mkDefault false;
      };
    };
  };
}
