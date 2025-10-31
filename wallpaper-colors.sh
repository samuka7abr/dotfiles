#!/bin/bash

# Script para mudar wallpaper no GNOME e gerar cores com matugen
# Uso: wallpaper-colors.sh <cor><numero>
# Exemplo: wallpaper-colors.sh pink1, wallpaper-colors.sh green3

# Diretório base dos wallpapers
WALLPAPERS_DIR="$HOME/Wallpapers"

# Verifica se foi passado um argumento
if [ -z "$1" ]; then
    echo "❌ Erro: Forneça a cor e o número do wallpaper"
    echo "Uso: $0 <cor><numero>"
    echo "Exemplo: $0 pink1, $0 green3, $0 purple2"
    echo ""
    echo "🎨 Cores disponíveis:"
    ls -1 "$WALLPAPERS_DIR" 2>/dev/null | grep -v "^total"
    exit 1
fi

# Extrai a cor e o número do argumento (ex: pink1 -> pink e 1)
INPUT="$1"
COLOR=$(echo "$INPUT" | sed 's/[0-9]*$//')
NUMBER=$(echo "$INPUT" | sed 's/^[^0-9]*//')

# Verifica se a pasta da cor existe
COLOR_DIR="$WALLPAPERS_DIR/$COLOR"
if [ ! -d "$COLOR_DIR" ]; then
    echo "❌ Erro: Cor '$COLOR' não encontrada!"
    echo ""
    echo "🎨 Cores disponíveis:"
    ls -1 "$WALLPAPERS_DIR" 2>/dev/null | grep -v "^total"
    exit 1
fi

# Lista os wallpapers disponíveis nessa cor e pega o arquivo correspondente
WALLPAPERS=($(ls -1 "$COLOR_DIR" | sort))
TOTAL=${#WALLPAPERS[@]}

# Verifica se o número é válido
if [ -z "$NUMBER" ] || [ "$NUMBER" -lt 1 ] || [ "$NUMBER" -gt "$TOTAL" ]; then
    echo "❌ Erro: Número inválido! A pasta '$COLOR' tem $TOTAL wallpapers."
    echo ""
    echo "🖼️  Wallpapers disponíveis em '$COLOR':"
    for i in "${!WALLPAPERS[@]}"; do
        echo "  $(($i + 1)). ${WALLPAPERS[$i]}"
    done
    exit 1
fi

# Pega o wallpaper (array começa em 0, então subtrai 1)
WALLPAPER_FILE="${WALLPAPERS[$(($NUMBER - 1))]}"
WALLPAPER_PATH="$COLOR_DIR/$WALLPAPER_FILE"

echo "🎨 Mudando para: $COLOR #$NUMBER ($WALLPAPER_FILE)"

# Define o wallpaper no GNOME
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_PATH"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER_PATH"

echo "✅ Wallpaper definido!"

# Gera as cores com matugen
if command -v matugen &> /dev/null; then
    echo "🎨 Gerando paleta de cores..."
    matugen image "$WALLPAPER_PATH"
    echo "✅ Cores geradas e aplicadas!"
    echo ""
    echo "📝 Cores aplicadas em:"
    echo "  - Kitty terminal"
    echo "  - GTK 3/4"
    echo "  - GNOME Shell (se configurado)"
else
    echo "⚠️  matugen não encontrado. Instale com: cargo install matugen"
fi

echo ""
echo "✨ Pronto! Aproveite seu novo visual!"
