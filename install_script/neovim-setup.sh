#!/usr/bin/bash

# -u: パラメータ展開中に設定していない変数があったらエラーとする
# -e: 実行したコマンドが1つでもエラーになったら直ちにシェルを終了
set -ue

while [ $# -gt 0 ];do
  case ${1} in
    --debug|-d)
      # -x: シェルが実行したコマンドと引数を出力
      set -uex
      ;;
    *)
      ;;
  esac
  shift
done

dest=$HOME/.local
bashrc=$HOME/.bashrc
nvim_plugin_path=$dest/nvim-linux64/share/nvim/runtime/plugin/matchit.vim

# $destがあるか確認
if [[ ! -d $dest ]]; then
  echo "$dest not found... Auto make."
  mkdir -p $dest
fi

# Neovimの実行ファイルをダウンロード
echo "Download Neovim"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -C $dest -xzf nvim-linux64.tar.gz

# パスを通す
echo "Create path"
echo -e "\n# Neovim" >> $bashrc
echo "export PATH=\"$dest/nvim-linux64/bin:\$PATH\"" >> $bashrc

# %による括弧ジャンプが使えるように変更
echo "Modify $nvim_plugin_path"
sed -i 's/!exists("g:loaded_matchit") && //' $nvim_plugin_path

# 設定ファイルのインストール
echo "Install dotfiles"
git clone https://github.com/Kanta3417/dotfiles.git
cd dotfiles
install.sh
