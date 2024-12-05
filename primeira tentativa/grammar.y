%{
#include <stdio.h>
#include <stdlib.h>

// Prototipos das funcoes usadas no YACC
void yyerror(const char *s);
int yylex();

%}

%union {
    int intval;
    char *strval;
}

%token FACA SER SER_IGUAL_A MOSTRE REPITA VEZES FIM SE ENTAO SENAO 
%token SOME COM SOMA_DE NAO_FOR FOR MAIOR_QUE MENOR_QUE IGUAL_A 
%token MAIOR_OU_IGUAL_QUE MENOR_OU_IGUAL_QUE DIFERENTE_DE E OU
%token NAO ACONTECER_QUE
%token NUM VAR
%type <intval> num
%type <strval> var objeto 
%type <strval> condicao condicao_nao_nula compara operador_logico

%%

programa:
    cmds
    ;

cmds:
    cmd cmds
    | cmd
    ;

cmd:
    atribuicao
    | impressao
    | operacao
    | repeticao
    | condicional
    ;

atribuicao:
    FACA var SER num '.'
    | FACA var SER_IGUAL_A objeto '.'
    | FACA var SER_IGUAL_A operacao '.'
    ;

impressao:
    MOSTRE var '.'
    | MOSTRE operacao '.'
    ;

operacao:
    SOME var COM var
    | SOME var COM num
    | SOME num COM num
    | SOMA_DE var COM var
    | SOMA_DE var COM num
    | SOMA_DE num COM num
    ;

repeticao:
    REPITA num VEZES ':' cmds FIM
    ;

condicional:
    SE condicao ENTAO cmds FIM
    | SE condicao ENTAO cmds SENAO cmds FIM
    ;

objeto:
    num
    | var
    ;

condicao:
    NAO ACONTECER_QUE condicao_nao_nula { $$ = strdup("NOT "); strcat($$, $2); }
    | condicao_nao_nula { $$ = $1; }
    ;

condicao_nao_nula:
    objeto compara objeto
    | objeto compara objeto operador_logico condicao
    ;

compara:
    NAO_FOR comparador { $$ = strdup("!="); strcat($$, $2); }
    | FOR comparador { $$ = $2; }
    ;

comparador:
    MAIOR_QUE
    | MENOR_QUE
    | IGUAL_A
    | MAIOR_OU_IGUAL_QUE
    | MENOR_OU_IGUAL_QUE
    | DIFERENTE_DE
    ;

operador_logico:
    E
    | OU
    ;

num:
    NUM
    ;

var:
    VAR
    ;

%%

// Tratamento de erros
void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}

int main() {
    printf("Iniciando o parser...\n");
    if (!yyparse()) {
        printf("Parsing concluído com sucesso!\n");
    } else {
        printf("Erro no parsing.\n");
    }
    return 0;
}
