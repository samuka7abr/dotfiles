#!/bin/bash

# Script para configurar um ambiente de desenvolvimento completo em Fedora.
#
# Executar com permissões de superusuário:
# sudo ./install.sh
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
    dnf upgrade -y
    dnf install -y curl wget git unzip ca-certificates gnupg2
    echo "=> Dependências básicas instaladas."
}

# Instala ferramentas de compilação para C e C++
install_build_tools() {
    echo "=> Instalando ferramentas de compilação para C/C++ (Development Tools)..."
    dnf group install -y "Development Tools" || dnf install -y @development-tools
    dnf install -y gcc gcc-c++ make
    echo "=> Ferramentas para C/C++ instaladas."
}

# Instala Python 3, pip e venv
install_python() {
    echo "=> Instalando Python 3, pip e venv..."
    dnf install -y python3 python3-pip python3-virtualenv
    echo "=> Python instalado."
}

# Instala Node.js (via NodeSource) e TypeScript
install_nodejs_typescript() {
    echo "=> Instalando Node.js, npm e TypeScript..."
    # Adiciona o repositório do NodeSource para uma versão recente (ex: 20.x)
    curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
    dnf install -y nodejs
    # Instala o TypeScript globalmente usando npm
    npm install -g typescript
    echo "=> Node.js e TypeScript instalados."
}

# Instala a linguagem Go

# Instala Docker e Docker Compose
install_docker() {
    echo "=> Instalando Docker e Docker Compose..."
    
    # Remove versões antigas se existirem
    dnf remove -y docker docker-client docker-client-latest docker-common \
                   docker-latest docker-latest-logrotate docker-logrotate \
                   docker-selinux docker-engine-selinux docker-engine 2>/dev/null || true
    
    # Adiciona o repositório do Docker manualmente
    cat <<EOF > /etc/yum.repos.d/docker-ce.repo
[docker-ce-stable]
name=Docker CE Stable - \$basearch
baseurl=https://download.docker.com/linux/fedora/\$releasever/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/fedora/gpg
EOF
    
    # Instala os pacotes do Docker
    dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Habilita e inicia o Docker
    systemctl enable docker
    systemctl start docker

    # Adiciona o usuário atual ao grupo 'docker' para não precisar de sudo
    usermod -aG docker ${SUDO_USER_NAME}
    
    echo "=> Docker instalado com sucesso."
    echo "!!! IMPORTANTE: Faça logout e login novamente para usar o Docker sem 'sudo' !!!"
}

# Instala PHP (versão recente), Composer e o instalador do Laravel
install_php_laravel() {
    echo "=> Instalando PHP, Composer e Laravel..."
    
    # Instala PHP e extensões comuns para o Laravel
    dnf install -y php php-cli php-fpm php-mbstring php-xml php-curl \
                   php-zip php-bcmath php-mysqlnd php-gd php-json php-opcache
    
    # Instala o Composer (gerenciador de dependências do PHP)
    echo "=> Instalando Composer..."
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

    # Instala o Laravel Installer globalmente via Composer
    # Executa como o usuário para instalar no diretório home dele
    su - ${SUDO_USER_NAME} -c "composer global require laravel/installer"

    # Configura o PATH globalmente para o Composer e Laravel
    echo 'export PATH=$PATH:$HOME/.config/composer/vendor/bin' > /etc/profile.d/composer.sh
    chmod +x /etc/profile.d/composer.sh

    echo "=> PHP, Composer e Laravel Installer instalados."
    echo "   (Pode ser necessário reiniciar o terminal ou fazer logout/login para o PATH funcionar)"
}


# --- Função Principal de Execução ---
main() {
    echo "--- INICIANDO CONFIGURAÇÃO DO AMBIENTE DE DESENVOLVIMENTO (FEDORA) ---"
    
    update_and_install_deps
    install_build_tools
    install_python
    install_nodejs_typescript
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
