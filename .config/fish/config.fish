# Prompt options
set -g theme_display_vi yes # viのモードを表示する(ノーマル:N ビジュアル:V)
# set -g theme_show_exit_status yes # コマンドエラー時の番号を表示
set -g theme_display_jobs_verbose yes # バックグラウンド実行の数を表示
set -g theme_display_user yes # ssh接続の時にのみユーザ名表示(yes, ssh, no)
# set -g default_user kanta # 設定した名前以外ならユーザ名表示
set -g theme_display_sudo_user yes # sudoのユーザ名を表示?
set -g theme_display_hostname no # hostnameを非表示(yes, ssh, no)
set -g fish_prompt_pwd_dir_length 0 # 0:フルパス, 1~:1~文字表示
# set -g theme_project_dir_length 0 # プロジェクトルートからの相対パス
set -g theme_show_project_parent no # プロジェクトのディレクトリ名だけを表示
set -g theme_newline_cursor yes #　コマンド行を次の行で開始(clean:先頭のマークなし)
# set -g theme_newline_prompt "\e[37m♪\e[m " # ♪ 🦏 ☃  🦕  
set -g theme_newline_prompt "\e[38;5;208m♪ " # ♪ 🦏 ☃  🦕  
set -g theme_powerline_fonts no
set -g theme_nerd_fonts yes
set -g theme_color_scheme dracula

# Git options
set -g theme_display_git_dirty_verbose yes # 詳細な情報を表示
set -g theme_display_git_ahead_verbose yes # ahead/behind state information
set -g theme_display_git_stashed_verbose yes # stashed state information
set -g theme_display_git_default_branch yes # ブランチを表示
set -g theme_use_abbreviated_branch_name yes # 極端に長いブランチ名を省略表示

# Right prompt options
set -g theme_display_date yes # 日付を表示
set -g theme_date_format "+%F %H:%M" # 日付のフォーマットを指定

# Title options
set -g theme_title_display_process yes # プロセス名を表示
# set -g theme_title_display_path no
# set -g theme_title_display_user yes
# set -g theme_title_use_abbreviated_path no

# コマンド部分の文字色を変更
set -g fish_color_command 19fcf9

if status is-interactive
  # Commands to run in interactive sessions can go here
end

# -----------------
# path
# -----------------
# nvim
set -x PATH $HOME/.local/bin $PATH

# -----------------
# alias
# -----------------
alias ll "eza -l -g --icons"
alias lla "ll -a"
alias gl "git log --oneline -n 5"
alias bpflog "sudo bpftool prog tracelog"
