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

function register_gacp_in_path() {
  echo "[gacp installer] Registering gacp aliases in ~/.bash_profile unless they are already there."
  append_to_file "gac=$gacp_dir/bin/gac.sh" ~/.bash_profile
  append_to_file "gacp=$gacp_dir/bin/gacp.sh" ~/.bash_profile
  source_bash_profile_in_zsh_for_newer_macos
}

clone_gacp
update_gacp
create_initials_json
register_gacp_in_path