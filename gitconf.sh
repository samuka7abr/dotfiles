#!/bin/bash

# Script para instalar e configurar o Git, Git LFS e GitHub CLI.
#
# COMO USAR:
# 1. Salve este arquivo como setup_git.sh
# 2. Dê permissão de execução: chmod +x setup_git.sh
# 3. Execute: ./setup_git.sh
#
# O script pedirá sua senha 'sudo' para instalar os pacotes necessários.

# Para o script se houver algum erro
set -e

# --- VERIFICAÇÃO INICIAL ---
# Este script não deve ser executado como root, pois configura arquivos do usuário.
if [ "$EUID" -eq 0 ]; then
  echo "ERRO: Não execute este script como root ou com 'sudo'."
  echo "Execute como seu usuário normal. Ele solicitará a senha quando necessário."
  exit 1
fi

# --- FUNÇÕES ---

# Função para instalar as dependências via apt
install_dependencies() {
    echo "=> Verificando e instalando dependências: git, git-lfs, gh..."
    
    # Atualiza a lista de pacotes
    sudo apt-get update
    
    # Instala git e git-lfs
    sudo apt-get install -y git git-lfs
    
    # Instala o GitHub CLI (gh)
    if ! command -v gh &> /dev/null; then
        echo "=> GitHub CLI (gh) não encontrado. Instalando..."
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
        && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
        && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
        && sudo apt-get update \
        && sudo apt-get install -y gh
    else
        echo "=> GitHub CLI (gh) já está instalado."
    fi

    # Configura o git-lfs para o usuário atual
    git lfs install
    
    echo "=> Dependências instaladas com sucesso!"
}

# Função para criar os arquivos .gitconfig
configure_git() {
    echo "=> Configurando o arquivo ~/.gitconfig principal..."

    # Define os caminhos para os arquivos de configuração
    GITCONFIG_PATH="$HOME/.gitconfig"
    WORK_GITCONFIG_PATH="$HOME/.gitconfig-trabalho"
    
    # Usa um "Here Document" (cat <<'EOF') para escrever o conteúdo no .gitconfig
    # As aspas simples em 'EOF' garantem que nenhum caractere seja interpretado pelo shell
    cat <<'EOF' > "${GITCONFIG_PATH}"
# Configuração Pessoal (Padrão)
[user]
	email = samuelabrao2006@gmail.com
	name = samuka7abr

# Configurações globais que se aplicam a ambos os perfis
[filter "lfs"]
	required = true
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
[credential "https://github.com"]
	helper = 
	helper = !/usr/bin/gh auth git-credential
[credential "https://gist.github.com"]
	helper = 
	helper = !/usr/bin/gh auth git-credential

# Carregar a configuração de trabalho apenas no diretório BlueOcean
[includeIf "gitdir:/home/samuelabrao/VSCODE/BlueOcean/"]
	path = ~/.gitconfig-trabalho
EOF

    echo "=> Arquivo ${GITCONFIG_PATH} criado/atualizado com sucesso."

    # Verifica se o arquivo de trabalho já existe. Se não, cria um modelo.
    if [ ! -f "${WORK_GITCONFIG_PATH}" ]; then
        echo "=> Criando arquivo de modelo para o perfil de trabalho em ${WORK_GITCONFIG_PATH}..."
        cat <<'EOF' > "${WORK_GITCONFIG_PATH}"
# --- Configuração de Trabalho ---
# Este arquivo é carregado automaticamente quando você está em projetos dentro de:
# /home/samuelabrao/VSCODE/BlueOcean/
#
# Preencha com seu nome e e-mail de trabalho.
[user]
    name = Seu Nome de Trabalho
    email = seu-email@trabalho.com

# Você pode adicionar outras configurações específicas de trabalho aqui.
# [core]
#   sshCommand = ssh -i ~/.ssh/id_rsa_trabalho
EOF
        echo "=> Modelo do .gitconfig-trabalho criado. Edite-o com suas informações de trabalho."
    else
        echo "=> Arquivo ${WORK_GITCONFIG_PATH} já existe, não foi modificado."
    fi
}

# --- FUNÇÃO PRINCIPAL ---
main() {
    echo "--- INICIANDO INSTALAÇÃO E CONFIGURAÇÃO DO GIT ---"
    
    install_dependencies
    configure_git
    
    echo ""
    echo "--- CONFIGURAÇÃO DO GIT CONCLUÍDA! ---"
    echo ""
    echo "✅ Git, Git LFS e GitHub CLI foram instalados."
    echo "✅ Seu arquivo .gitconfig foi configurado com os seus dados."
    echo ""
    echo "⚠️ AÇÃO NECESSÁRIA E MUITO IMPORTANTE:"
    echo "   Para que o login no GitHub funcione, você precisa autenticar o GitHub CLI."
    echo "   Execute o seguinte comando no seu terminal e siga as instruções:"
    echo ""
    echo "   gh auth login"
    echo ""
}

# Executa o script
main
