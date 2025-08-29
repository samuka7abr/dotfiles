-- Plugin-dependent keymaps
-- These keymaps are loaded after plugins are initialized

local keymap = vim.keymap.set

-- Telescope keymaps
local function setup_telescope_keymaps()
  local builtin = require 'telescope.builtin'
  
  keymap('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  keymap('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  keymap('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  keymap('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  keymap('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  keymap('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  keymap('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  keymap('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  keymap('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  keymap('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  -- Telescope advanced keymaps
  keymap('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  keymap('n', '<leader>s/', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, { desc = '[S]earch [/] in Open Files' })

  keymap('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })
end

-- Format keymap
local function setup_format_keymap()
  keymap('n', '<leader>f', function()
    require('conform').format { async = true, lsp_format = 'fallback' }
  end, { desc = '[F]ormat buffer' })
end

-- Setup all plugin keymaps
local function setup_plugin_keymaps()
  -- Wait a bit for plugins to load
  vim.defer_fn(function()
    setup_telescope_keymaps()
    setup_format_keymap()
  end, 100)
end

-- Initialize plugin keymaps
setup_plugin_keymaps()
