#!/bin/bash

# Função para limpar diretórios
clean_dir() {
    local dir="$1"
    if [ -d "$dir" ]; then
        echo "Limpando $dir..."
        sudo find "$dir" -mindepth 1 -exec rm -rf {} +
    else
        echo "$dir não encontrado ou não é um diretório."
    fi
}

# Limpeza de cache e pacotes não utilizados
echo "Limpando cache e pacotes não utilizados..."
sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null
sudo pacman -Sc --noconfirm

# Limpeza de diretórios temporários
clean_dir /tmp
clean_dir /var/tmp

# Limpeza de caches do usuário
echo "Limpando caches do usuário..."
find "$HOME/.cache/" -type f -delete
find "$HOME/.cache/" -type d -empty -delete

# Limpeza de logs antigos
echo "Limpando logs antigos..."
sudo find /var/log -type f -name "*.log" -exec truncate -s 0 {} +

# Limpeza do lixo do usuário
echo "Limpando lixo do usuário..."
rm -rf ~/.local/share/Trash/*
rm -rf ~/.thumbnails/*

# Limpar pastas recentes
echo "Limpando pastas recentes..."
> "$HOME/.local/share/recently-used.xbel"

# Limpeza de banco de dados Rhythmbox (opcional)
echo "Limpando Rhythmbox..."
rm -rf ~/.local/share/rhythmbox/*

# Fim
echo "Limpeza concluída com sucesso!"

