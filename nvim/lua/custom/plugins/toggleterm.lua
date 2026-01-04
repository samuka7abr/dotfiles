return {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
        require('toggleterm').setup {
            open_mapping = [[<c-j>]], -- atalho
            size = 10, -- tamanho padrão
            direction = 'horizontal', -- **válido**
            start_in_insert = true,
            persist_size = true,
            shade_terminals = false, -- permite usar highlights customizados
        }
    end,
}
