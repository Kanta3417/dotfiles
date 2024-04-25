--------------------------------
-- lazy.nvim
---------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- helpの日本語化
	"vim-jp/vimdoc-ja",
	-- 細々とした機能
	"echasnovski/mini.nvim",
	-- ファイラー
	"lambdalisue/fern.vim",
  -- colorscheme
  "NLKNguyen/papercolor-theme",
})

---------------------------------
-- vimdoc-ja
---------------------------------
-- 日本語の優先順位を上げる
vim.cmd[[set helplang=ja,en]]

---------------------------------
-- mini.nvim
---------------------------------
-- 括弧を挿入、変更、削除する
require('mini.surround').setup()
-- 複数行のコメントアウト
require('mini.comment').setup()
-- 括弧の自動挿入
require('mini.pairs').setup()

---------------------------------
-- colorscheme
---------------------------------
vim.cmd
[[
set background=dark
colorscheme PaperColor 
]]

