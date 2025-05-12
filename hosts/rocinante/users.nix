{pkgs, ...}: {
  imports = [ ../../users/mm ];
  users.users.mm.shell = pkgs.unstable.nushell;
}
