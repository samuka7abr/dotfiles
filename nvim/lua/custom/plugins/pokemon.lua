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

      -- 1) Snorlax!
      pokemon.setup {
        number = '0143',
        size = 'auto',
      }
      dashboard.section.header.val = pokemon.header()

      -- 2) Garante true colors
      vim.o.termguicolors = true

      -- 3) Paleta Snorlax (ajuste à vontade)
      local colors = {
        Body = '#203244', -- azul do corpo
        Shadow = '#203244', -- sombra/contorno
        Belly = '#FFFFFF', -- barriga/rosto (branco)
        Light = '#FFFFF0', -- brilho/parte mais clara (quase branco)
      }

      -- Cria HL groups (fg apenas; bg 'none' mantém teu tema)
      for name, fg in pairs(colors) do
        vim.api.nvim_set_hl(0, 'Poke' .. name, { fg = fg, default = false })
      end

      -- 4) Usa as cores oficiais do plugin para colorir o header (colored_text_art)
      local function apply_pokemon_coloring(target_buf)
        local buf = target_buf or vim.api.nvim_get_current_buf()

        -- Verifica se o buffer é modificável
        if not vim.api.nvim_buf_get_option(buf, 'modifiable') then
          return
        end

        local poke = require 'pokemon'
        if not poke or not poke.pokemon then
          return
        end
        local size = poke.size or 'small'
        local art = poke.pokemon.colored_text_art[size]
        if not art then
          return
        end

        local rendered = {}
        for i = 1, #art do
          local line = {}
          for j = 1, #art[i] do
            line[#line + 1] = art[i][j][1]
          end
          rendered[i] = table.concat(line)
        end

        -- Tenta modificar o buffer com proteção adicional
        local success, err = pcall(function()
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, rendered)
        end)

        if not success then
          vim.notify('Erro ao aplicar coloração Pokemon: ' .. tostring(err), vim.log.levels.WARN)
          return
        end

        -- Aplica os highlights com proteção
        pcall(function()
          for i = 1, #art do
            local col = 0
            for j = 1, #art[i] do
              local char = art[i][j][1]
              local color = art[i][j][2]
              if color and #color > 0 then
                local hl = 'pokemon_' .. color
                vim.api.nvim_set_hl(0, hl, { fg = '#' .. color })
                vim.api.nvim_buf_add_highlight(buf, 0, hl, i - 1, col, col + #char)
              end
              col = col + #char
            end
          end
        end)
      end

      -- Registra antes do alpha.setup para não perder o evento
      vim.api.nvim_create_autocmd('User', {
        pattern = 'AlphaReady',
        callback = function(args)
          apply_pokemon_coloring(args.buf)
        end,
        once = true,
      })

      -- Fallback: caso o evento já tenha disparado, tenta aplicar após entrar no Vim
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          vim.schedule(function()
            pcall(apply_pokemon_coloring)
          end)
        end,
        once = true,
      })

      -- Agora inicializa o Alpha (depois dos autocmds)
      alpha.setup(dashboard.config)

      -- 6) Atalho da Pokédex
      vim.keymap.set('n', '<F2>', '<cmd>PokemonTogglePokedex<CR>', { desc = 'Abrir/fechar Pokédex' })
    end,
  },
}

