# Neovim Configuration

Esta pasta contém a configuração completa do Neovim, usando Lazy.nvim como gerenciador de plugins.

## Estrutura

```
nvim/
├── init.lua              # Arquivo principal de configuração
├── lazy-lock.json        # Lock file dos plugins (versões fixas)
├── .stylua.toml         # Configuração do formatador Lua
├── lua/
│   └── custom/          # Módulos personalizados
└── pack/                # Diretório de pacotes
```

## Arquivos Principais

### init.lua
Arquivo principal que contém toda a configuração do Neovim, incluindo:

**Configurações Básicas:**
- Leader key: `Space`
- Números de linha relativos e absolutos
- Suporte a mouse
- Clipboard integrado com o sistema
- Undo persistente
- Busca case-insensitive inteligente
- Tab width: 4 espaços
- Split automático para direita/baixo
- Cursorline ativado
- Scrolloff: 10 linhas

**Keymaps Principais:**
- `<Esc>`: remove highlight de busca
- `<leader>q`: abre quickfix list de diagnósticos
- `<C-h/j/k/l>`: navegação entre janelas
- `<Esc><Esc>`: sair do modo terminal

**Gerenciador de Plugins:**
- Usa Lazy.nvim para gerenciamento de plugins
- Auto-instalação do Lazy.nvim na primeira execução
- Plugins são carregados de forma preguiçosa (lazy loading) para performance

### lazy-lock.json
Arquivo gerado automaticamente pelo Lazy.nvim que trava as versões dos plugins instalados.

Garante reprodutibilidade da configuração entre diferentes máquinas.

### .stylua.toml
Configuração do StyLua, formatador de código Lua.

Usado para manter o código de configuração do Neovim formatado consistentemente.

### lua/custom/
Diretório para módulos Lua personalizados.

Organize aqui suas configurações modulares, funções customizadas e plugins próprios.

## Como Usar

1. **Instalação:**
   ```bash
   # Backup da configuração atual (se existir)
   mv ~/.config/nvim ~/.config/nvim.backup

   # Link ou copie esta pasta
   ln -s /caminho/para/dotfiles/nvim ~/.config/nvim
   ```

2. **Primeira Execução:**
   ```bash
   nvim
   ```
   - O Lazy.nvim será instalado automaticamente
   - Os plugins serão baixados e instalados
   - Aguarde a instalação completar

3. **Gerenciar Plugins:**
   - Abra o Neovim
   - Execute `:Lazy` para ver a interface de gerenciamento
   - Comandos úteis:
     - `:Lazy sync` - sincroniza plugins (instala/atualiza/limpa)
     - `:Lazy update` - atualiza plugins
     - `:Lazy clean` - remove plugins não utilizados

## Dependências

**Essenciais:**
- Neovim >= 0.9.0
- Git (para instalação de plugins)
- Nerd Font (para ícones)

**Recomendadas:**
- ripgrep (para busca em arquivos)
- fd (para busca de arquivos)
- node e npm (para LSP servers)
- stylua (para formatação Lua)

## Personalização

### Adicionar Novos Plugins

Edite o arquivo `init.lua` e adicione o plugin na seção de configuração do Lazy.nvim:

```lua
require('lazy').setup({
  -- Seus plugins aqui
  'usuario/nome-do-plugin',
})
```

### Criar Módulos Customizados

Crie arquivos em `lua/custom/`:

```lua
-- lua/custom/meu_modulo.lua
local M = {}

function M.minha_funcao()
  -- seu código
end

return M
```

Depois importe no `init.lua`:

```lua
require('custom.meu_modulo')
```

## Features Destacadas

- Configuração single-file (init.lua) fácil de entender
- Lazy loading de plugins para inicialização rápida
- Suporte a Nerd Fonts
- Clipboard compartilhado com o sistema
- Undo persistente entre sessões
- Busca inteligente (case-sensitive apenas quando há maiúsculas)
- Navegação intuitiva entre splits
