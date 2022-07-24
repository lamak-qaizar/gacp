#!/bin/bash

gacp_dir="$HOME/gacp"

function clone_gacp() {
  echo "[gacp installer] Cloning GACP unless it is already cloned under $gacp_dir."
  if [[ ! -e $gacp_dir ]]; then
      git -C $HOME clone https://github.com/lamakq/gacp.git
  fi
}

function update_gacp() {
  echo "[gacp installer] Pulling GACP unless it is already cloned under $gacp_dir."
  git -C $gacp_dir pull
}

function create_initials_json() {
  echo "[gacp installer] Creating initials.json unless it is already created."
  if [[ ! -e $gacp_dir/initials.json ]]; then
      echo "{}" > $gacp_dir/initials.json
  fi
}

function source_bash_profile_in_zsh_for_newer_macos() {
  append_to_file "source ~/.bash_profile" ~/.zshrc
}

function append_to_file() {
  if ! grep -q "$1" "$2"; then
    echo "$1" >> "$2"
  fi
}

function make_file_executable() {
  chmod u+x "$1"
}

function create_alias() {
  append_to_file "alias $1=$2" ~/.bash_profile
  make_file_executable "$2"
}

function register_gacp_in_path() {
  echo "[gacp installer] Registering gacp aliases in ~/.bash_profile unless they are already there."

  create_alias gac "$gacp_dir"/bin/gac.sh
  create_alias gacp "$gacp_dir"/bin/gacp.sh

  source_bash_profile_in_zsh_for_newer_macos
}

clone_gacp
update_gacp
create_initials_json
register_gacp_in_path