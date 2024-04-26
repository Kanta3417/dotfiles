# dotfiles

以下の設定ファイルを置いている

- neovim

(予定)

- .Xmodmap

- .bashrc

- .vimrc

## Install

**注意**

手元の環境で試して正常に動くことを確認しましたが、バックアップが取れず上書きされる恐れがあります。

そのため、手動で以下のバックアップを取っておくことをお勧めします。

- $HOME/.config

1. Download

    ```bash
    https://github.com/Kanta3417/dotfiles.git
    cd dotfiles
    ```

1. Install

    ```bash
    ./install.sh
    ```
## Setup Neovim

最新のNeovimのインストールと設定ファイルの配置を行います。

~~~bash
curl -fsSL https://github.com/Kanta3417/dotfiles/raw/main/install_script/neovim-setup.sh | bash
~~~
