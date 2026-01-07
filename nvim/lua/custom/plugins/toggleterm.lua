return {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
        local term_buf = nil
        local term_win = nil

        local function find_code_window()
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
                local bt = vim.api.nvim_buf_get_option(buf, 'buftype')

                if ft ~= 'NvimTree' and bt ~= 'terminal' and bt ~= 'nofile' then
                    return win
                end
            end
            return nil
        end

        local function toggle_terminal()
            if term_win and vim.api.nvim_win_is_valid(term_win) then
                vim.api.nvim_win_close(term_win, true)
                term_win = nil
                return
            end

            local code_win = find_code_window()
            if not code_win then
                vim.notify('Nenhuma janela de código encontrada', vim.log.levels.WARN)
                return
            end

            vim.api.nvim_set_current_win(code_win)

            local code_height = vim.api.nvim_win_get_height(code_win)
            local term_height = math.floor(code_height * 0.25)

            vim.cmd('belowright ' .. term_height .. 'split')
            term_win = vim.api.nvim_get_current_win()

            if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
                vim.api.nvim_win_set_buf(term_win, term_buf)
            else
                vim.cmd('terminal')
                term_buf = vim.api.nvim_get_current_buf()
            end

            vim.api.nvim_win_set_option(term_win, 'winfixheight', true)
            vim.cmd('startinsert')
        end

        vim.keymap.set({ 'n', 't' }, '<C-j>', function()
            if vim.fn.mode() == 't' then
                vim.cmd('stopinsert')
            end
            toggle_terminal()
        end, { desc = 'Toggle terminal' })
    end,
}
