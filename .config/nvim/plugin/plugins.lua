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
  -- 括弧の自動挿入
  "jiangmiao/auto-pairs",
	-- ファイラー
	"lambdalisue/fern.vim",
  -- colorscheme
  "NLKNguyen/papercolor-theme",
  -- git
  "lewis6991/gitsigns.nvim",
  -- git diff
  "sindrets/diffview.nvim",
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
-- require('mini.pairs').setup()

---------------------------------
-- Fern
---------------------------------
vim.api.nvim_set_var('fern#drawer_width', 25)

---------------------------------
-- gitsigns
---------------------------------
require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

---------------------------------
-- colorscheme
---------------------------------
vim.cmd
[[
set notermguicolors
set background=dark
colorscheme PaperColor 
]]

