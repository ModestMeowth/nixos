alias fmt := format

[private]
default:
    @{{ just_executable() }} --justfile {{ justfile() }} --list

# run formatter
format:
    treefmt

# run pre-commit check
check *ARGS:
    pre-commit run {{ ARGS }}

# pull from git and update flake
update:
    git pull
    nix flake update --commit-lock-file
    nvfetcher -o packages/_sources -c packages/nvfetcher.toml

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

# generate packages with nvfetcher
[no-cd]
generate:
    nvfetcher
