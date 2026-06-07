-- See https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

do
  vim.loader.enable()
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

  vim.o.confirm = true -- raise dialog if operation fails due to unsaved changes
  vim.opt.autoread = true -- autoread when file is changed in file system

  -- sync clipboard with os
  vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

  -- [[ Basic Keymaps ]]

  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- also clear highlights
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' }) -- diagnostics

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- TIP: Disable arrow keys in normal mode
  -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- [[ Basic Autocommands ]]

  -- Highlight when yanking (copying) text
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.highlight.on_yank() end,
  })
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
