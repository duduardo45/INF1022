%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *output = NULL;

void yyerror(const char *s);
int yylex();

%}

%union {
    int num;
    char *var;
}

%token <var> NUM
%token <var> VAR
%token FACA SER SER_IGUAL_A MOSTRE SOME SOMA_DE COM REPITA VEZES FIM SE ENTAO SENAO
%token NAO_ACONTECER_QUE NAO_FOR FOR
%token MAIOR_QUE MENOR_QUE IGUAL_A MAIOR_OU_IGUAL_QUE MENOR_OU_IGUAL_QUE DIFERENTE_DE
%token E OU
%token EOL

%type <var> cmds cmd operacao condicao condicao_nao_nula compara comparador operador_logico objeto
%type <var> atribuicao impressao repeticao condicional


%%
programa: 
            cmds
            ;

cmds: 
            cmds cmd
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
            FACA VAR SER NUM EOL
            | FACA VAR SER_IGUAL_A VAR
            {
                fprintf(output, "int %s=%s", $2, $4); 
            } 
            EOL
            {
                fprintf(output, ";\n"); 
            }
            
            | FACA VAR SER_IGUAL_A 
            {
                fprintf(output, "int %s=", $2); 
            }
            operacao EOL
            {
                fprintf(output, ";\n"); 
            }
            ;

impressao: 
            MOSTRE VAR 
            {
                fprintf(output, "printf(\"%%d\\n\",%s)", $2); 
            }
            EOL
            {
                fprintf(output, ";\n"); 
            }
            | MOSTRE 
            {
                fprintf(output, "printf(\"%%d\\n\",", $2); 
            }
            operacao 
            {
                fprintf(output, ")"); 
            }
            EOL
            {
                fprintf(output, ";\n"); 
            }
            ;

operacao: 
            SOME VAR COM VAR
            {
                fprintf(output, "%s += %s", $2, $4);
            }
            EOL {
                fprintf(output, ";\n");
            }
            | SOME VAR COM NUM
            {
                fprintf(output, "%s += %s", $2, $4);
            }
            EOL {
                fprintf(output, ";\n");
            }
            | SOMA_DE VAR COM VAR
            {
                fprintf(output, "%s + %s", $2, $4);
            }
            | SOMA_DE VAR COM NUM
            {
                fprintf(output, "%s + %s;\n", $2, $4);
            }
            ;

repeticao: 
            REPITA NUM VEZES ':' cmds FIM
            ;

condicional: 
            SE condicao ENTAO cmds FIM
            | SE condicao ENTAO cmds SENAO cmds FIM
            ;

condicao: 
            NAO_ACONTECER_QUE condicao_nao_nula
            | condicao_nao_nula {
                  $$ = $1;
              }
            ;

condicao_nao_nula: 
            objeto compara objeto
            | objeto compara objeto operador_logico condicao
            ;

compara: 
            NAO_FOR comparador
            | FOR comparador
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

objeto: 
            NUM
            | VAR
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
    fprintf(output, "int main() {\n"); 
    yyparse();
    fprintf(output, "\nreturn 0;\n}\n");
    fclose(output);
    return 0;
}
