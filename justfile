username := `whoami`
hostname := `hostname -s`
system := `nix-instantiate --raw --strict --eval -E builtins.currentSystem`

help:
  just -l

fmt:
  nix fmt

update *args:
  nix flake update

hm host=hostname user=username *args:
  nh home switch -c {{user}}@{{host}} --ask {{args}}

build host=hostname *args:
  nh os build -H {{hostname}} . {{args}}

switch host=hostname *args:
  nh os switch -H {{hostname}} . {{args}}

boot host=hostname *args:
  nh os boot -H {{hostname}} . {{args}}

ci test="" *args:
  nix-unit --flake '.#tests.systems.{{system}}.system-agnostic.{{test}}' "$@"
