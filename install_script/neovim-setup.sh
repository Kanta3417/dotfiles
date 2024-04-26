#!/usr/bin/bash

dest=$HOME/.local
bashrc=$HOME/.bashrc
nvim_plugin_path=$dest/nvim-linux64/share/nvim/runtime/plugin/matchit.vim

# $destがあるか確認
if [[ ! -d $dest ]]; then
  echo "$dest not found... Auto make."
  mkdir -p $dest
fi

# curlのインストール
sudo apt update
sudo apt install -y curl

# Neovimの実行ファイルをダウンロード
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar -C $dest -xzf nvim-linux64.tar.gz

# パスを通す
echo -e "\n# Neovim" >> $bashrc
echo "export PATH=\"$dest/nvim-linux64/bin:\$PATH\"" >> $bashrc

# %による括弧ジャンプが使えるように変更
sed -i 's/!exists("g:loaded_matchit") && //' $nvim_plugin_path

# 設定ファイルのインストール
git clone https://github.com/Kanta3417/dotfiles.git
cd dotfiles
install.sh
