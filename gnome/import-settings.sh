#!/bin/bash

# Script para importar as configurações do GNOME

echo "Importando configurações do GNOME..."

if [ -f "extensions-settings.conf" ]; then
    echo "Importando configurações das extensões..."
    dconf load /org/gnome/shell/extensions/ < extensions-settings.conf
fi

if [ -f "desktop-settings.conf" ]; then
    echo "Importando configurações do desktop..."
    dconf load /org/gnome/desktop/ < desktop-settings.conf
fi

if [ -f "shell-settings.conf" ]; then
    echo "Importando configurações do shell..."
    dconf load /org/gnome/shell/ < shell-settings.conf
fi

echo ""
echo "Configurações importadas com sucesso!"
echo ""
echo "IMPORTANTE: Para instalar as extensões listadas em extensions-list.txt,"
echo "você pode usar o Extension Manager ou instalar manualmente via:"
echo "  - https://extensions.gnome.org/"
echo "  - Ou use o comando: gnome-extensions install <extensão>"
