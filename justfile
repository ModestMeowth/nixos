alias u := update
alias gp := git-pull
alias fu := flake-update
alias fmt := format
alias gen := generate

[private]
default:
    @{{ just_executable() }} --justfile {{ justfile() }} --list

# run formatter
format:
    treefmt

# run pre-commit check
check *ARGS:
    pre-commit run {{ ARGS }}

# pull from git and update flake and sources
update: git-pull flake-update generate

# update flake
flake-update:
    nix flake update --commit-lock-file

# nh (os|home) switch .
switch target='--help':
    @nh {{ target }} switch .

# nh (os|home) build .
build target='--help':
    @nh {{ target }} build .

# nh clean (all|profile|user)
clean target='--help':
    @nh clean {{ target }}

# nh search PACKAGE --channel=nixos-(24.04|unstable)
search package='--help' channel='24.05':
    @nh search --channel nixos-{{ channel }} {{ package }}

git-pull:
  git pull --rebase

# generate packages with nvfetcher
generate:
    nvfetcher -o packages/_sources -c packages/nvfetcher.toml --commit-changes
