{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      virt-manager
      xdg-utils
    ];
  };
}
