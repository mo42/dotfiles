vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer() 

require('packer').startup(function(use)
  use 'takac/vim-hardtime'
  use 'mo42/vim-weaselwords'
end)

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.wrapscan = true

-- Hardtime configuration
vim.g.hardtime_default_on = 1
vim.g.hardtime_timeout = 4000
vim.g.hardtime_showmsg = 0
vim.g.hardtime_maxcount = 2
vim.g.hardtime_allow_different_key = 1
vim.g.list_of_normal_keys = { "h", "j", "k", "l", "-", "+", "x", "~", "dw" }
vim.list_extend(vim.g.list_of_normal_keys, { "w", "b", "dd" })
vim.g.hardtime_motion_with_count_resets = 1

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
-- undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.config/nvim/undodir/')
vim.opt.undoreload = 100000
vim.opt.undolevels = 100000
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.shadafile = vim.fn.expand("~/.config/nvim/shada")

-- Return to the last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local last_pos = vim.fn.line("'\"")
    if last_pos > 0 and last_pos <= vim.fn.line("$") then
      vim.cmd("normal! g`\"")
    end
  end,
})

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.autoindent = true

vim.opt.hidden = true
vim.opt.colorcolumn = "80"

-- Mappings
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Fast way to move between windows in normal mode
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Buffer navigation: Go to next/previous buffer
vim.keymap.set('n', '<C-l>', ':bn<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', ':bp<CR>', { noremap = true, silent = true })

-- Save and exit mappings
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>x', ':x<CR>', { noremap = true, silent = true })

-- Miscellaneous mappings
vim.keymap.set('n', '<leader>.', '@:', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>s', ':%s/\\s\\+$//e<CR>', { noremap = true, silent = true })

-- Zettelkasten related: Open index and change directory
vim.keymap.set('n', '<leader>z', ':e ~/zettelkasten/index.md<CR>:cd ~/zettelkasten/<CR>', { noremap = true, silent = true })

vim.cmd('iabbrev <expr> DATE strftime("%Y-%m-%d")')
vim.cmd('iabbrev GRUSSE Viele Grüße\\<CR>Moritz')
vim.cmd('iabbrev REGARDS Kind regards,\\<CR>Moritz')
vim.cmd('iabbrev MDLINK []()\\<Esc>i')
vim.cmd('iabbrev MDIMAGE ![]()\\<Esc>i')

-- Language and spelling setup
vim.opt.spell = true
vim.opt.spelllang = "en"

local current_spell_language = "en_us"
local languages = { "en_us", "de_de", "" }
local function cycle_spell_language()
  local index = vim.tbl_contains(languages, current_spell_language) and vim.fn.index(languages, current_spell_language) or 0
  current_spell_language = languages[(index + 1) % #languages + 1]
  if current_spell_language == '' then
    vim.opt.spell = false
    print('No spell language')
  else
    vim.opt.spell = true
    vim.opt.spelllang = current_spell_language
    print('Current spell language: ' .. current_spell_language)
  end
  vim.fn['HighlightWeaselWords'](current_spell_language)
  vim.fn['HighlightPassive'](current_spell_language)
end

vim.keymap.set('n', '<leader>l', cycle_spell_language, { desc = "Cycle through spell languages" })
