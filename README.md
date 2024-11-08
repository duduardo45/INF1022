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
## **Outra possível gramática:**

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
impressao   \rightarrow&\quad   \text{MOSTRE} \; var. \\
                      |&\quad   \text{MOSTRE} \; operacao. \\
operacao    \rightarrow&\quad   \text{SOME} \; var \; \text{COM} \; var \\ % talvez estes serem += 
                      |&\quad   \text{SOME} \; var \; \text{COM} \; num \\ % talvez criar um ADICIONE
                      |&\quad   \text{SOME} \; num \; \text{COM} \; num \\
                      |&\quad   \text{SOMA DE} \; var \; \text{COM} \; var \\ % e estes serem +
                      |&\quad   \text{SOMA DE} \; var \; \text{COM} \; num \\
                      |&\quad   \text{SOMA DE} \; num \; \text{COM} \; num \\
repeticao   \rightarrow&\quad   \text{REPITA} \;num \; \text{VEZES} \, : \, cmds \; \text{FIM} \\
condicional \rightarrow&\quad   \text{SE} \; condicao \; \text{ENTAO} \; cmds \; \text{FIM} \\
                      |&\quad   \text{SE} \; condicao \; \text{ENTAO} \; cmds \; \text{SENAO} \; cmds \; \text{FIM} \\
\end{align}
$$

___

### Regras menores da gramática

$$
\begin{align}
objeto              \rightarrow&\quad   num \\
                              |&\quad   var \\
condicao            \rightarrow&\quad   \text{NAO ACONTECER QUE} \; condicao\,nao\,nula \\
                              |&\quad   condicao\,nao\,nula \\
condicao\,nao\,nula \rightarrow&\quad   objeto \; compara \; objeto \\ % condicao não nula
                              |&\quad   objeto \; compara \; objeto \; operador\,logico \; condicao \\
compara             \rightarrow&\quad   \text{NAO FOR} \; comparador \\
                              |&\quad   \text{FOR} \; comparador \\
comparador          \rightarrow&\quad   \text{MAIOR QUE} \\
                              |&\quad   \text{MENOR QUE} \\
                              |&\quad   \text{IGUAL A} \\
                              |&\quad   \text{MAIOR OU IGUAL QUE} \\
                              |&\quad   \text{MENOR OU IGUAL QUE} \\
                              |&\quad   \text{DIFERENTE DE} \\
operador\,logico    \rightarrow&\quad
\end{align}
$$
