%{
#include "y.tab.h"
%}

%%

"FACA"               { return FACA; }
"SER"                { return SER; }
"SER IGUAL A"        { return SER_IGUAL_A; }
"MOSTRE"             { return MOSTRE; }
"REPITA"             { return REPITA; }
"VEZES"              { return VEZES; }
"FIM"                { return FIM; }
"SE"                 { return SE; }
"ENTAO"              { return ENTAO; }
"SENAO"              { return SENAO; }
"SOME"               { return SOME; }
"COM"                { return COM; }
"SOMA DE"            { return SOMA_DE; }
"NAO FOR"            { return NAO_FOR; }
"FOR"                { return FOR; }
"MAIOR QUE"          { return MAIOR_QUE; }
"MENOR QUE"          { return MENOR_QUE; }
"IGUAL A"            { return IGUAL_A; }
"MAIOR OU IGUAL QUE" { return MAIOR_OU_IGUAL_QUE; }
"MENOR OU IGUAL QUE" { return MENOR_OU_IGUAL_QUE; }
"DIFERENTE DE"       { return DIFERENTE_DE; }
"E"                  { return E; }
"OU"                 { return OU; }
"NAO"                { return NAO; }
"ACONTECER QUE"      { return ACONTECER_QUE; }

[0-9]+               { yylval.intval = atoi(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.strval = strdup(yytext); return VAR; }

[ \t\n]+             { /* Ignorar espaços e novas linhas */ }

.                    { printf("Caractere desconhecido: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
