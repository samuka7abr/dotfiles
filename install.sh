#!/bin/bash

# Script para configurar um ambiente de desenvolvimento completo em sistemas Debian/Ubuntu.
#
# Executar com permissões de superusuário:
# sudo ./setup_dev_env.sh
#

# --- Configuração Inicial e de Segurança ---
# Para o script se houver algum erro
set -e

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute este script como root ou usando sudo."
  exit 1
fi

# Variável para pegar o usuário que chamou o sudo
# Essencial para adicionar o usuário correto ao grupo do docker
SUDO_USER_NAME=${SUDO_USER:-$(whoami)}

# --- Funções de Instalação ---

# Atualiza os pacotes do sistema e instala dependências básicas
update_and_install_deps() {
    echo "=> Atualizando lista de pacotes e instalando dependências básicas..."
    apt-get update
    apt-get install -y curl wget git unzip software-properties-common apt-transport-https ca-certificates gnupg2
    echo "=> Dependências básicas instaladas."
}

# Instala ferramentas de compilação para C e C++
install_build_tools() {
    echo "=> Instalando ferramentas de compilação para C/C++ (build-essential)..."
    apt-get install -y build-essential manpages-dev
    echo "=> Ferramentas para C/C++ instaladas."
}

# Instala Python 3, pip e venv
install_python() {
    echo "=> Instalando Python 3, pip e venv..."
    apt-get install -y python3 python3-pip python3-venv
    echo "=> Python instalado."
}

# Instala Node.js (via NodeSource) e TypeScript
install_nodejs_typescript() {
    echo "=> Instalando Node.js, npm e TypeScript..."
    # Adiciona o repositório do NodeSource para uma versão recente (ex: 20.x)
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt-get install -y nodejs
    # Instala o TypeScript globalmente usando npm
    npm install -g typescript
    echo "=> Node.js e TypeScript instalados."
}

# Instala a linguagem Go
install_golang() {
    echo "=> Instalando Go (Golang)..."
    # Define a versão do Go a ser instalada
    GOLANG_VERSION="1.22.5"
    GOLANG_URL="https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz"
    
    # Baixa e extrai o Go
    wget -q -O /tmp/go.tar.gz ${GOLANG_URL}
    tar -C /usr/local -xzf /tmp/go.tar.gz
    rm /tmp/go.tar.gz
    
    # Configura o PATH globalmente para o Go
    echo 'export PATH=$PATH:/usr/local/go/bin' > /etc/profile.d/go.sh
    echo "=> Go instalado. O PATH foi configurado globalmente."
    echo "   (Pode ser necessário reiniciar o terminal ou fazer logout/login)"
}

# Instala Docker e Docker Compose
install_docker() {
    echo "=> Instalando Docker e Docker Compose..."
    # Adiciona a chave GPG oficial do Docker
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    # Adiciona o repositório do Docker
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    apt-get update
    
    # Instala os pacotes do Docker
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Adiciona o usuário atual ao grupo 'docker' para não precisar de sudo
    usermod -aG docker ${SUDO_USER_NAME}
    
    echo "=> Docker instalado com sucesso."
    echo "!!! IMPORTANTE: Faça logout e login novamente para usar o Docker sem 'sudo' !!!"
}

# Instala PHP (versão recente), Composer e o instalador do Laravel
install_php_laravel() {
    echo "=> Instalando PHP, Composer e Laravel..."
    # Adiciona o repositório do Ondřej Surý para versões recentes do PHP
    add-apt-repository ppa:ondrej/php -y || {
        echo "Adicionando repositório PPA falhou, tentando método manual para Debian..."
        apt-get install -y lsb-release
        curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
        echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
    }
    
    apt-get update
    
    # Instala PHP 8.3 e extensões comuns para o Laravel
    apt-get install -y php8.3 php8.3-cli php8.3-fpm php8.3-mbstring php8.3-xml php8.3-curl php8.3-zip php8.3-bcmath php8.3-mysql php8.3-gd

    # Instala o Composer (gerenciador de dependências do PHP)
    echo "=> Instalando Composer..."
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

    # Instala o Laravel Installer globalmente via Composer
    # Executa como o usuário para instalar no diretório home dele
    su - ${SUDO_USER_NAME} -c "composer global require laravel/installer"

    # Configura o PATH globalmente para o Composer e Laravel
    echo 'export PATH=$PATH:$HOME/.config/composer/vendor/bin' > /etc/profile.d/composer.sh

    echo "=> PHP, Composer e Laravel Installer instalados."
    echo "   (Pode ser necessário reiniciar o terminal ou fazer logout/login para o PATH funcionar)"
}


# --- Função Principal de Execução ---
main() {
    echo "--- INICIANDO CONFIGURAÇÃO DO AMBIENTE DE DESENVOLVIMENTO ---"
    
    update_and_install_deps
    install_build_tools
    install_python
    install_nodejs_typescript
    install_golang
    install_docker
    install_php_laravel

    echo ""
    echo "--- INSTALAÇÃO CONCLUÍDA COM SUCESSO! ---"
    echo ""
    echo "Resumo e Próximos Passos:"
    echo "✅ Go, TypeScript, Python, C/C++, PHP e Laravel Installer instalados."
    echo "✅ Docker e Docker Compose instalados."
    echo ""
    echo "⚠️ AÇÃO NECESSÁRIA:"
    echo "   - Para usar o Docker sem 'sudo', você PRECISA fazer logout e login novamente."
    echo "   - Para que as variáveis de ambiente (PATH para Go e Laravel) funcionem, reinicie seu terminal."
    echo "   - (Recomendado: reinicie o computador para garantir que tudo foi carregado corretamente)."
    echo ""
    echo "Verificações rápidas (após reiniciar o terminal):"
    echo "   go version"
    echo "   tsc -v"
    echo "   python3 --version"
    echo "   gcc --version"
    echo "   docker --version (sem sudo)"
    echo "   php -v"
    echo "   composer --version"
    echo "   laravel --version"
}

# Executa a função principal
main
