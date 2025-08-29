-- Basic keymaps configuration
-- See `:help vim.keymap.set()`

local keymap = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Split navigation
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Toggle file tree (nvim-tree)
keymap('n', '<C-b>', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file [B]rowser' })
