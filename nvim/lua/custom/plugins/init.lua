-- Plugins customizados
-- GitHub Copilot e CopilotChat configurados

return {
  -- GitHub Copilot (plugin oficial)
  {
    'github/copilot.vim',
    event = 'InsertEnter',
  },

  -- Copilot Chat - Conversa com Copilot dentro do Neovim
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim' },
    },
    build = 'make tiktoken',
    opts = {
      debug = false,
    },
    keys = {
      { '<leader>zc', ':CopilotChat<CR>', mode = 'n', desc = 'Chat com Copilot' },
      { '<leader>ze', ':CopilotChatExplain<CR>', mode = 'v', desc = 'Explicar código selecionado' },
      { '<leader>zr', ':CopilotChatReview<CR>', mode = 'v', desc = 'Revisar código' },
      { '<leader>zf', ':CopilotChatFix<CR>', mode = 'v', desc = 'Corrigir bugs' },
      { '<leader>zo', ':CopilotChatOptimize<CR>', mode = 'v', desc = 'Otimizar código' },
      { '<leader>zd', ':CopilotChatDocs<CR>', mode = 'v', desc = 'Gerar documentação' },
      { '<leader>zt', ':CopilotChatTests<CR>', mode = 'v', desc = 'Gerar testes' },
      { '<leader>zm', ':CopilotChatCommit<CR>', mode = 'n', desc = 'Gerar mensagem de commit' },
    },
  },
}
