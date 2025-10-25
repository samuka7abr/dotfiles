# 🎨 Dotfiles - Configuração do Sistema# my dotfiles


Configuração completa para Fedora com GNOME + Fish + Kitty + Neovim

## 📦 O que está incluído:

### Shell & Terminal
- **Fish** - Shell moderno
  - Oh My Posh com git branch no prompt
  - Aliases úteis
  - Audio fix automático (Samsung + SOF)
  
- **Kitty** - Terminal GPU-accelerated
  - Opacidade 97%
  - Cores do wallpaper (matugen)
  - JetBrains Mono Nerd Font

- **Bash** - Fallback configurado

### Editor
- **Neovim** - Editor moderno
  - Tema: One Dark Pro transparente
  - LSP: Lua, TypeScript/JavaScript
  - Auto-save, Auto-pairs, BufferLine
  - Pokemon dashboard (Snorlax!)

### Cores & Temas
- **Matugen** - Extrai cores do wallpaper
- **Oh My Posh** - Prompt personalizado

### Scripts
- `wallpaper-colors.sh` - Muda wallpaper e aplica cores
- `install-fedora.sh` - Instala dev tools

## 🚀 Instalação Rápida

```bash
# 1. Clone
git clone https://github.com/samuka7abr/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 2. Copie as configurações
cp -r fish kitty nvim matugen ohmyposh ~/.config/
cp system/git/.gitconfig ~/
cp scripts/wallpaper-colors.sh ~/.config/
chmod +x ~/.config/wallpaper-colors.sh

# 3. Configure Fish como padrão
chsh -s $(which fish)

# 4. Instale dev tools (opcional)
sudo ./install-fedora.sh
```

## 📝 Dependências

```bash
sudo dnf install fish kitty neovim eza fastfetch jetbrains-mono-fonts-all
cargo install matugen
curl -s https://ohmyposh.dev/install.sh | bash -s
```

## 🎨 Uso

```bash
# Mudar wallpaper com cores automáticas
setwallpaper /caminho/da/imagem.jpg

# Aliases
ll   # ls detalhado
v    # nvim
gs   # git status
```

---

Feito com ❤️ e Fish 🐟
