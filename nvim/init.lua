-- See https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

vim.cmd.colorscheme 'retrobox'
vim.g.mapleader = ' ' -- <space> as leader key, :help mapleader
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.opt.number = true -- line numbers
vim.opt.relativenumber = true
vim.opt.mouse = 'a' -- mouse mode
vim.opt.showmode = false -- mode is in status line
vim.opt.breakindent = true -- indent when wrapping
vim.opt.undofile = true -- save undo history
vim.opt.ignorecase = true -- case-insensitive search
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes' -- sign column enabled by default
vim.opt.updatetime = 250 -- 250ms of inactivity to write to swap file
vim.opt.timeoutlen = 300 -- time to complete mapped sequence
vim.opt.splitright = true -- open split right&below
vim.opt.splitbelow = true
vim.opt.list = true -- change how whitespace characters are displayed
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split' -- preview substitutions
vim.opt.cursorline = true -- show cursor line
vim.opt.scrolloff = 10 -- show this number of lines around cursor
vim.opt.tabstop = 4

vim.opt.autoread = true -- autoread when file is changed in file system

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus' -- sync clipboard with os
end)

-- [[ Basic Keymaps ]]

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- also clear highlights
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' }) -- diagnostics

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
