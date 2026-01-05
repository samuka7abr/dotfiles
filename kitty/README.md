# Kitty Terminal Configuration

Esta pasta contém as configurações do Kitty, um terminal emulador moderno baseado em GPU.

## Arquivos

### kitty.conf
Arquivo principal de configuração com as seguintes opções:

- **Fonte**
  - Família: JetBrainsMono Nerd Font
  - Tamanho: 12pt
  - Suporte automático para negrito e itálico

- **Janela**
  - Tamanho inicial: 120 colunas x 34 linhas
  - Padding: 10px
  - Decorações ocultas (modo minimalista)
  - Opacidade de fundo: 0.9 (com suporte a opacidade dinâmica)
  - Borda: 1pt

- **Cursor**
  - Intervalo de piscada: 0.5s
  - Para de piscar após 1s
  - Cursor animado com trilha (cursor_trail 2)

- **Comportamento**
  - Scrollback: 2000 linhas
  - Sem som de notificação
  - Não confirma fechamento de janela
  - Seleção sem cor de fundo/primeiro plano customizada

- **Atalhos Personalizados**
  - `Shift+Enter`: envia escape + return

- **Integração com Matugen**
  - Inclui `colors-matugen.conf` para cores dinâmicas baseadas no wallpaper

### colors-matugen.conf
Arquivo de cores gerado automaticamente pelo Matugen. As cores são extraídas do wallpaper atual e aplicadas ao terminal.

Este arquivo é regenerado automaticamente quando você troca de wallpaper usando o script `wallpaper-colors.sh`.

### custom.conf
Arquivo opcional para configurações personalizadas que sobrescrevem as padrões.

Crie este arquivo em `~/.config/kitty/custom.conf` para adicionar suas próprias configurações sem modificar o arquivo principal.

## Como Usar

1. Copie ou link esta pasta para `~/.config/kitty/`
2. Reinicie o Kitty ou recarregue a configuração: `Ctrl+Shift+F5`
3. Para personalizar, crie um arquivo `custom.conf` na mesma pasta

## Dependências

- kitty terminal
- JetBrainsMono Nerd Font
- matugen (para cores dinâmicas do wallpaper)

## Features Destacadas

- **Cores Dinâmicas**: As cores do terminal mudam automaticamente de acordo com o wallpaper
- **Performance**: Renderização acelerada por GPU
- **Transparência**: Fundo semi-transparente (90%)
- **Cursor Animado**: Trilha visual ao mover o cursor
