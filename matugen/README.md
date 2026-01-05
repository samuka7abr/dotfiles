# Matugen Configuration

Esta pasta contém as configurações do Matugen, uma ferramenta que extrai cores de imagens (wallpapers) e gera paletas de cores para aplicar em diferentes aplicações.

## O que é Matugen?

Matugen é uma ferramenta Material Design 3 que extrai cores dominantes de uma imagem e gera esquemas de cores harmoniosos para serem usados em aplicações, terminais e temas.

## Arquivos

### config.toml
Arquivo de configuração que define os templates e destinos de saída:

**Templates Configurados:**

1. **Kitty Terminal** (`templates.kitty`)
   - Entrada: `~/.config/matugen/templates/kitty-colors.conf`
   - Saída: `~/.config/kitty/colors-matugen.conf`
   - Post-hook: `pkill -SIGUSR1 kitty` (recarrega o Kitty automaticamente)

2. **GTK 3** (`templates.gtk3`)
   - Entrada: `~/.config/matugen/templates/gtk-colors.css`
   - Saída: `~/.config/gtk-3.0/colors.css`

3. **GTK 4** (`templates.gtk4`)
   - Entrada: `~/.config/matugen/templates/gtk-colors.css`
   - Saída: `~/.config/gtk-4.0/colors.css`

4. **GNOME Shell** (`templates.gnome`)
   - Entrada: `~/.config/matugen/templates/gnome-colors.css`
   - Saída: `~/.config/gnome-shell/colors.css`

5. **Pywalfox** (`templates.pywalfox`) - Opcional
   - Entrada: `~/.config/matugen/templates/pywalfox-colors.json`
   - Saída: `~/.cache/wal/colors.json`
   - Para aplicar cores do wallpaper no navegador

### templates/
Diretório contendo os templates que o Matugen usa como base para gerar os arquivos de cores.

Cada template contém placeholders que são substituídos pelas cores extraídas do wallpaper.

## Como Funciona

1. Você escolhe um wallpaper
2. O script `wallpaper-colors.sh` chama o Matugen
3. Matugen extrai as cores principais do wallpaper
4. Gera arquivos de cores baseados nos templates configurados
5. Os post-hooks recarregam automaticamente as aplicações afetadas

## Como Usar

1. Copie ou link esta pasta para `~/.config/matugen/`
2. Execute o script de troca de wallpaper: `~/.config/wallpaper-colors.sh`
3. As cores serão aplicadas automaticamente em:
   - Terminal Kitty
   - Aplicações GTK 3/4
   - GNOME Shell
   - Navegador (se Pywalfox estiver configurado)

## Dependências

- matugen
- kitty (para terminal)
- GTK 3/4 (para aplicações GNOME)
- pywalfox (opcional, para integração com navegador)

## Personalização

Para adicionar novos templates:

1. Crie um arquivo de template em `templates/`
2. Adicione uma entrada em `config.toml`:
```toml
[templates.nome]
input_path = '~/.config/matugen/templates/seu-template'
output_path = '/caminho/de/saida'
post_hook = 'comando opcional para recarregar a aplicação'
```
