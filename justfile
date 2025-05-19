IS_MOSH := if env("FISH_PARENT") == ".mosh-server-wr" { "true" } else { "false" }

default:
  just --choose --justfile "{{justfile()}}"

build: git-pull
  nh os build . {{ if IS_MOSH == "true" { " --no-nom" } else { "" } }}

switch: git-pull
  nh os switch . {{ if IS_MOSH == "true" { " --no-nom" } else { "" } }}

git-pull:
  git pull
