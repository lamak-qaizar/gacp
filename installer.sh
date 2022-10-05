#!/bin/bash

gacp_dir="$HOME/gacp"

function clone_repo() {
  git -C $HOME clone https://github.com/lamakq/gacp.git
}

function update_repo() {
  git -C $gacp_dir pull
}

function clone_or_update_repo_if_needed() {
  if [[ ! -e $gacp_dir ]]; then
    echo "[gacp installer] Cloning GACP under $gacp_dir."
    clone_repo
    return
  fi
  echo "[gacp installer] Pulling GACP since it is already cloned under $gacp_dir."
  update_repo
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

clone_or_update_repo_if_needed
create_initials_json
register_gacp_in_path