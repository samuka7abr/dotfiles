# Oh My Posh Configuration

Esta pasta contém as configurações do Oh My Posh, um prompt customizável e moderno para shell.

## O que é Oh My Posh?

Oh My Posh é um engine de prompt customizável que funciona em qualquer shell, fornecendo informações úteis como diretório atual, branch git, tempo de execução de comandos, e muito mais.

## Arquivos

### custom.toml
Tema customizado principal usado no Fish Shell. Features:

**Layout:**
- **Linha 1 (esquerda):**
  - Caminho atual (azul, estilo curto, máx 3 níveis)
  - Seta separadora (`→`)
  - Informações Git (se em um repositório):
    - Branch atual (vermelho)
    - Status de modificações (asterisco amarelo se houver mudanças)
    - Indicadores de sync: ⇣ (behind) / ⇡ (ahead)
  - Tempo de execução do último comando (amarelo, se > 500ms)

- **Linha 1 (direita):**
  - Horário atual (formato 24h, magenta)

- **Linha 2:**
  - Prompt (`❯`) que muda de cor:
    - Magenta: comando anterior bem-sucedido (código 0)
    - Vermelho: comando anterior falhou (código > 0)

**Configurações:**
- `final_space = true`: adiciona espaço após o prompt
- `console_title_template`: mostra shell e pasta no título do terminal

### zen.toml
Tema minimalista alternativo. Provavelmente uma versão simplificada do custom.toml.

### zen.toml.bak
Backup do tema zen.toml.

### EDM115-newline.omp.json
Tema importado de EDM115 com quebra de linha. Configuração em formato JSON (mais verbosa que TOML).

### colors.json
Arquivo de definições de cores customizadas (se usado pelos temas).

## Como Usar

1. **Instalação:**
   ```bash
   # Link ou copie esta pasta
   ln -s /caminho/para/dotfiles/ohmyposh ~/.config/ohmyposh
   ```

2. **Ativar no Fish Shell:**
   Já configurado em `~/.config/fish/config.fish`:
   ```fish
   oh-my-posh init fish --config $HOME/.config/ohmyposh/custom.toml | source
   ```

3. **Trocar de Tema:**
   Edite o `fish/config.fish` e altere o caminho do config:
   ```fish
   oh-my-posh init fish --config $HOME/.config/ohmyposh/zen.toml | source
   ```

4. **Testar um Tema:**
   ```bash
   oh-my-posh init fish --config ~/.config/ohmyposh/zen.toml | source
   ```

## Dependências

- oh-my-posh
- Nerd Font (para ícones git, pastas, etc.)
- Fish Shell (ou outro shell suportado)
- Git (para informações de repositório)

## Segmentos Disponíveis

O tema `custom.toml` usa os seguintes segmentos:

1. **Path**: Mostra o diretório atual
   - Máximo 3 níveis de profundidade
   - Separador: `/`

2. **Git**: Informações do repositório
   - Branch atual
   - Status working tree (`*` se houver mudanças)
   - Ahead/behind commits

3. **Execution Time**: Tempo de execução do último comando
   - Só aparece se demorar mais de 500ms

4. **Time**: Horário atual (HH:MM)

5. **Text**: Prompt (`❯`) com feedback visual de erro

## Personalização

### Modificar Cores

Edite o arquivo `custom.toml` e altere os valores `foreground`:

```toml
foreground = 'blue'     # Azul
foreground = 'red'      # Vermelho
foreground = 'yellow'   # Amarelo
foreground = 'magenta'  # Magenta
foreground = 'cyan'     # Ciano
```

### Adicionar Novos Segmentos

Exemplos de segmentos úteis que podem ser adicionados:

- `node`: versão do Node.js
- `python`: versão do Python
- `rust`: versão do Rust
- `battery`: nível de bateria
- `aws`: perfil AWS ativo

Consulte a [documentação oficial](https://ohmyposh.dev/docs/segments/overview) para lista completa.

### Mudar Símbolos

Edite o template dos segmentos:

```toml
template = '{{ .Path }} '  # Seu símbolo customizado aqui
```

## Temas Incluídos

- **custom.toml**: Tema principal, equilibrado e informativo
- **zen.toml**: Tema minimalista
- **EDM115-newline.omp.json**: Tema importado com múltiplas linhas
