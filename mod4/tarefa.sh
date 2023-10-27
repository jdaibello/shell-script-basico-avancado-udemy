#!/usr/bin/env bash
#
# tarefa.sh - Extrai usuários do /etc/passwd
#
# Site:       https://site.com.br
# Autor:      João Pedro
# Manutenção: João Pedro
#
# ----------------------------------------------------------------------- #
# Cria um CSV com dados de funcionários e lê o arquivo filtrando por nome,
# idade, departamento e/ou cargo, em maiusculo e/ou em ordem alfabética.
#
# Exemplos:
#     $ ./tarefa.sh -s -m
#     Neste exemplo ficará em maiúsculo e em orderm alfabética
#
#     $ ./tarefa.sh -n João -s -m
#     Neste exemplo ficará em maiúsculo e em orderm alfabética
#     os funcionários com nome João
#
#     $ ./tarefa.sh -n João -a 23 -s -m
#     Neste exemplo ficará em maiúsculo e em orderm alfabética
#     o funcionário com nome João e com 23 anos
#
#     $ ./tarefa.sh -a 20 -d TI -m
#     Neste exemplo ficará em maiúsculo os funcionários com 23 anos
#     no departamento de TI
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 25/08/2023, João Pedro:
#       - Busca por usuários
#       - Filtra por nome, idade, departamento e cargo
#       - Ornena a saída por nome
#       - Converte a saída em maiúsculo
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.4.19
# ------------------------------------------------------------------------ #

# CRIA ARQUIVO COM FUNCIONÁRIOS
ARQUIVO=./funcionarios.csv

rm -rf $ARQUIVO
touch $ARQUIVO

{
    echo "João,23,TI,Desenvolvedor"
    echo "Marcela,35,RH,Analista"
    echo "Pedro,32,Engenharia,Engenheiro de Produção"
    echo "Carlos,30,Engenharia,Supervisor"
    echo "Ágatha,19,TI,Estagiária de Suporte"
    echo "Guilherme,25,Cozinha,Chefe de Cozinha"
    echo "João,30,Recepção,Secretário"
    echo "Ricardo,42,RH,Analista"
} >> $ARQUIVO

MENU="
    $(basename $0) - [OPÇÕES]
        -h - Ajuda
        -v - Versão
        -s - Ordenar a saída
        -m - Colocar em maiúsculo
        -n - Procurar por nome
        -a - Procurar por idade
        -d - Procurar por departamento
        -p - Procurar por cargo
"

VERSAO="1.0"
CHAVE_ORDENA=0
CHAVE_MAIUSCULO=0
PROCURAR_NOME=NULL
PROCURAR_IDADE=NULL
PROCURAR_DEPARTAMENTO=NULL
PROCURAR_CARGO=NULL
FUNCIONARIOS="$(cat $ARQUIVO)"

while [[ -n "$1" ]]; do
    case "$1" in
        -h) echo "$MENU" && exit 0  ;;
        -v) echo "$VERSAO" && exit 0 ;;
        -s) CHAVE_ORDENA=1 ;;
        -m) CHAVE_MAIUSCULO=1 ;;
        -n) PROCURAR_NOME=$2 && shift ;;
        -a) PROCURAR_IDADE=$2 && shift ;;
        -d) PROCURAR_DEPARTAMENTO=$2 && shift ;;
        -p) PROCURAR_CARGO=$2 && shift ;;
        *) echo "Opção inválida, use -h para ver as opções" && exit 1 ;;
    esac
    shift
done

set -x
[[ $PROCURAR_NOME != NULL ]] && FUNCIONARIOS=$(echo "$FUNCIONARIOS" | grep "$PROCURAR_NOME")
[[ $PROCURAR_IDADE != NULL ]] && FUNCIONARIOS=$(echo "$FUNCIONARIOS" | grep "$PROCURAR_IDADE")
[[ $PROCURAR_DEPARTAMENTO != NULL ]] && FUNCIONARIOS=$(echo "$FUNCIONARIOS" | grep "$PROCURAR_DEPARTAMENTO")
[[ $PROCURAR_CARGO != NULL ]] && FUNCIONARIOS=$(echo "$FUNCIONARIOS" | grep "$PROCURAR_CARGO")
[ $CHAVE_ORDENA -eq 1 ] && FUNCIONARIOS=$(echo "$FUNCIONARIOS" | sort)
[[ $CHAVE_MAIUSCULO -eq 1 ]] && FUNCIONARIOS=$(echo "$FUNCIONARIOS" | tr '[:lower:]' '[:upper:]')

echo "$FUNCIONARIOS"
set +x