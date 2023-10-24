#!/usr/bin/env bash
#
# listaUsuarios.sh - Extrai usuários do /etc/passwd
#
# Site:       https://site.com.br
# Autor:      João Pedro
# Manutenção: João Pedro
#
# ----------------------------------------------------------------------- #
# Irá extrair usuários do /etc/passwd, havendo a possibilidade de colocar 
# em maiusculo e em ordem alfabética.
#
# Exemplos:
#     $ ./listaUsuarios.sh -s -m
#     Neste exemplo ficará em maiúsculo e em orderm alfabética
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 18/08/2023, João Pedro:
#       - Adicionando flags -s, -h e -v
#   v1.1 03/10/2023, João Pedro:
#       - Trocamos IF por CASE
#       - Adicionamos basename
#   v1.2 03/10/2023, João Pedro:
#       - Adicionamos chaves
#       - Adicionamos opção pra exibir usuários em maiúsculo
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.4.19
# ------------------------------------------------------------------------ #

# ----------------------------- VARIÁVEIS -------------------------------- #

USUARIOS="$(cat /etc/passwd | cut -d : -f 1)"
MENSAGEM_USO="
    $(basename $0) - [OPÇÕES]
        -h - Menu de ajuda
        -v - Versão
        -s - Ordenar a saída
        -m - Coloca em maiúsculo
"
VERSAO="v1.2"
CHAVE_ORDENA=0
CHAVE_MAIUSCULO=0

# ----------------------------- EXECUÇÃO --------------------------------- #

case "$1" in
    -h) echo "$MENSAGEM_USO" && exit 0 ;;
    -v) echo "$VERSAO" && exit 0       ;;
    -s) CHAVE_ORDENA=1                 ;;
    -m) CHAVE_MAIUSCULO=1              ;;
    *)  echo "$USUARIOS"               ;;
esac

[ $CHAVE_ORDENA -eq 1 ] && echo "$USUARIOS" | sort
[ $CHAVE_MAIUSCULO -eq 1 ] && echo "$USUARIOS" | tr [a-z] [A-Z]

# ------------------------------------------------------------------------ #