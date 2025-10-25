return {
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'ColaMint/pokemon.nvim',
    },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'
      local pokemon = require 'pokemon'

      -- Snorlax!
      pokemon.setup {
        number = '0143',
        size = 'auto',
      }
      
      dashboard.section.header.val = pokemon.header()

      -- Cor azul-acinzentada para o Snorlax
      vim.api.nvim_set_hl(0, 'AlphaHeader', { fg = '#7C8A9D', bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'AlphaButtons', { fg = '#61AFEF', bg = 'NONE' })
      
      dashboard.section.header.opts.hl = 'AlphaHeader'

      alpha.setup(dashboard.config)

      -- Atalho da Pokédex
      vim.keymap.set('n', '<F2>', '<cmd>PokemonTogglePokedex<CR>', { desc = 'Abrir/fechar Pokédex' })
    end,
  },
}

