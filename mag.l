%{
#include "y.tab.h"
%}

%%
"FACA"                   {return FACA;}
"SER"                    {return SER;}
"SER IGUAL A"            {return SER_IGUAL_A;}
"MOSTRE"                 {return MOSTRE;}
"SOME"                   {return SOME;}
"SOMA DE"                {return SOMA_DE;}
"MULTIPLIQUE"            {return MULTIPLIQUE;}
"MULTIPLICACAO DE"       {return MULTIPLICACAO_DE;}
"COM"                    {return COM;}
"POR"                    {return POR;}
"REPITA"                 {return REPITA;}
"VEZES:"                  {return VEZES;}
"FIM"                    {return FIM;}
"SE"                     {return SE;}
"ENTAO"                  {return ENTAO;}
"SENAO"                  {return SENAO;}
"NAO ACONTECER QUE"      {return NAO_ACONTECER_QUE;}
"FOR"                    {return FOR;}
"MAIOR QUE"              {return MAIOR_QUE;}
"MENOR QUE"              {return MENOR_QUE;}
"IGUAL A"                {return IGUAL_A;}
"MAIOR OU IGUAL QUE"     {return MAIOR_OU_IGUAL_QUE;}
"MENOR OU IGUAL QUE"     {return MENOR_OU_IGUAL_QUE;}
"DIFERENTE DE"           {return DIFERENTE_DE;}
"E"                      {return E;}
"OU"                     {return OU;}
"."                      {return EOL;}

[0-9]+                   { yylval.var = strdup(yytext); return NUM; }
[0-9]+.[0-9]+            { yylval.var = strdup(yytext); return NUM; }
"(-"[0-9]+")"                   { yylval.var = strdup(yytext); return NUM; }
"(-"[0-9]+.[0-9]+")"            { yylval.var = strdup(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*   { yylval.var = strdup(yytext); return VAR; }
[ \t\n]                  ; // Ignora espaços em branco
.                        {}
%%
