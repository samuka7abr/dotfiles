# Scripts Utilitários

Esta pasta contém scripts de automação e utilitários para gerenciar o ambiente.

## Scripts Disponíveis

### wallpaper-colors.sh

Script principal para trocar wallpaper e gerar esquema de cores automático.

**O que faz:**
1. Define o wallpaper no GNOME (light e dark mode)
2. Extrai cores dominantes da imagem usando Matugen
3. Aplica as cores em:
   - Terminal Kitty
   - Aplicações GTK 3/4
   - GNOME Shell
   - Outras aplicações configuradas no Matugen

**Uso:**
```bash
# Forma direta
./wallpaper-colors.sh /caminho/para/wallpaper.jpg

# Usando o alias (configurado no Fish)
wpp /caminho/para/wallpaper.jpg
# ou
setwallpaper /caminho/para/wallpaper.jpg
```

**Exemplo prático:**
```bash
# Trocar para wallpaper azul
wpp ~/Wallpapers/blue/my-wallpaper.jpg

# Trocar para wallpaper da pasta purple
wpp ~/Wallpapers/purple/neon-city.png
```

**Saída do script:**
```
🎨 Mudando wallpaper e gerando esquema de cores...
✅ Wallpaper definido: /path/to/wallpaper.jpg
🎨 Gerando paleta de cores...
✅ Cores geradas e aplicadas!

📝 Cores aplicadas em:
  - Kitty terminal
  - GTK 3/4
  - GNOME Shell (se configurado)

✨ Pronto! Aproveite seu novo visual!
```

**Dependências:**
- GNOME Desktop Environment
- `gsettings` (incluído no GNOME)
- `matugen` (instale com: `cargo install matugen`)

**Validações:**
- Verifica se o caminho da imagem foi fornecido
- Valida se o arquivo existe antes de aplicar
- Informa se o matugen não estiver instalado

## Integração com o Sistema

### Fish Shell
O script está integrado com aliases no Fish:
- `wpp`: atalho para wallpaper-colors.sh
- `setwallpaper`: atalho alternativo

Configurado em: `fish/config.fish:29-30`

### Script Global
Há também uma cópia do script na raiz do repositório:
- `/home/samuka7abr/.config/meusDotfilesGithub/dotfiles/wallpaper-colors.sh`

Ambos os scripts fazem a mesma coisa.

## Como Adicionar Novos Scripts

1. Crie o script nesta pasta:
   ```bash
   touch scripts/meu-script.sh
   chmod +x scripts/meu-script.sh
   ```

2. Adicione o shebang e documentação:
   ```bash
   #!/bin/bash
   # Descrição do que o script faz
   # Uso: meu-script.sh <argumentos>
   ```

3. (Opcional) Crie um alias no Fish:
   ```fish
   # Em fish/config.fish
   alias meuscript='~/.config/scripts/meu-script.sh'
   ```

## Boas Práticas

Os scripts nesta pasta seguem estas convenções:

- **Shebang**: Sempre incluir `#!/bin/bash` no início
- **Validação de entrada**: Verificar argumentos e existência de arquivos
- **Mensagens claras**: Usar emojis e mensagens descritivas
- **Saída informativa**: Indicar sucesso/erro claramente
- **Verificação de dependências**: Avisar se comandos necessários não estão instalados
- **Permissão de execução**: Arquivos `.sh` devem ser executáveis (`chmod +x`)

## Exemplos de Scripts Úteis

Ideias para novos scripts que podem ser adicionados:

- `backup-configs.sh`: Backup das configurações
- `install-fonts.sh`: Instalação de Nerd Fonts
- `theme-switcher.sh`: Alternar entre temas light/dark
- `screenshot-to-wallpaper.sh`: Transformar screenshot em wallpaper
- `wallpaper-random.sh`: Escolher wallpaper aleatório de uma pasta
