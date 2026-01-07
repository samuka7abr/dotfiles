-- CONFIGURAÇÕES BÁSICAS
-- ============================================================================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

-- ============================================================================
-- KEYMAPS BÁSICOS
-- ============================================================================
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Navegação entre janelas
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-b>', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file [B]rowser' })

-- ============================================================================
-- NAVEGAÇÃO RÁPIDA ENTRE JANELAS ESPECÍFICAS (Ctrl+1/2/3)
-- ============================================================================
-- Ctrl+1: Foca na NvimTree (se estiver aberta)
vim.keymap.set('n', '<C-1>', function()
    -- Procura pela janela do NvimTree
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if ft == 'NvimTree' then
            vim.api.nvim_set_current_win(win)
            return
        end
    end
    -- Se não encontrou, abre o NvimTree
    vim.cmd 'NvimTreeFocus'
end, { desc = 'Focus NvimTree' })

-- Ctrl+2: Foca na janela principal de código (maior janela de arquivo normal)
vim.keymap.set('n', '<C-2>', function()
    local main_win = nil
    local max_width = 0

    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        local bt = vim.api.nvim_buf_get_option(buf, 'buftype')

        -- Ignora janelas especiais (tree, terminal, etc)
        if ft ~= 'NvimTree' and bt ~= 'terminal' and bt ~= 'nofile' then
            local width = vim.api.nvim_win_get_width(win)
            if width > max_width then
                max_width = width
                main_win = win
            end
        end
    end

    if main_win then
        vim.api.nvim_set_current_win(main_win)
    end
end, { desc = 'Focus main editor' })

-- Ctrl+3: Foca no terminal (se estiver aberto)
vim.keymap.set('n', '<C-3>', function()
    -- Procura por janela com terminal
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local bt = vim.api.nvim_buf_get_option(buf, 'buftype')
        if bt == 'terminal' then
            vim.api.nvim_set_current_win(win)
            return
        end
    end
    -- Se não encontrou, pode abrir o toggleterm ou seu terminal favorito
    vim.notify('No terminal window found', vim.log.levels.WARN)
end, { desc = 'Focus terminal' })

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- ============================================================================
-- LAZY.NVIM SETUP
-- ============================================================================
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- PLUGINS
-- ============================================================================
require('lazy').setup({
    'NMAC427/guess-indent.nvim',

    -- Git signs
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    },

    -- Which-key para mostrar keymaps
    {
        'folke/which-key.nvim',
        event = 'VimEnter',
        config = function()
            require('which-key').setup {
                delay = 0,
                icons = {
                    mappings = vim.g.have_nerd_font,
                },
            }

            -- Registrar os grupos de keymaps
            require('which-key').add {
                { '<leader>s', group = '[S]earch' },
                { '<leader>t', group = '[T]oggle' },
                { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
                { '<leader>a', group = '[A]uto' },
                { '<leader>c', group = '[C]laude Code' },
            }
        end,
    },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        },
        config = function()
            require('telescope').setup {
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            local builtin = require 'telescope.builtin'
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

            vim.keymap.set('n', '<leader>/', function()
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = '[S]earch [/] in Open Files' })

            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[S]earch [N]eovim files' })
        end,
    },

    -- File explorer
    {
        'nvim-tree/nvim-tree.lua',
        version = '*',
        lazy = false,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('nvim-tree').setup {
                actions = {
                    open_file = {
                        quit_on_open = true,
                        resize_window = true,
                    },
                },
                git = {
                    enable = true,
                },
                filters = {
                    git_ignored = false,
                },
            }
        end,
    },

    -- Lazydev para desenvolvimento Lua/Neovim
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },

    -- LSP Configuration
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'mason-org/mason.nvim',
            'mason-org/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
            'saghen/blink.cmp',
        },
        config = function()
            require('mason').setup()

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
                    map('gra', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
                    map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                    map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                    map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                    map('gO', require('telescope.builtin').lsp_document_symbols, '[O]pen Document Symbols')
                    map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[O]pen [W]orkspace Symbols')
                    map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

                    -- Auto-import keymaps
                    map('<leader>ai', function()
                        vim.lsp.buf.code_action { context = { only = { 'source.organizeImports' } } }
                    end, '[A]uto [I]mport - Organize imports')

                    map('<leader>ao', function()
                        vim.lsp.buf.code_action { context = { only = { 'source.addMissingImports' } } }
                    end, '[A]uto [O]rganize - Add missing imports')

                    -- Auto-import automático ao sair do modo de inserção
                    local function auto_import_on_escape()
                        local clients = vim.lsp.get_clients { bufnr = 0 }
                        if #clients == 0 then
                            return
                        end

                        if
                            vim.bo.filetype == 'typescript'
                            or vim.bo.filetype == 'javascript'
                            or vim.bo.filetype == 'typescriptreact'
                            or vim.bo.filetype == 'javascriptreact'
                        then
                            vim.lsp.buf.code_action {
                                context = { only = { 'source.addMissingImports' } },
                                apply = true,
                            }
                        end

                        if vim.bo.filetype == 'go' then
                            vim.lsp.buf.code_action {
                                context = { only = { 'source.organizeImports' } },
                                apply = true,
                            }
                        end
                    end

                    vim.api.nvim_create_autocmd('InsertLeave', {
                        pattern = { '*.ts', '*.tsx', '*.js', '*.jsx', '*.go' },
                        callback = function()
                            vim.defer_fn(auto_import_on_escape, 100)
                        end,
                        desc = 'Auto-import on escape',
                    })

                    local function client_supports_method(client, method, bufnr)
                        if vim.fn.has 'nvim-0.11' == 1 then
                            return client:supports_method(method, bufnr)
                        else
                            return client.supports_method(method, { bufnr = bufnr })
                        end
                    end

                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                            end,
                        })
                    end

                    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                        end, '[T]oggle Inlay [H]ints')
                    end
                end,
            })

            vim.diagnostic.config {
                severity_sort = true,
                float = { border = 'rounded', source = 'if_many' },
                underline = { severity = vim.diagnostic.severity.ERROR },
                signs = vim.g.have_nerd_font and {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '󰅚 ',
                        [vim.diagnostic.severity.WARN] = '󰀪 ',
                        [vim.diagnostic.severity.INFO] = '󰋽 ',
                        [vim.diagnostic.severity.HINT] = '󰌶 ',
                    },
                } or {},
                virtual_text = {
                    source = 'if_many',
                    spacing = 2,
                    format = function(diagnostic)
                        return diagnostic.message
                    end,
                },
            }

            local capabilities = require('blink.cmp').get_lsp_capabilities()

            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                        },
                    },
                },
                ts_ls = {
                    settings = {
                        typescript = {
                            preferences = {
                                includePackageJsonAutoImports = 'auto',
                            },
                            suggest = {
                                autoImports = true,
                            },
                        },
                        javascript = {
                            preferences = {
                                includePackageJsonAutoImports = 'auto',
                            },
                            suggest = {
                                autoImports = true,
                            },
                        },
                    },
                },
                gopls = {
                    settings = {
                        gopls = {
                            usePlaceholders = true,
                            completeUnimported = true,
                            buildFlags = { '-tags=wireinject' },
                            gofumpt = true,
                            staticcheck = true,
                            directoryFilters = { '-**/node_modules', '-**/.git' },
                            semanticTokens = true,
                        },
                    },
                },
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                autoImportCompletions = true,
                                typeCheckingMode = 'basic',
                                useLibraryCodeForTypes = true,
                                diagnosticMode = 'workspace',
                            },
                        },
                    },
                },
                clangd = {
                    settings = {
                        clangd = {
                            fallbackFlags = { '-std=c++17' },
                        },
                    },
                },
            }

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, { 'stylua' })
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            require('mason-lspconfig').setup {
                ensure_installed = { 'lua_ls', 'ts_ls', 'pyright', 'clangd' },
                automatic_installation = true,
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }
        end,
    },

    -- Formatter
    {
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>f',
                function()
                    require('conform').format { async = true, lsp_format = 'fallback' }
                end,
                mode = '',
                desc = '[F]ormat buffer',
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                local disable_filetypes = { c = true, cpp = true }
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    return nil
                else
                    return {
                        timeout_ms = 500,
                        lsp_format = 'fallback',
                    }
                end
            end,
            formatters_by_ft = {
                lua = { 'stylua' },
            },
        },
    },

    -- Completion
    {
        'saghen/blink.cmp',
        event = 'VimEnter',
        version = '1.*',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                version = '2.*',
                build = (function()
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
            },
            'folke/lazydev.nvim',
        },
        opts = {
            keymap = {
                preset = 'default',
                ['<Tab>'] = { 'select_and_accept', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<C-e>'] = { 'hide' },
                ['<CR>'] = { 'accept', 'fallback' },
                ['<C-n>'] = { 'select_next', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback' },
                ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            },
            appearance = {
                nerd_font_variant = 'mono',
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                },
                menu = {
                    auto_show = true,
                },
                list = {
                    selection = {
                        preselect = true,
                        auto_insert = true,
                    },
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'lazydev' },
                providers = {
                    lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
                },
            },
            snippets = { preset = 'luasnip' },
            fuzzy = { implementation = 'lua' },
            signature = { enabled = true },
        },
    },

    -- Todo comments
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },

    -- LUALINE - Statusline bonita com cores do OneDark
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'onedark',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = {
                        'branch',
                        'diff',
                        {
                            'diagnostics',
                            sources = { 'nvim_diagnostic' },
                            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
                        },
                    },
                    lualine_c = {
                        {
                            'filename',
                            path = 1,
                            symbols = {
                                modified = '[+]',
                                readonly = '[-]',
                                unnamed = '[No Name]',
                            },
                        },
                    },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {},
                },
            }
        end,
    },

    -- Mini.nvim (AI e Surround)
    {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.ai').setup { n_lines = 500 }
            require('mini.surround').setup()
        end,
    },

    -- MINI.MOVE - Mover linhas com Alt+Setas
    {
        'echasnovski/mini.move',
        event = 'VeryLazy',
        config = function()
            require('mini.move').setup {
                mappings = {
                    -- Move visual selection
                    left = '<M-Left>',
                    right = '<M-Right>',
                    down = '<M-Down>',
                    up = '<M-Up>',

                    -- Move current line in Normal mode
                    line_left = '<M-Left>',
                    line_right = '<M-Right>',
                    line_down = '<M-Down>',
                    line_up = '<M-Up>',
                },
            }
        end,
    },

    -- COMMENT.NVIM - Comentar código com Ctrl+/
    {
        'numToStr/Comment.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        config = function()
            require('Comment').setup {
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            }

            -- Ctrl+/ para comentar (no terminal, Ctrl+/ vem como Ctrl+_)
            vim.keymap.set('n', '<C-_>', function()
                return vim.v.count == 0 and '<Plug>(comment_toggle_linewise_current)' or '<Plug>(comment_toggle_linewise_count)'
            end, { expr = true, desc = 'Comment toggle current line' })

            vim.keymap.set('v', '<C-_>', '<Plug>(comment_toggle_linewise_visual)', { desc = 'Comment toggle linewise (visual)' })
        end,
    },

    -- NVIM-COLORIZER - Mostra cores de códigos hex/rgb
    {
        'norcalli/nvim-colorizer.lua',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('colorizer').setup({
                '*', -- Ativa para todos os arquivos
                css = { css = true },
            }, {
                RGB = true,
                RRGGBB = true,
                names = false,
                RRGGBBAA = true,
                rgb_fn = true,
                hsl_fn = true,
                css = false,
                css_fn = false,
                mode = 'background',
            })
        end,
    },

    -- CLAUDECODE.NVIM - AI Assistant integrado (usa Claude CLI)
    {
        'coder/claudecode.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        },
        config = function()
            require('claudecode').setup {
                -- Vai usar o Claude CLI que você já logou!
                model = 'claude-sonnet-4',

                -- Configurações opcionais
                window = {
                    width = 0.3, -- 30% da largura da tela
                    height = 0.8, -- 80% da altura
                    position = 'right', -- 'left', 'right', 'top', 'bottom', 'center'
                },

                opts = {
                    diff_opts = {
                        auto_close_on_accept = true,
                        vertical_split = true,
                        open_in_current_tab = false,
                        keep_terminal_focus = true,
                    },
                },
            }

            -- Autocommand para manter width em 0.3 quando tree abre/fecha
            vim.api.nvim_create_autocmd({ 'WinResized', 'WinClosed' }, {
                group = vim.api.nvim_create_augroup('claudecode-width-fix', { clear = true }),
                callback = function()
                    -- Encontra a janela do claudecode (terminal na direita)
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        local bt = vim.api.nvim_buf_get_option(buf, 'buftype')
                        if bt == 'terminal' then
                            -- Calcula 30% da largura total
                            local total_width = vim.o.columns
                            local target_width = math.floor(total_width * 0.3)
                            local current_width = vim.api.nvim_win_get_width(win)

                            -- Se a largura não for ~30%, ajusta
                            if math.abs(current_width - target_width) > 5 then
                                vim.api.nvim_win_set_width(win, target_width)
                            end
                        end
                    end
                end,
            })

            -- Keymaps
            vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<cr>', { desc = '[C]laude [C]ode: Toggle' })
            vim.keymap.set('n', '<leader>cp', '<cmd>ClaudeCodePaste<cr>', { desc = '[C]laude [P]aste response' })
            vim.keymap.set('v', '<leader>cs', '<cmd>ClaudeCodeSend<cr>', { desc = '[C]laude [S]end selection' })
            vim.keymap.set('n', '<leader>cx', '<cmd>ClaudeCodeClear<cr>', { desc = '[C]laude Clear history' })
        end,
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = {
                'bash',
                'c',
                'diff',
                'html',
                'lua',
                'luadoc',
                'markdown',
                'markdown_inline',
                'query',
                'vim',
                'vimdoc',
            },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true, disable = { 'ruby' } },
        },
    },

    -- Seus plugins customizados
    { import = 'custom.plugins' },
}, {
    ui = {
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
    git = { filter = false },
})
