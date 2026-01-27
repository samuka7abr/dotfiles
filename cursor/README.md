# Configurações do Cursor

Esta pasta contém as configurações exportadas do Cursor (editor baseado no VSCode com IA integrada).

## Estrutura

```
cursor/
└── User/
    ├── settings.json       # Configurações do editor
    ├── keybindings.json   # Atalhos de teclado personalizados
    └── snippets/          # Snippets personalizados
```

## Arquivos

### settings.json

Configurações principais do Cursor, incluindo:
- Preferências do editor (tema, fonte, formatação)
- Configurações de IA e chat
- Configurações de extensões
- Comportamentos personalizados

### keybindings.json

Atalhos de teclado personalizados para aumentar a produtividade.

### snippets/

Contém snippets de código personalizados para diferentes linguagens.

## Como Usar

### Método 1: Link Simbólico (Recomendado)

```bash
# Backup das configurações atuais (se existirem)
mv ~/.config/Cursor/User/settings.json ~/.config/Cursor/User/settings.json.backup
mv ~/.config/Cursor/User/keybindings.json ~/.config/Cursor/User/keybindings.json.backup

# Criar links simbólicos
ln -s /caminho/para/dotfiles/cursor/User/settings.json ~/.config/Cursor/User/settings.json
ln -s /caminho/para/dotfiles/cursor/User/keybindings.json ~/.config/Cursor/User/keybindings.json
ln -s /caminho/para/dotfiles/cursor/User/snippets ~/.config/Cursor/User/snippets
```

### Método 2: Copiar Arquivos

```bash
# Copiar configurações
cp -r cursor/User/* ~/.config/Cursor/User/
```

## Sincronização

Para atualizar as configurações neste repositório após fazer mudanças no Cursor:

```bash
# Atualizar settings.json
cp ~/.config/Cursor/User/settings.json cursor/User/

# Atualizar keybindings.json
cp ~/.config/Cursor/User/keybindings.json cursor/User/

# Atualizar snippets
cp -r ~/.config/Cursor/User/snippets cursor/User/
```

## Diferenças entre Cursor e VSCode

O Cursor é um fork do VSCode com funcionalidades de IA integradas:
- Chat com IA nativo
- Autocompletação com IA (Cursor Tab)
- Edição com comandos em linguagem natural
- Referências a código no chat

As configurações são compatíveis com VSCode, mas o Cursor adiciona configurações específicas de IA.

## Dependências

- Cursor instalado (https://cursor.sh)
- Extensões referenciadas no settings.json devem ser instaladas manualmente

## Notas

- Revise as configurações antes de aplicar, especialmente paths absolutos
- Algumas configurações podem ser específicas para seu sistema
- Configurações de IA podem requerer autenticação/assinatura do Cursor
- Keybindings podem conflitar com atalhos do sistema operacional
