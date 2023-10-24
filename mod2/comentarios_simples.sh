#!/usr/bin/env bash

# Lynx instalado?
[ ! -x "$(which lynx)" ] && printf "${YELLOW}Precisamos instalar o ${GREEN}Lynx${YELLOW}, por favor, instale-o."

# Sem parâmetros obrigatórios?
[ -z $1 ] && printf "${RED}[ERRO] - Informe os parâmetros obrigatórios. Consulte a opção -h\n" && exit 1