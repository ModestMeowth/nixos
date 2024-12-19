{ config, lib, ... }:
let
  cfg = config.programs.starship;
in
{
  config = lib.mkIf cfg.enable {
    programs.starship.enableTransience = true;
    programs.starship.settings = {
      format = lib.concatStrings [
        "$username"
        "$os"
        "$hostname"
        "$localip"
        "$shlvl"
        "$singularity"
        "$kubernetes"
        "$directory"
        "$vcsh"
        "$fossil_branch"
        "$fossil_metrics"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$hg_branch"
        "$pijul_channel"
        "$docker_context"
        "$package"
        "$c"
        "$cmake"
        "$cobol"
        "$daml"
        "$dart"
        "$deno"
        "$dotnet"
        "$elixir"
        "$elm"
        "$erlang"
        "$fennel"
        "$golang"
        "$guix_shell"
        "$haskell"
        "$haxe"
        "$helm"
        "$java"
        "$julia"
        "$kotlin"
        "$gradle"
        "$lua"
        "$nim"
        "$nodejs"
        "$ocaml"
        "$opa"
        "$perl"
        "$php"
        "$pulumi"
        "$purescript"
        "$python"
        "$raku"
        "$rlang"
        "$red"
        "$ruby"
        "$rust"
        "$scala"
        "$solidity"
        "$swift"
        "$terraform"
        "$typst"
        "$vlang"
        "$vagrant"
        "$zig"
        "$buf"
        "$nix_shell"
        "$conda"
        "$meson"
        "$spack"
        "$memory_usage"
        "$aws"
        "$gcloud"
        "$openstack"
        "$azure"
        "$direnv"
        "$env_var"
        "$crystal"
        "$custom"
        "$sudo"
        "$cmd_duration"
        "$jobs"
        "$battery"
        "$time"
        "$status"
        "$line_break"
        "$container"
        "$shell"
        "$character"
      ];

      character = {
        error_symbol = "[λ](bold #ff5555)";
        success_symbol = "[λ](bold #50fa7b)";
      };

      cmd_duration = {
        style = "bold #f1fa8c";
      };

      directory = {
        style = "bold #50fa7b";
      };

      hostname = {
        style = "bold #ff5555";
        ssh_only = false;
      };

      os = {
        disabled = false;
      };

      git_branch = {
        style = "bold #ff79c6";
      };

      git_status = {
        style = "bold #ff5555";
      };

      username = {
        style_user = "bold #8be9fd";
        show_always = true;
      };
    };
  };
}
