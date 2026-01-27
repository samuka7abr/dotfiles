#!/bin/bash

# Script para exportar as configurações do GNOME

echo "Exportando lista de extensões do GNOME..."
gnome-extensions list > extensions-list.txt

echo "Exportando configurações das extensões..."
dconf dump /org/gnome/shell/extensions/ > extensions-settings.conf

echo "Exportando configurações do desktop..."
dconf dump /org/gnome/desktop/ > desktop-settings.conf

echo "Exportando configurações do tema..."
dconf dump /org/gnome/shell/ > shell-settings.conf

echo ""
echo "Configurações exportadas com sucesso!"
echo "Arquivos criados:"
echo "  - extensions-list.txt"
echo "  - extensions-settings.conf"
echo "  - desktop-settings.conf"
echo "  - shell-settings.conf"
