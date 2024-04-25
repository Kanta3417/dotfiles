#!/usr/bin/env bash
set -ue


helpmsg() {
  command echo "Usage: $0 [--help | -h]" 0>&2
  command echo ""
}

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

IS_INSTALL="true"

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      set -uex
      ;;
    --help|-h)
      helpmsg
      exit 1
      ;;
    *)
      ;;
  esac
  shift
done

if [[ "$IS_INSTALL" = true ]];then
  local src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
  local dest=$HOME/dest
  local backup=$HOME/backup
  link_to_destdir $src $dest $backup

  command echo ""
  command echo "#####################################################"
  command echo -e "\e[1;36m $(basename $0) install success!!! \e[m"
  command echo "#####################################################"
  command echo ""
fi
