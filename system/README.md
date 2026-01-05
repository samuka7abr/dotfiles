# Configurações de Sistema

Esta pasta contém configurações de nível de sistema que não são específicas de aplicações, mas sim do ambiente geral.

## Estrutura

```
system/
├── bash/         # Configurações do Bash shell
└── git/          # Configurações do Git
```

## Subpastas

### bash/

Contém configurações do Bash shell (shell alternativo ao Fish).

**Conteúdo:**
- `bashrc`: Link simbólico para configurações do Bash
  - Aponta para: `/home/samuka7abr/.mydotfiles/com.ml4w.dotfiles/.config/bashrc`

Este é um link para configurações externas, provavelmente de outro conjunto de dotfiles.

**Uso:**
Se quiser usar Bash em vez de Fish, copie ou link o bashrc:
```bash
ln -s /caminho/para/dotfiles/system/bash/bashrc ~/.bashrc
```

### git/

Contém configurações globais do Git.

**Arquivo: `.gitconfig`**

Configurações incluídas:

1. **Perfil Padrão (Pessoal)**
   ```ini
   [user]
   email = samuelabrao2006@gmail.com
   name = samuka7abr
   ```

2. **Git LFS (Large File Storage)**
   - Suporte completo para arquivos grandes
   - Filters configurados automaticamente

3. **Credenciais GitHub**
   - Integração com GitHub CLI (`gh`)
   - Autenticação automática via `gh auth git-credential`
   - Funciona para GitHub e Gist

4. **Perfil Condicional (Trabalho)**
   - Carrega configurações diferentes quando em `/home/samuelabrao/VSCODE/BlueOcean/`
   - Referencia `~/.gitconfig-trabalho`
   - Permite ter email/nome diferentes para projetos de trabalho

**Como funciona o perfil condicional:**
- Fora da pasta BlueOcean: usa perfil pessoal
- Dentro da pasta BlueOcean: carrega `~/.gitconfig-trabalho`

**Uso:**
```bash
# Copiar para home
cp system/git/.gitconfig ~/.gitconfig

# Ou criar link simbólico
ln -s /caminho/para/dotfiles/system/git/.gitconfig ~/.gitconfig

# Criar arquivo de configuração de trabalho (opcional)
nano ~/.gitconfig-trabalho
```

**Exemplo de `~/.gitconfig-trabalho`:**
```ini
[user]
    email = seu.email@empresa.com
    name = Seu Nome Profissional
```

## Como Usar

### Instalação Completa

```bash
# Git
ln -s /caminho/para/dotfiles/system/git/.gitconfig ~/.gitconfig

# Bash (se desejar usar Bash)
ln -s /caminho/para/dotfiles/system/bash/bashrc ~/.bashrc
```

### Verificar Configuração do Git

```bash
# Ver configuração atual
git config --list --show-origin

# Ver usuário configurado
git config user.name
git config user.email

# Testar em diretório de trabalho
cd ~/VSCODE/BlueOcean/
git config user.email  # Deve mostrar email de trabalho
```

## Dependências

### Git
- Git >= 2.13 (para `includeIf`)
- Git LFS (para suporte a arquivos grandes)
- GitHub CLI (`gh`) - para autenticação automática

**Instalar dependências:**
```bash
# Fedora
sudo dnf install git git-lfs gh

# Debian/Ubuntu
sudo apt install git git-lfs gh

# Configurar GitHub CLI
gh auth login
```

### Bash
- Bash shell (geralmente já instalado)

## Personalização

### Adicionar Mais Perfis Git

Para ter múltiplos perfis Git:

1. Edite `.gitconfig`:
```ini
[includeIf "gitdir:~/projetos/cliente-a/"]
    path = ~/.gitconfig-cliente-a

[includeIf "gitdir:~/projetos/open-source/"]
    path = ~/.gitconfig-opensource
```

2. Crie os arquivos correspondentes:
```bash
# ~/.gitconfig-cliente-a
[user]
    email = voce@cliente-a.com
    name = Seu Nome

# ~/.gitconfig-opensource
[user]
    email = seu.email@opensource.org
    name = Seu Nome
```

### Adicionar Aliases Git Globais

Adicione ao `.gitconfig`:
```ini
[alias]
    co = checkout
    br = branch
    ci = commit
    st = status
    lg = log --oneline --graph --decorate
```

## Notas Importantes

- O `.gitconfig` contém informações pessoais (email, nome)
- Revise e atualize com seus dados antes de usar
- O link do bashrc aponta para configurações externas
- Configurações condicionais do Git são poderosas para separar trabalho/pessoal
