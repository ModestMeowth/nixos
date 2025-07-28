IS_MOSH := if env("PARENT_PROCESS", "false") == ".mosh-server-wr" { "true" } else { "false" }

default:
  just --choose --justfile "{{justfile()}}"

build: git-pull os-build home-build

switch: git-pull os-switch home-switch

test: git-pull os-test home-test

os-build: git-pull
  nh os build . {{ if IS_MOSH == "true" { " --no-nom" } else { "" } }}

home-build: git-pull
  nh home build . {{ if IS_MOSH == "true" { " --no-nom" } else { "" } }}

os-switch: git-pull
  nh os switch . {{ if IS_MOSH == "true" { " --no-nom" } else { "" } }}

home-switch: git-pull
  nh home switch . {{ if IS_MOSH == "true" { " --no-nom" } else { "" } }}

os-test: git-pull
  nh os test . {{ if IS_MOSH == "true" { " --no-nom" } else { "" } }}

home-test: git-pull
  nh home test . {{ if IS_MOSH == "true" { " --no-nom" } else { "" } }}

boot: git-pull
  nh os boot . {{ if IS_MOSH == "true" { " --no-nom" } else { "" } }}

git-pull:
  git pull
