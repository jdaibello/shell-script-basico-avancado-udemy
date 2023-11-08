#!/usr/bin/env bash
#
# extrai_titulos.sh - Extrai titulos do blog
#
# Site:       https://site.com.br
# Autor:      João Pedro
# Manutenção: João Pedro
#
# ----------------------------------------------------------------------- #
# Este programa irá extrair titulos do blog LXER, colocar em um arquivo de
# texto e ler mostrando com cores na tela.
#
# Exemplos:
#     $ ./extrai_titulos.sh
#     Neste exemplo o programa vai extrair os titulos e mostrar na tela.
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 08/11/2023, João Pedro:
#       - Montou a expressão regular com fator em comum
#   v1.1 08/11/2023, João Pedro:
#       - Criado primeiro código com cores
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.4.19
# ------------------------------------------------------------------------ #

# ----------------------------- VARIÁVEIS -------------------------------- #
ARQUIVO_DE_TITULOS="titulos.txt"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
# ------------------------------------------------------------------------ #

# ------------------------------ TESTES ---------------------------------- #
[ ! -x "$(which w3m)" ] && brew install w3m # w3m instalado?
# ------------------------------------------------------------------------ #

# ----------------------------- EXECUÇÃO --------------------------------- #
rm -rf $ARQUIVO_DE_TITULOS

w3m -dump_source http://lxer.com | grep blurb | sed 's/<div.*line">//;s/<\/span.*//' > $ARQUIVO_DE_TITULOS

while read -r titulo_lxer
do
    echo -e "${VERMELHO}Titulo: ${VERDE}$titulo_lxer"
done < "$ARQUIVO_DE_TITULOS"
# ------------------------------------------------------------------------ #