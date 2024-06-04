#!/usr/bin/bash

# -u: パラメータ展開中に設定していない変数があったらエラーとする
# -e: 実行したコマンドが1つでもエラーになったら直ちにシェルを終了
set -ue

dest=$HOME/.local
bashrc=$HOME/.bashrc
nvim_name=nvim-linux64
nvim_tarball=$nvim_name.tar.gz
local_bin=$HOME/.local/bin
debug="false"

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
      debug="true"
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

# $destがあるか確認
if [[ ! -d $dest ]]; then
  echo -e "\e[1;35m $dest not found... Auto make.\e[m"
  mkdir -p $dest
fi

# ~/.local/binがあるか確認
if [[ ! -d $local_bin ]]; then
  echo -e "\e[1;35m $local_bin not found... Auto make.\e[m"
  mkdir -m 700 -p $local_bin
fi

# Neovimの実行ファイルをダウンロード
echo -e "\e[1;35m Download Neovim \e[m"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -C $dest -xzf $nvim_tarball
rm -f $nvim_tarball

# パスを通す
echo -e "\e[1;35m Create path \e[m"
echo -e "\n# Add ~/.local/bin to \$PATH" >> $bashrc
echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> $bashrc
ln -s $dest/bin/nvim $local_bin
source $bashrc

echo ""
echo "#####################################################"
echo -e "\e[1;36m setup success!!! \e[m"
echo "#####################################################"
echo ""


