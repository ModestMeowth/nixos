{
  editorconfig = {
    enable = true;

    settings."*" = {
      charset = "utf-8";
      end_of_line = "lf";
      trim_trailing_whitespace = true;
      insert_final_newline = true;
      indent_style = "space";
      indent_size = 4;
    };

    settings."*.{nix,toml,yaml}" = {
      indent_size = 2;
    };

    settings."Makefile" = {
      indent_style = "tab";
    };

    settings."{J,.J,j,.j}ustfile" = {
      indent_size = 2;
    };
  };
}
