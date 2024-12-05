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
%token FACA SER SER_IGUAL_A MOSTRE SOME SOMA_DE MULTIPLIQUE MULTIPLICACAO_DE COM POR REPITA VEZES FIM SE ENTAO SENAO
%token NAO_ACONTECER_QUE FOR
%token MAIOR_QUE MENOR_QUE IGUAL_A MAIOR_OU_IGUAL_QUE MENOR_OU_IGUAL_QUE DIFERENTE_DE
%token E OU
%token EOL

%type <var> cmds cmd operacao condicao condicao_nao_nula compara operador_logico objeto
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
            FACA VAR SER NUM 
            {
                fprintf(output, "float %s=%s", $2, $4); 
            }
            EOL
            {
                fprintf(output, ";\n"); 
            }
            | FACA VAR SER_IGUAL_A VAR
            {
                fprintf(output, "float %s=%s", $2, $4); 
            } 
            EOL
            {
                fprintf(output, ";\n"); 
            }
            
            | FACA VAR SER_IGUAL_A 
            {
                fprintf(output, "float %s=", $2); 
            }
            operacao EOL
            {
                fprintf(output, ";\n"); 
            }
            ;

impressao: 
            MOSTRE 
            {
                fprintf(output, "printf(\"%%f\\n\","); 
            }
            objeto 
            {
                fprintf(output, ")"); 
            }
            EOL
            {
                fprintf(output, ";\n"); 
            }
            | MOSTRE 
            {
                fprintf(output, "printf(\"%%f\\n\","); 
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
            EOL 
            {
                fprintf(output, ";\n");
            }
            | SOME VAR COM NUM
            {
                fprintf(output, "%s += %s", $2, $4);
            }
            EOL 
            {
                fprintf(output, ";\n");
            }
            | SOMA_DE VAR COM VAR
            {
                fprintf(output, "%s + %s", $2, $4);
            }
            | SOMA_DE VAR COM NUM
            {
                fprintf(output, "%s + %s", $2, $4);
            }
            | SOMA_DE NUM COM NUM
            {
                fprintf(output, "%s + %s", $2, $4);
            }
            | MULTIPLIQUE VAR POR VAR
            {
                fprintf(output, "%s *= %s", $2, $4);
            }
            EOL 
            {
                fprintf(output, ";\n");
            }
            | MULTIPLIQUE VAR POR NUM
            {
                fprintf(output, "%s *= %s", $2, $4);
            }
            EOL 
            {
                fprintf(output, ";\n");
            }
            | MULTIPLICACAO_DE VAR POR VAR
            {
                fprintf(output, "%s * %s", $2, $4);
            }
            | MULTIPLICACAO_DE VAR POR NUM
            {
                fprintf(output, "%s * %s", $2, $4);
            }
            | MULTIPLICACAO_DE NUM POR NUM
            {
                fprintf(output, "%s * %s", $2, $4);
            }
            ;

repeticao: 
            REPITA NUM VEZES 
            {
                fprintf(output, "for (int i = 0; i<%s;i++) {\n", $2);
            }
            cmds FIM 
            {
                fprintf(output, "}\n");
            }
            ;

condicional: 
            SE 
            {
                fprintf(output, "if (");
            }
            condicao ENTAO 
            {
                fprintf(output, ") {\n");
            }
            cmds else FIM 
            {
                fprintf(output, "}\n");
            }
            ;

else:
            SENAO 
            {
                fprintf(output, "} else {\n");
            }
            cmds
            | {} // caso onde não tem else

condicao: 
            NAO_ACONTECER_QUE 
            {
                fprintf(output, "!(");
            }
            condicao_nao_nula
            {
                fprintf(output, ")");
            }
            | condicao_nao_nula
            ;

condicao_nao_nula: 
            objeto
            | objeto compara objeto
            | objeto compara objeto operador_logico condicao
            ;

compara: 
            FOR MAIOR_QUE             { fprintf(output, ">"); }
            | FOR MENOR_QUE           { fprintf(output, "<"); }
            | FOR IGUAL_A             { fprintf(output, "=="); }
            | FOR MAIOR_OU_IGUAL_QUE  { fprintf(output, ">="); }
            | FOR MENOR_OU_IGUAL_QUE  { fprintf(output, "<="); }
            | FOR DIFERENTE_DE        { fprintf(output, "!="); }
            ;

operador_logico: 
            E { fprintf(output, "&&"); }
            | OU { fprintf(output, "||"); }
            ;

objeto: 
            NUM { fprintf(output, "%s", $1); }
            | VAR { fprintf(output, "%s", $1); }
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
    fprintf(output, "#include <stdio.h>\n\nint main() {\n\n"); 
    yyparse();
    fprintf(output, "\nreturn 0;\n}\n");
    fclose(output);
    return 0;
}
