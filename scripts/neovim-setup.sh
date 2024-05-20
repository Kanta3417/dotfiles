#!/usr/bin/bash

# -u: パラメータ展開中に設定していない変数があったらエラーとする
# -e: 実行したコマンドが1つでもエラーになったら直ちにシェルを終了
set -ue

dest=$HOME/.local
bashrc=$HOME/.bashrc
nvim_name=nvim-linux64
nvim_tarball=$nvim_name.tar.gz
nvim_plugin_path=$dest/nvim-linux64/share/nvim/runtime/plugin/matchit.vim
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

# Neovimの実行ファイルをダウンロード
echo -e "\e[1;35m Download Neovim \e[m"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -C $dest -xzf $nvim_tarball
rm -f $nvim_tarball

# パスを通す
echo -e "\e[1;35m Create path \e[m"
echo -e "\n# Add ~/.local/bin to \$PATH" >> $bashrc
echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> $bashrc
ln -s $dest/bin/nvim $HOME/.local/bin
source $bashrc

# 設定ファイルのインストール
echo -e "\e[1;35m Install dotfiles \e[m"
git clone https://github.com/Kanta3417/dotfiles.git
cd dotfiles
if [[ $debug = "true" ]]; then
  bash install.sh --debug
else
  bash install.sh
fi

echo ""
echo "#####################################################"
echo -e "\e[1;36m setup success!!! \e[m"
echo "#####################################################"
echo ""


