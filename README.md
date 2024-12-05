# INF1022 - Analisadores Léxico e Sintáticos

Repositório para o trabalho da matéria da PUC-Rio, tema tradução de arquivos .mag (linguagem com intuito para matemática) chamada matemágica


## Gramática suposta para esta implementação do analisador .mag
Deixando aqui para fazer uma implementação inicial apenas com isto

$$
\begin{align}
programa    \rightarrow&\quad   cmds \\
cmds        \rightarrow&\quad   cmd \; cmds \\
                      |&\quad   cmd \\
cmd         \rightarrow&\quad   atribuicao \\
                      |&\quad   impressao \\
                      |&\quad   operacao \\
                      |&\quad   repeticao \\
atribuicao  \rightarrow&\quad   \text{FACA} \; var \; \text{SER} \; num. \\
impressao   \rightarrow&\quad   \text{MOSTRE} \; var. \\
                      |&\quad   \text{MOSTRE} \; operacao. \\
operacao    \rightarrow&\quad   \text{SOME} \; var \; \text{COM} \; var. \\
                      |&\quad   \text{SOME} \; var \; \text{COM} \; num. \\
                      |&\quad   \text{SOME} \; num \; \text{COM} \; num. \\
repeticao   \rightarrow&\quad   \text{REPITA} \; num \; \text{VEZES} \; : \; cmds \; \text{FIM} \\
\end{align}
$$
___
## **Gramática Implementada Neste Trabalho:**

$$
\begin{align}
programa    \rightarrow&\quad   cmds \\
cmds        \rightarrow&\quad   cmd \; cmds \\
                      |&\quad   cmd \\
cmd         \rightarrow&\quad   atribuicao \\
                      |&\quad   impressao \\
                      |&\quad   operacao. \\
                      |&\quad   repeticao \\
                      |&\quad   condicional \\
atribuicao  \rightarrow&\quad   \text{FACA} \; var \; \text{SER} \; num. \\ % ideia usar ponteiros 
                      |&\quad   \text{FACA} \; var \; \text{SER IGUAL A} \; objeto. \\ % e aqui fazer copias
                      |&\quad   \text{FACA} \; var \; \text{SER IGUAL A} \; operacao. \\
impressao   \rightarrow&\quad   \text{MOSTRE} \; objeto. \\
                      |&\quad   \text{MOSTRE} \; operacao. \\
operacao    \rightarrow&\quad   \text{SOME} \; var \; \text{COM} \; var \\ % talvez estes serem += 
                      |&\quad   \text{SOME} \; var \; \text{COM} \; num \\ % talvez criar um ADICIONE
                      |&\quad   \text{SOME} \; num \; \text{COM} \; num \\
                      |&\quad   \text{SOMA DE} \; var \; \text{COM} \; var \\ % e estes serem +
                      |&\quad   \text{SOMA DE} \; var \; \text{COM} \; num \\
                      |&\quad   \text{SOMA DE} \; num \; \text{COM} \; num \\
                      |&\quad   \text{MULTIPLIQUE} \; var \; \text{COM} \; var \\ % talvez estes serem *= 
                      |&\quad   \text{MULTIPLIQUE} \; var \; \text{COM} \; num \\
                      |&\quad   \text{MULTIPLICACAO DE} \; var \; \text{COM} \; var \\ % e estes serem *
                      |&\quad   \text{MULTIPLICACAO DE} \; var \; \text{COM} \; num \\
                      |&\quad   \text{MULTIPLICACAO DE} \; num \; \text{COM} \; num \\
repeticao   \rightarrow&\quad   \text{REPITA} \;num \; \text{VEZES} \, : \, cmds \; \text{FIM} \\
condicional \rightarrow&\quad   \text{SE} \; condicao \; \text{ENTAO} \; cmds \; else \; \text{FIM} \\
else        \rightarrow&\quad   \text{SENAO} \; cmds \\
                      |&\quad   \\% ou não escreve nada no senão 
objeto              \rightarrow&\quad   num \\
                              |&\quad   var \\
num                 \rightarrow&\quad   [0-9]^+ \\
                              |&\quad   [0-9]^+.[0-9]^+ \\ 
                              |&\quad   (-[0-9]^+) \\
                              |&\quad   (-[0-9]^+.[0-9]^+) \\
var                 \rightarrow&\quad   [a-zA-Z_][a-zA-Z0-9_]* \\
condicao            \rightarrow&\quad   \text{NAO ACONTECER QUE} \; condicao\,nao\,nula \\
                              |&\quad   condicao\,nao\,nula \\
condicao\,nao\,nula \rightarrow&\quad   objeto \; compara \; objeto \\ % condicao não nula
                              |&\quad   objeto \; compara \; objeto \; operador\,logico \; condicao \\
compara             \rightarrow&\quad   \text{FOR MAIOR QUE} \\
                              |&\quad   \text{FOR MENOR QUE} \\
                              |&\quad   \text{FOR IGUAL A} \\
                              |&\quad   \text{FOR MAIOR OU IGUAL QUE} \\
                              |&\quad   \text{FOR MENOR OU IGUAL QUE} \\
                              |&\quad   \text{FOR DIFERENTE DE} \\
operador\,logico    \rightarrow&\quad   \text{E} \\
                              |&\quad   \text{OU} \\
\end{align}
$$
