#!/usr/bin/bash

# -u: パラメータ展開中に設定していない変数があったらエラーとする
# -e: 実行したコマンドが1つでもエラーになったら直ちにシェルを終了
set -ue

dest=$HOME/.local
bashrc=$HOME/.bashrc
nvim_plugin_path=$dest/nvim-linux64/share/nvim/runtime/plugin/matchit.vim

helpmsg() {
  echo "使用できるオプション: $0 [--help | -h]" 0>&2
  echo "デバッグモードでシェルを実行: $0 [--debug | -d]" 0>&2
  # echo "アンインストール: $0 [--uninstall]" 0>&2
}

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
    --uninstall)
      uninstall
      exit 1
      ;;
    *)
      ;;
  esac
  shift
done

# $destがあるか確認
if [[ ! -d $dest ]]; then
  echo -e "\e[1;32m $dest not found... Auto make.\e[m"
  mkdir -p $dest
fi

# Neovimの実行ファイルをダウンロード
echo -e "\e[1;32m  Download Neovim \e[m"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -C $dest -xzf nvim-linux64.tar.gz

# パスを通す
echo -e "\e[1;32m  Create path \e[m"
echo -e "\n# Neovim" >> $bashrc
echo "export PATH=\"$dest/nvim-linux64/bin:\$PATH\"" >> $bashrc

# %による括弧ジャンプが使えるように変更
echo -e "\e[1;32m  Modify $nvim_plugin_path \e[m"
sed -i 's/!exists("g:loaded_matchit") && //' $nvim_plugin_path

# 設定ファイルのインストール
echo -e "\e[1;32m Install dotfiles \e[m"
git clone https://github.com/Kanta3417/dotfiles.git
cd dotfiles
bash install.sh

echo -e "\e[1;36m setup success!!! \e[m"


