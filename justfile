[private]
default:
    @{{ just_executable() }} --justfile {{ justfile() }} --list

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
