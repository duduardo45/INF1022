# INF1022 Analisadores Léxico e Sintáticos

Repositório para o trabalho da matéria da PUC-Rio, tema tradução de arquivos .mag (linguagem com intuito para matemática) chamada matemágica


## Gramática suposta para esta implementação do analisador .mag

$$\begin{align}
programa    \rightarrow&\quad   cmds \\
cmds        \rightarrow&\quad   cmd\;cmds  \\
                      |&\quad   cmd \\
cmd         \rightarrow&\quad   atribuicao \\
                      |&\quad   impressao \\
                      |&\quad   operacao \\
                      |&\quad   repeticao \\
atribuicao  \rightarrow&\quad   \text{FACA}\;var\;\text{SER}\;num. \\
impressao   \rightarrow&\quad   \text{MOSTRE}\;var. \\
                      |&\quad   \text{MOSTRE}\;operacao. \\
operacao    \rightarrow&\quad   \text{SOME}\;var\;\text{COM}\;var. \\
                      |&\quad   \text{SOME}\;var\;\text{COM}\;num. \\
                      |&\quad   \text{SOME}\;num\;\text{COM}\;num. \\
repeticao   \rightarrow&\quad   \text{REPITA}\;num\;\text{VEZES}\;:\;cmds\;\text{FIM} \\
\end{align}
$$