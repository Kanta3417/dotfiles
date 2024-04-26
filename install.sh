#!/usr/bin/bash

# -u: パラメータ展開中に設定していない変数があったらエラーとする
# -e: 実行したコマンドが1つでもエラーになったら直ちにシェルを終了

src="$(pwd -P)"
dest=$HOME
# バックアップの場所
backup=$HOME/.dotbackup

helpmsg() {
  echo "Usage: $0 [--help | -h]" 0>&2
  echo "Usage: $0 [--debug | -d]" 0>&2
}

link_to_destdir() {
  local _src=$1
  local _dest=$2
  local _backup=$3

  for f in `ls -a $_src`; do
    # 隠しファイル、ディレクトリだけ処理を行う(初回だけ実行)
    [[ $_dest = $HOME && $f != .* ]] && continue
    # 親、カレントディレクトリと.gitで始まるファイル、ディレクトリは無視
    [[ $f == "." || $f == ".." || $f == ".git"* ]] && continue

    # 同名のシンボリックリンクがあれば削除する
    if [[ -L "$_dest/$f" ]];then
      echo "rm -f $_dest/$f"
      rm -f "$_dest/$f"
    fi

    # 同名のファイルがあれば$backupに移動して、シンボリックリンクを張る
    if [[ -f "$_dest/$f" ]];then
      echo "mv $_dest/$f $_backup"
      mv "$_dest/$f" "$_backup"
      echo "ln -snf $_src/$f $_dest"
      ln -snf $_src/$f $_dest
      continue
    fi

    # 同名のディレクトリがあれば再帰的に処理を行う
    if [[ -d $_dest/$f ]]; then
      # バックアップのためにディレクトリを作成
      echo "mkdir -p $_backup/$f"
      mkdir -p $_backup/$f
      # ディレクトリの中に入り、同様のことを行う
      link_to_destdir $_src/$f $_dest/$f $_backup/$f
    else # ディレクトリがなければシンボリックリンクを張る
      echo "ln -snf $_src/$f $_dest"
      ln -snf $_src/$f $_dest
    fi
  done
}

IS_INSTALL="true"

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      # -x: シェルが実行したコマンドと引数を出力
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
  echo "backup old dotfiles..."
  if [ ! -d $backup ];then
    echo "$backup not found. Auto Make it"
    mkdir "$backup"
  fi
  link_to_destdir $src $dest $backup

  echo ""
  echo "#####################################################"
  echo -e "\e[1;36m $(basename $0) install success!!! \e[m"
  echo "#####################################################"
  echo ""
fi
