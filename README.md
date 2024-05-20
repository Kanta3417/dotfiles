# dotfiles

以下の設定ファイルを置いています。

- neovim

- fish

- tmux

(予定)

- .bashrc

- .vimrc

## Install

**注意**

install.shで設定ファイルのシンボリックリンクを張る際に、元ファイルのバックアップを取るようにしています。

しかし、正常にバックアップが取れない可能性もあるので、スクリプトを実行した際に起きた問題は自己責任でお願いします。

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
