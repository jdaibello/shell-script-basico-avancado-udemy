#!/usr/bin/env bash
#
# debug_1.sh - Extrai usuários do /etc/passwd
#
# Site:       https://site.com.br
# Autor:      João Pedro
# Manutenção: João Pedro
#
# ----------------------------------------------------------------------- #
# para debugar todo o script, usar bash +xv ou bash +x antes de chamá-lo
# Irá extrair usuários do /etc/passwd, havendo a possibilidade de colocar
# em maiusculo e em ordem alfabética.
#
# Exemplos:
#     $ ./debug_1.sh -s -m
#     Neste exemplo ficará em maiúsculo e em orderm alfabética
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 18/08/2023, João Pedro:
#       - Adicionamos flags -s, -h e -v
#   v1.1 24/10/2023, João Pedro:
#       - Trocamos IF por CASE
#       - Adicionamos basename
#   v1.2 24/10/2023, João Pedro:
#       - Adicionamos 2 chaves (flags)
#       - Adicionamos opção pra exibir usuários em maiúsculo: -m
#   v1.3 25/10/2023, João Pedro:
#       - Adicionamos while com shift e teste de variável
#       - Adicionamos 2 chaves (flags)
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
VERSAO="v1.3"
CHAVE_ORDENA=0
CHAVE_MAIUSCULO=0

# ----------------------------- EXECUÇÃO --------------------------------- #
while test -n "$1" # -n verifica se variável está nula
do
    case "$1" in
        -h) echo "$MENSAGEM_USO" && exit 0                ;;
        -v) echo "$VERSAO" && exit 0                      ;;
        -s) CHAVE_ORDENA=1                                ;;
        -m) CHAVE_MAIUSCULO=1                             ;;
        *)  echo "Opção inválida, valide o -h." && exit 1 ;;
    esac
    shift # Troca a variável $1 por $2 na primeira iteração e assim por diante
done

set -x # Mostra debug apenas nesse trecho de código (até o set +x)
[ $CHAVE_ORDENA -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | sort) # Para conseguir combinar as duas opções
[ $CHAVE_MAIUSCULO -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | tr '[:lower:]' '[:upper:]')

echo "$USUARIOS"
set +x

# ------------------------------------------------------------------------ #