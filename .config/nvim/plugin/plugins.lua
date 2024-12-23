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
  -- "nvim-treesitter/nvim-treesitter",
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
  -- コメントアウト
  "numToStr/Comment.nvim",
  opts = {
    -- add any options here
  },
  lazy = false,
  -- インデントの見た目
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
})

---------------------------------
-- indent-blankline
---------------------------------
local highlightlist = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup {
  -- indent = {
  --   highlight = highlight,
  -- },
  -- scope = {
  --
  -- }
  debounce = 100,
  indent = {
    -- char = "|",
    -- tab_char = { "a", "b", "c" },
    -- highlight = { "Function", "Label" },
    -- highlight = highlightlist,
    smart_indent_cap = true,
    priority = 1,
    -- repeat_linebreak = false,
  },
  whitespace = { highlight = { "Whitespace", "NonText" } },
  -- scope = { exclude = { language = { "lua" } } },
  scope = {
    enabled = true,
    show_start = true,
    show_end = true,
    injected_languages = false,
    highlight = { "Function", "Label" },
    priority = 500,
  }
}


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
-- Comment
---------------------------------
require('Comment').setup {
  {
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
      ---Line-comment toggle keymap
      line = 'gcc',
      ---Block-comment toggle keymap
      block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = 'gc',
      ---Block-comment keymap
      block = 'gb',
    },
    ---LHS of extra mappings
    extra = {
      ---Add comment on the line above
      above = 'gcO',
      ---Add comment on the line below
      below = 'gco',
      ---Add comment at the end of line
      eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = true,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = true,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
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

