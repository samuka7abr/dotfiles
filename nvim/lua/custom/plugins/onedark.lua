return {
  -- One Dark Pro com transparência customizada
  {
    'olimorris/onedarkpro.nvim',
    priority = 1000,
    config = function()
      require('onedarkpro').setup({
        options = {
          transparency = true,
          terminal_colors = true,
          lualine_transparency = true,
          highlight_inactive_windows = false,
        },
        highlights = {
          -- Mantém o texto com as cores do One Dark Pro
          Normal = { bg = 'NONE' },
          NormalFloat = { bg = 'NONE' },
          SignColumn = { bg = 'NONE' },
          -- Linha de número com fundo transparente
          LineNr = { bg = 'NONE' },
          CursorLineNr = { bg = 'NONE' },
          -- Git signs com fundo transparente
          GitSignsAdd = { bg = 'NONE' },
          GitSignsChange = { bg = 'NONE' },
          GitSignsDelete = { bg = 'NONE' },
          -- Telescope com opacidade
          TelescopeNormal = { bg = 'NONE' },
          TelescopeBorder = { bg = 'NONE' },
          -- NvimTree com opacidade
          NvimTreeNormal = { bg = 'NONE' },
          NvimTreeNormalNC = { bg = 'NONE' },
          -- BufferLine com leve opacidade
          BufferLineFill = { bg = 'NONE' },
        },
      })
      vim.cmd('colorscheme onedark')
    end,
  },
}
