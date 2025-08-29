--[[
  Neovim Configuration
  Modular and clean configuration for development
--]]
--test 
-- Install lazy.nvim if not present
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

-- Add lazy.nvim to runtime path
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- Load configurations
require('config.options')
require('config.keymaps')
require('config.autocommands')

-- Load plugin-dependent configurations after plugins are loaded
vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyDone',
  callback = function()
    require('config.plugin-keymaps')
    require('config.colorscheme')
  end,
})

-- Configure and install plugins
require('lazy').setup({
  -- Import plugin configurations
  { import = 'plugins.lsp' },
  { import = 'plugins.completion' },
  { import = 'plugins.telescope' },
  { import = 'plugins.nvimtree' },
  { import = 'plugins.misc' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
