#!/bin/bash

# Verifica se um arquivo foi passado como argumento
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <arquivo.mag>"
    exit 1
fi

MAG_FILE="$1"

# Verifica se o arquivo existe
if [ ! -f "$MAG_FILE" ]; then
    echo "Erro: O arquivo $MAG_FILE não existe."
    exit 1
fi

# Nomes dos arquivos gerados
LEX_FILE="mag.l"
YACC_FILE="mag.y"

# Verifica se os arquivos LEX e YACC existem
if [ ! -f "$LEX_FILE" ] || [ ! -f "$YACC_FILE" ]; then
    echo "Erro: Os arquivos $LEX_FILE e/ou $YACC_FILE não foram encontrados."
    exit 1
fi

echo "Compilando o analisador léxico..."
flex "$LEX_FILE"
if [ $? -ne 0 ]; then
    echo "Erro ao compilar o arquivo LEX."
    exit 1
fi

echo "Compilando o analisador sintático..."
yacc -d "$YACC_FILE"
if [ $? -ne 0 ]; then
    echo "Erro ao compilar o arquivo YACC."
    exit 1
fi

echo "Compilando o executável..."
gcc lex.yy.c y.tab.c -o parser -ll
if [ $? -ne 0 ]; then
    echo "Erro ao compilar os arquivos gerados."
    exit 1
fi

echo "Executando o parser para o arquivo $MAG_FILE..."
./parser < "$MAG_FILE"
if [ $? -ne 0 ]; then
    echo "Erro ao executar o parser."
    exit 1
fi

echo "Execução concluída."



