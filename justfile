default: usage

usage:
    @echo "  pkg PKG_NAME [channel]"
    @echo "    PKG_NAME (ex: tailscale)"
    @echo "    channel (ex: 24.05|unstable, default = 24.05)"
    @echo
    @echo "  prefetch (see man nix-prefetch)"

[no-cd]
generate:
    nvfetcher

pkg package nixpkgs='24.05':
    hydra-check {{ package }} --channel={{ nixpkgs }}

prefetch *ARGS:
    nix-prefetch {{ ARGS }}
