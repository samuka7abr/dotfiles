return {
  -- Auto Save
  {
    "Pocco81/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      enabled = true,
      debounce = 1500,
      trigger_events = { "InsertLeave", "TextChanged" },
      conditions = {
        exists = true,
        modifiable = true,
        filename_is_not = {},
        filetype_is_not = {},
      },
      execution_message = {
        message = "💾",
        dim = 0.5,
        cleaning_interval = 1000,
      },
    },
  },

  -- Auto pairs (parênteses, chaves, aspas)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
}









