return {
    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            -- Requer true colors
            vim.opt.termguicolors = true
            require('bufferline').setup {
                options = {
                    diagnostics = 'nvim_lsp',
                    separator_style = 'slant',
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    always_show_bufferline = true,
                    offsets = {
                        {
                            filetype = 'NvimTree',
                            text = 'File Explorer',
                            text_align = 'left',
                            separator = true,
                        },
                    },
                },
            }
            -- Navegação entre buffers
            vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Próximo buffer' })
            vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Buffer anterior' })
            -- Ctrl-Tab / Ctrl-Shift-Tab (depende do terminal reconhecer essas teclas)
            vim.keymap.set('n', '<C-Tab>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Próximo buffer (Ctrl-Tab)' })
            vim.keymap.set('n', '<C-S-Tab>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Buffer anterior (Ctrl-Shift-Tab)' })
        end,
    },
}
