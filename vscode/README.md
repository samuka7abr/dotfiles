# Configurações do VSCode

Esta pasta contém as configurações exportadas do Visual Studio Code.

## Estrutura

```
vscode/
└── User/
    ├── settings.json    # Configurações do editor
    ├── mcp.json        # Configurações do MCP (Model Context Protocol)
    └── snippets/       # Snippets personalizados
```

## Arquivos

### settings.json

Configurações principais do VSCode, incluindo:
- Preferências do editor (tema, fonte, formatação)
- Configurações de extensões
- Atalhos e comportamentos

### mcp.json

Configurações do Model Context Protocol para integração com ferramentas de IA.

### snippets/

Contém snippets de código personalizados para diferentes linguagens.

## Como Usar

### Método 1: Link Simbólico (Recomendado)

```bash
# Backup das configurações atuais (se existirem)
mv ~/.config/Code/User/settings.json ~/.config/Code/User/settings.json.backup
mv ~/.config/Code/User/mcp.json ~/.config/Code/User/mcp.json.backup

# Criar links simbólicos
ln -s /caminho/para/dotfiles/vscode/User/settings.json ~/.config/Code/User/settings.json
ln -s /caminho/para/dotfiles/vscode/User/mcp.json ~/.config/Code/User/mcp.json
ln -s /caminho/para/dotfiles/vscode/User/snippets ~/.config/Code/User/snippets
```

### Método 2: Copiar Arquivos

```bash
# Copiar configurações
cp -r vscode/User/* ~/.config/Code/User/
```

## Sincronização

Para atualizar as configurações neste repositório após fazer mudanças no VSCode:

```bash
# Atualizar settings.json
cp ~/.config/Code/User/settings.json vscode/User/

# Atualizar mcp.json
cp ~/.config/Code/User/mcp.json vscode/User/

# Atualizar snippets
cp -r ~/.config/Code/User/snippets vscode/User/
```

## Dependências

- VSCode instalado
- Extensões referenciadas no settings.json devem ser instaladas manualmente ou via sync

## Notas

- Revise as configurações antes de aplicar, especialmente paths absolutos
- Algumas configurações podem ser específicas para seu sistema
- Configurações de extensões podem requerer que as extensões estejam instaladas
