#!/bin/bash

# Script para mudar wallpaper no GNOME e gerar cores com matugen
# Uso: wallpaper-colors.sh <caminho-da-imagem>

if [ -z "$1" ]; then
    echo "❌ Erro: Forneça o caminho da imagem do wallpaper"
    echo "Uso: $0 <caminho-da-imagem>"
    exit 1
fi

WALLPAPER_PATH="$1"

if [ ! -f "$WALLPAPER_PATH" ]; then
    echo "❌ Erro: Arquivo '$WALLPAPER_PATH' não encontrado"
    exit 1
fi

echo "🎨 Mudando wallpaper e gerando esquema de cores..."

# Define o wallpaper no GNOME
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_PATH"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER_PATH"

echo "✅ Wallpaper definido: $WALLPAPER_PATH"

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
