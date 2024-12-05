%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *output;

void yyerror(const char *s);
int yylex();

%}

%union {
    int num;
    char *var;
}

%token <num> NUM
%token <var> VAR
%token FACA SER SER_IGUAL_A MOSTRE SOME SOMA_DE COM REPITA VEZES FIM SE ENTAO SENAO
%token NAO_ACONTECER_QUE NAO_FOR FOR
%token MAIOR_QUE MENOR_QUE IGUAL_A MAIOR_OU_IGUAL_QUE MENOR_OU_IGUAL_QUE DIFERENTE_DE
%token E OU

%type <var> cmds cmd operacao condicao condicao_nao_nula compara comparador operador_logico objeto
%type <var> atribuicao impressao repeticao condicional


%%
programa: 
            cmds { fprintf(output, "int main() {\n%s\nreturn 0;\n}\n", $1); }
            ;

cmds: 
            cmds cmd { $$ = strcat($1, $2); }
            | cmd { $$ = $1; }
            ;

cmd: 
            atribuicao
            | impressao
            | operacao
            | repeticao
            | condicional
            ;

atribuicao: 
            FACA VAR SER NUM '.' {
                  fprintf(output, "int %s = %d;\n", $2, $4);
              }
            | FACA VAR SER_IGUAL_A VAR '.' {
                  fprintf(output, "int %s = %s;\n", $2, $4);
              }
            | FACA VAR SER_IGUAL_A operacao '.' {
                  fprintf(output, "int %s = %s;\n", $2, $4);
              }
            ;

impressao: 
            MOSTRE VAR '.' {
                  fprintf(output, "printf(\"%%d\\n\", %s);\n", $2);
              }
            | MOSTRE operacao '.' {
                  fprintf(output, "printf(\"%%d\\n\", %s);\n", $2);
              }
            ;

operacao: 
            SOME VAR COM VAR {
                  char buffer[128];
                  sprintf(buffer, "%s + %s", $2, $4);
                  $$ = strdup(buffer);
              }
            | SOME VAR COM NUM {
                  char buffer[128];
                  sprintf(buffer, "%s + %d", $2, $4);
                  $$ = strdup(buffer);
              }
            | SOMA_DE VAR COM VAR {
                  char buffer[128];
                  sprintf(buffer, "%s + %s", $2, $4);
                  $$ = strdup(buffer);
              }
            | SOMA_DE VAR COM NUM {
                  char buffer[128];
                  sprintf(buffer, "%s + %d", $2, $4);
                  $$ = strdup(buffer);
              }
            ;

repeticao: 
            REPITA NUM VEZES ':' cmds FIM {
                  fprintf(output, "for (int i = 0; i < %d; i++) {\n%s\n}\n", $2, $5);
              }
            ;

condicional: 
            SE condicao ENTAO cmds FIM {
                  fprintf(output, "if (%s) {\n%s\n}\n", $2, $4);
              }
            | SE condicao ENTAO cmds SENAO cmds FIM {
                  fprintf(output, "if (%s) {\n%s\n} else {\n%s\n}\n", $2, $4, $6);
              }
            ;

condicao: 
            NAO_ACONTECER_QUE condicao_nao_nula {
                  char buffer[128];
                  sprintf(buffer, "!(%s)", $2);
                  $$ = strdup(buffer);
              }
            | condicao_nao_nula {
                  $$ = $1;
              }
            ;

condicao_nao_nula: 
            objeto compara objeto {
                  char buffer[128];
                  sprintf(buffer, "%s %s %s", $1, $2, $3);
                  $$ = strdup(buffer);
              }
            | objeto compara objeto operador_logico condicao {
                  char buffer[128];
                  sprintf(buffer, "(%s %s %s) %s (%s)", $1, $2, $3, $4, $5);
                  $$ = strdup(buffer);
              }
            ;

compara: 
            NAO_FOR comparador {
                  char buffer[128];
                  sprintf(buffer, "!= %s", $2);
                  $$ = strdup(buffer);
              }
            | FOR comparador {
                  $$ = $2;
              }
            ;

comparador: 
            MAIOR_QUE          { $$ = ">"; }
            | MENOR_QUE          { $$ = "<"; }
            | IGUAL_A            { $$ = "=="; }
            | MAIOR_OU_IGUAL_QUE { $$ = ">="; }
            | MENOR_OU_IGUAL_QUE { $$ = "<="; }
            | DIFERENTE_DE       { $$ = "!="; }
            ;

operador_logico: 
            E { $$ = "&&"; }
            | OU { $$ = "||"; }
            ;

objeto: 
            NUM { char buffer[128]; sprintf(buffer, "%d", $1); $$ = strdup(buffer); }
            | VAR { $$ = strdup($1); }
            ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}

int main() {
    output = fopen("output.c", "w");
    if (!output) {
        perror("Erro ao criar arquivo de saída");
        return 1;
    }
    yyparse();
    fclose(output);
    return 0;
}
