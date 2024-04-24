local keymap = vim.keymap.set
local set = vim.opt
local user_command = vim.api.nvim_create_user_command
local var = vim.api.nvim_set_var
local autocmd = vim.api.nvim_create_autocmd

---------------------------------
-- 見た目
---------------------------------
-- 行番号の表示
set.number=true
-- コマンドラインの幅を変更
set.cmdheight=2
-- カーソルの上と下に最低でも指定行数表示される
set.scrolloff=3
-- カーソルのある行を強調
set.cursorline=true
-- カーソルのある列を強調
set.cursorcolumn=true
-- tabをタブ文字ではなくスペースで入力してくれる
set.expandtab=true
-- 非表示文字を表示
-- set.list=true
-- タブ文字とスペースを可視化
vim.cmd[[set listchars=tab:♪ ,space:۰]] -- :h digraph ☺
-- インデントを自動でつける
set.autoindent=true
-- tab幅をスペース2つ分にする
set.tabstop=2
-- vimが自動で生成するtab幅をスペース2つ分にする
set.shiftwidth=2
-- ステータスラインを2行
set.laststatus=2
-- ステータスラインの表示内容
vim.cmd[[set statusline=%F%m%=%l,%c(%p%%)]]
---------------------------------
-- ウィンドウ
---------------------------------
-- 垂直分割を右にする
set.splitright=true
-- 水平分割を下にする
set.splitbelow=true
---------------------------------
-- 検索
---------------------------------
-- 検索するときに大文字小文字を区別しない
set.ignorecase=true
-- 小文字で検索すると大文字と小文字を無視して検索
set.smartcase=true
-- 検索がファイル末尾まで進んだら、ファイル先頭から再び検索
set.wrapscan=true
-- インクリメンタル検索(検索ワードの最初の文字を入力した時点で検索が開始)
set.incsearch=true
-- 検索結果をハイライト表示
set.hlsearch=true
---------------------------------
-- その他
---------------------------------
-- スワップファイルを作成しない
set.swapfile=false
-- レジスタの内容をOSのクリップボードに貼り付け
vim.cmd[[set clipboard=unnamedplus]]
-- バッファ移動時に保存されていないことの確認をしない
set.hidden=true

---------------------------------
-- 独自キーマップ
---------------------------------
-- jキー2回で<Esc>
keymap('i', 'jj', '<Esc>', { silent = true })
-- ウィンドウ移動を便利にする(Altとh,j,k,l)
keymap('n', '<C-j>', '<C-w>j')
keymap('n', '<C-k>', '<C-w>k')
keymap('n', '<C-h>', '<C-w>h')
keymap('n', '<C-l>', '<C-w>l')
-- Escキー2回でハイライトをoffにする
keymap('n', '<Esc><Esc>', ':nohlsearch<CR><ESC>', { silent = true})
-- *の文字検索でカーソル位置の単語から移動しない
keymap('n', '*', '*N')
-- 候補の結果をフィルタするため
keymap('c', '<C-p>', '<Up>')
keymap('c', '<C-n>', '<Down>')
-- ;;で現在のファイルのあるディレクトリを自動入力(:スタート限定)
keymap('c', ';;', 'getcmdtype() == ":" ? expand("%:h")."/" : ";;"', { expr = true })
-- タブ移動
keymap('n', '<Tab>', 'gt')
keymap('n', '<S-Tab>', 'gT')

---------------------------------
-- Leader key
---------------------------------
-- Leader Keyをスペースに設定
var('mapleader', ' ')
-- タブ移動用
keymap('n', '<Leader>j', 'gT', { silent=true })
keymap('n', '<Leader>k', 'gt', { silent=true })
-- 入力が面倒なやつら
keymap('n', '<Leader> ', '<C-w>', {})
keymap('n', '<Leader>t', ':tabedit ')
keymap('n', '<Leader>q', ':bw!<CR>', { silent=true })
keymap('n', '<Leader>v', ':Fern . -drawer -stay<CR>', { silent=true })
-- カーソル下のファイルオープン
keymap('n', '<Leader>f', '<C-w>vgf')

---------------------------------
-- ターミナル
---------------------------------
-- 自動的に挿入モードに入る
-- autocmd('TermOpen', {command='startinsert'})
-- 行番号をなしにする
autocmd('TermOpen', {command='setlocal nonumber'})
-- バッファリストに表示しないようにする
autocmd('TermOpen', {command='setlocal nobuflisted'})
-- ターミナルで;;で挿入モードからノーマルモードに移行
keymap('t', ';;', '<C-\\><C-n>')
-- Sterminalで下にターミナルを作成
user_command('Sterminal', 'new | resize 15 | terminal', {})
-- Vterminalで右にターミナルを作成 
user_command('Vterminal', 'vnew | terminal', {})
-- Tterminalで右にターミナルを作成 
user_command('Tterminal', 'tabnew | terminal', {})

---------------------------------
-- ctags
---------------------------------
-- .tagsファイルをホームディレクトリまで遡って探す
vim.cmd[[set tags=.tags;~]]

---------------------------------
-- netrw
---------------------------------
-- バナーを表示にしない
var('netrw_banner', 0)
-- ファイルを開くときに新しいタブで開く
var('netrw_browse_split', 3)
-- ファイル一覧表示スタイル 3:ツリー表示
var('netrw_liststyle', 3)
-- 開いたファイルのカレントディレクトリを変更
var('netrw_keepdir', 0)
-- ファイルサイズを(K,M,G)で表示する
var('netrw_sizestyle', "H")
-- プレビューウィンドウを垂直分割で表示する
var('netrw_preview', 1)
-- 特定の種類のファイルが特別な色で表示
var('netrw_special_syntax', true)
-- 日付フォーマットを yyyy/mm/dd(曜日) hh:mm:ss で表示する
var('netrw_timefmt', "%Y/%m/%d(%a) %H:%M:%S")
-- ウィンドウを作成したときの初期サイズ
var('netrw_winsize', 15)
-- netrw固有のキーマップ
vim.cmd[[
" <C-l>で左のウィンドウに移動
function! NetrwMapping_Cl(islocal) abort
  return "normal! \<C-w>l"
endfunction
" hで親ディレクトリに移動
function! NetrwMapping_h(islocal) abort
  return "normal -"
endfunction
" lでディレクトリを展開
function! NetrwMapping_l(islocal) abort
  return "normal x"
endfunction
]]
vim.g.Netrw_UserMaps = {
  {'<C-l>', 'NetrwMapping_Cl'},
  {'h', 'NetrwMapping_h'},
  {'l', 'NetrwMapping_l'},
}

