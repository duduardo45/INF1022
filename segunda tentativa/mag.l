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
"COM"                    {return COM;}
"REPITA"                 {return REPITA;}
"VEZES"                  {return VEZES;}
"FIM"                    {return FIM;}
"SE"                     {return SE;}
"ENTAO"                  {return ENTAO;}
"SENAO"                  {return SENAO;}
"NAO ACONTECER QUE"      {return NAO_ACONTECER_QUE;}
"NAO FOR"                {return NAO_FOR;}
"FOR"                    {return FOR;}
"MAIOR QUE"              {return MAIOR_QUE;}
"MENOR QUE"              {return MENOR_QUE;}
"IGUAL A"                {return IGUAL_A;}
"MAIOR OU IGUAL QUE"     {return MAIOR_OU_IGUAL_QUE;}
"MENOR OU IGUAL QUE"     {return MENOR_OU_IGUAL_QUE;}
"DIFERENTE DE"           {return DIFERENTE_DE;}
"E"                      {return E;}
"OU"                     {return OU;}

[0-9]+                   { yylval.num = atoi(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*   { yylval.var = strdup(yytext); return VAR; }
[ \t\n]                  ; // Ignora espaços em branco
.                        return yytext[0];
%%
