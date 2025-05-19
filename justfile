IS_MOSH := if env("PARENT_PROCESS", "false") == ".mosh-server-wr" { "true" } else { "false" }

default:
  just --choose --justfile "{{justfile()}}"

build: git-pull
  nh os build . {{ if IS_MOSH == "true" { " --no-nom" } else { "" } }}

switch: git-pull
  nh os switch . {{ if IS_MOSH == "true" { " --no-nom" } else { "" } }}

test: git-pull
  nh os test . {{ if IS_MOSH == "true" { " --no-nom" } else { "" } }}

boot: git-pull
  nh os boot . {{ if IS_MOSH == "true" { " --no-nom" } else { "" } }}

git-pull:
  git pull
