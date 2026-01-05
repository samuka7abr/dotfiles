# Fish Shell Configuration

Esta pasta contém as configurações do Fish Shell, um shell de linha de comando moderno e user-friendly.

## Arquivos

### config.fish
Arquivo principal de configuração do Fish Shell com:

- **Variáveis de Ambiente**
  - `EDITOR`: Define nvim como editor padrão
  - `PATH`: Adiciona diretórios importantes (.cargo/bin, .local/bin, ccache, go, composer)

- **Aliases Gerais**
  - `c`: clear - limpa o terminal
  - `nf, pf, ff`: fastfetch - exibe informações do sistema
  - `ls, ll, lt`: eza com ícones - listagem melhorada de arquivos
  - `v, vim`: abre o editor nvim
  - `setwallpaper, wpp`: executa script de troca de wallpaper
  - `mouse`: reinicia serviço logid (para configuração de mouse)
  - `gnome`: reinicia GDM

- **Aliases Git**
  - `gs`: git status
  - `ga`: git add
  - `gc`: git commit -m
  - `gp`: git push
  - `gpl`: git pull
  - `gst`: git stash
  - `gcheck`: git checkout

- **Funções**
  - `kitty-maximized` (alias: `kmax`): abre novo terminal Kitty maximizado

- **Integrações**
  - **Oh My Posh**: prompt customizado com suporte a git
  - **Fastfetch**: exibido automaticamente em terminais interativos
  - **Keychain**: gerenciamento automático de chaves SSH

- **Fixes Específicos**
  - Audio Fix para Samsung + SOF (desabilita auto-mute)

### fish_variables
Variáveis universais do Fish (geradas automaticamente pelo shell).

### conf.d/
Diretório para configurações modulares adicionais do Fish.

## Como Usar

1. Copie ou link esta pasta para `~/.config/fish/`
2. Reinicie o terminal ou execute `source ~/.config/fish/config.fish`
3. Liste todos os aliases disponíveis com `aliasList`

## Dependências

- fish shell
- eza (listagem de arquivos moderna)
- fastfetch (informações do sistema)
- oh-my-posh (prompt customizado)
- keychain (gerenciamento de chaves SSH)
- nvim (editor)
