set unstable := true
set shell := ["bash", "-euo", "pipefail", "-c"]

nixShebang := "/usr/bin/env -S nix shell --inputs-from " + justfile_directory()
realShebang := "/usr/bin/env bash -euo pipefail"

[private]
default:
  @just -l

# git stash and pull
[group("repository")]
pull:
  - git stash
  git pull --rebase
  - git stash pop

# update custom packages with nvfetcher
[group("repository")]
update-packages:
  #!{{nixShebang}} nixpkgs#nvfetcher -c {{realShebang}}
  cd ./packages
  nvfetcher

# nixos-rebuild boot AND home-manager switch
[group("nix")]
boot user=shell("whoami") hostname=shell("hostname"): (nixos-boot hostname) (home-switch user hostname)

# nixos-rebuild build AND home-manager build
[group("nix")]
build user=shell("whoami") hostname=shell("hostname"): (nixos-build hostname) (home-build user hostname)

# nixos-rebuild switch AND home-manager switch
[group("nix")]
switch user=shell("whoami") hostname=shell("hostname"): (nixos-switch hostname) (home-switch user hostname)

# nixos-rebuild boot
[group("nix")]
nixos-boot hostname=shell("hostname"):
  #!{{nixShebang}} nixpkgs#nh -c {{realShebang}}
  nh os boot -H {{hostname}} .

# nixos-rebuild build
[group("nix")]
nixos-build hostname=shell("hostname"):
  #!{{nixShebang}} nixpkgs#nh -c {{realShebang}}
  nh os build -H {{hostname}} .

# nixos-rebuild switch
[group("nix")]
nixos-switch hostname=shell("hostname"):
  #!{{nixShebang}} nixpkgs#nh -c {{realShebang}}
  nh os switch -H {{hostname}} .

# home-manager build
[group("nix")]
home-build user=shell("whoami") hostname=shell("hostname"):
  #!{{nixShebang}} nixpkgs#nh -c {{realShebang}}
  nh home build -c {{user}}@{{hostname}} .

# home-manager switch
[group("nix")]
home-switch user=shell("whoami") hostname=shell("hostname"):
  #!{{nixShebang}} nixpkgs#nh -c {{realShebang}}
  nh home switch -c {{user}}@{{hostname}} .

# Makes an sd-card for an aarch64 SBC eg. raspberry-pi >= 3
[group("nix")]
mkrpi-img:
  nix build .#nixosConfigurations.rpi.config.system.build.sdImage

# run garbage collection for items greater that [day]s (default 7days)
[group("store")]
gc day='7':
  sudo nix-collect-garbage --delete-older-than {{day}}d
  nix-collect-garbage --delete-older-than {{day}}d

# verify nix store
[group("store")]
verify-store:
  nix store verify --all

# repair nix store
[group("store")]
repair-store *paths:
  nix store repair {{paths}}

# show all gc roots in the nix store
[group("store")]
gcroot:
  #!{{nixShebang}} nixpkgs#eza -c {{realShebang}}
  eza -lag /nix/var/nix/gcroots/auto/
