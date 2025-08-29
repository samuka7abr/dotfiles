-- Theme configuration
-- OneDarkPro theme (One Dark Pro for Neovim)

return {
  {
    'olimorris/onedarkpro.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require('onedarkpro').setup({
        -- Theme to use
        theme = "onedark", -- onedark, onelight, onedark_vivid, onelight_vivid, onedark_dark, onelight_dark
        
        -- Cursor line highlighting
        cursorline = true,
        
        -- Transparent background
        transparent = false,
        
        -- Custom highlights (optional)
        highlights = {
          -- Cursor customization
          Cursor = { bg = "#61afef", fg = "#1e1e1e" },
          CursorLine = { bg = "#2a2a2a" },
          CursorLineNr = { fg = "#61afef", bg = "#2a2a2a" },
          
          -- Status line
          StatusLine = { bg = "#2a2a2a", fg = "#e8e8e8" },
          StatusLineNC = { bg = "#1e1e1e", fg = "#888888" },
        },
        
        -- Plugin integrations
        plugins = {
          -- All supported plugins are enabled by default
          aerial = true,
          barbar = true,
          gitsigns = true,
          indentline = true,
          lsp_semantic_tokens = true,
          mason = true,
          nvim_cmp = true,
          nvim_lsp = true,
          nvim_tree = true,
          nvim_ts_rainbow = true,
          telescope = true,
          treesitter = true,
          which_key = true,
        },
      })

      -- Load the colorscheme
      vim.cmd.colorscheme 'onedark'
    end,
  },
}
