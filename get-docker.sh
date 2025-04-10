#!/bin/bash

clear
echo "🚀 Atualizando pacotes..."
apt update && apt upgrade -y
sleep 10

clear
echo "📦 Instalando dependências do Docker..."
apt install apt-transport-https ca-certificates curl software-properties-common gnupg -y
sleep 10

clear
echo "🔐 Adicionando chave GPG do Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sleep 10

clear
echo "📥 Adicionando repositório Docker..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
tee /etc/apt/sources.list.d/docker.list > /dev/null
sleep 10

clear
echo "🔄 Atualizando pacotes..."
apt update
sleep 10

clear
echo "🐳 Instalando Docker..."
apt install docker-ce docker-ce-cli containerd.io docker-compose -y
sleep 10

clear
echo "✅ Docker instalado: $(docker --version)"
sleep 10

clear
echo "🌐 Instalando NGINX..."
apt install nginx -y
sleep 10

clear
echo "📦 Instalando Certbot para SSL..."
apt install certbot python3-certbot-nginx -y
sleep 10

clear
echo "🔐 Gerando certificado SSL para df.apigestor.shop..."
certbot --nginx -d df.apigestor.shop --non-interactive --agree-tos -m admin@df.apigestor.shop --redirect
sleep 10

clear
echo "✅ Certificado SSL configurado com sucesso!"
sleep 10

clear
echo "📁 Clonando Dify (versão 0.15.3)..."
git clone https://github.com/langgenius/dify.git --branch 0.15.3
cd dify/docker
sleep 10

clear
echo "⚙️ Configurando .env..."
cp .env.example .env
sleep 10

clear
echo "🐋 Iniciando containers com Docker Compose..."
docker compose up -d
sleep 10

clear
echo "✅ Verificando containers ativos..."
docker ps
sleep 10

clear
echo "✅ Instalação finalizada com sucesso!"
echo "🌍 Acesse: https://df.apigestor.shop"
