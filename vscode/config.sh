#!/usr/bin/env bash

set -e

# Caminho da pasta do VS Code (ajuste se precisar)
VSCODE_CONFIG_DIR="$HOME/.config/Code/User"

echo "🔧 Criando diretório de configuração do VS Code em: $VSCODE_CONFIG_DIR"
mkdir -p "$VSCODE_CONFIG_DIR"

# Instala extensões
if [ -f "./extensions.txt" ]; then
  echo "Instalando extensões do extensions.txt..."
  xargs -n 1 code --install-extension < extensions.txt
else
  echo "Nenhum extensions.txt encontrado."
fi

# Copia settings.json
if [ -f "./settings.json" ]; then
  echo "Copiando settings.json..."
  cp ./settings.json "$VSCODE_CONFIG_DIR/settings.json"
else
  echo "Nenhum settings.json encontrado."
fi

# Copia keybindings.json (se existir)
if [ -f "./keybindings.json" ]; then
  echo "Copiando keybindings.json..."
  cp ./keybindings.json "$VSCODE_CONFIG_DIR/keybindings.json"
fi

echo "Configuração do VS Code concluída!"
