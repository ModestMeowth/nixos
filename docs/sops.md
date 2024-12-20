# sops-nix
![sops-nix logo](https://github.com/Mic92/sops-nix/releases/download/assests/logo.gif "Logo of sops-nix")
### Requires either services.openssh
```nix
services.openssh.enable = true;
```
### *OR* manually generated keys
```sh
ssh-keygen -P /path/to/key
```
### *If key is a path **MUST** use **--impure** use a string value instead
```nix
sops.age.sshKeysPaths = ["/path/to/key"];
sops.gnupg.sshkeysPath = [/path/to/key]; # impure
```
