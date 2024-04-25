#!/usr/bin/env bash
set -ue

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
dest=$HOME/dest
backup=$HOME/backup

link_to_destdir() {
  local _src=$1
  local _dest=$2
  local _backup=$3
  echo "_src: $_src"
  echo "_dest: $_dest"
  echo "_backup: $_backup"

  for f in `ls -a $_src`; do
    local fpath=$_src/$f
    [[ $f == "." || $f == ".." || $f == ".git"* ]] && continue

    echo "f: $f,  fpath: $fpath"

    # シンボリックリンクかどうか
    if [[ -L "$_dest/$f" ]];then
      echo "rm -f $_dest/$f"
      command rm -f "$_dest/$f"
    fi

    # ファイルがあるかどうか
    if [[ -f "$_dest/$f" ]];then
      echo "mv $_dest/$f $_backup"
      command mv "$_dest/$f" "$_backup"
      echo "ln -sf $_src/$f $_dest"
      command ln -snf $_src/$f $_dest
      continue
    fi

    if [[ -d $_dest/$f ]]; then
      echo "$_dest/$f is directory"
      echo "mkdir -p $_backup/$f"
      command mkdir -p $_backup/$f
      link_to_destdir $_src/$f $_dest/$f $_backup/$f
    else
      echo "ln -sd $_src/$f $_dest"
      command ln -snf $_src/$f $_dest
    fi
  done
}

link_to_destdir $src $dest $backup
