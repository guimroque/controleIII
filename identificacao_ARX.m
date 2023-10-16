// IDENTIFICACAO [ ARX - Exercicio exemplo ]


/*--------------------------[NORMALIZACAO]--------------------------*/
/*
    IMPORTACAO 
    - Ao importar os dados recebemos um 3 vetores [n]linhas x [1]col
        - Vetor Tempo contem o tempo de amostragem
*/
Tempo = e000; 
a = e1;
b = e2;

/*
    DEGRAU E VAZAO
    - Plotar um gráfico para diferenciar
        -  plot(Tempo,a,Tempo,b)
*/

Degrau = e1; // -> degrau
Vazao = e2; // -> vazao


/*
    REMOVER 1a POSICAO
    - Em space-states precisamos remover o primeiro item de amostra,
    porque a amostragem está sempre atrasada em zˆ-1 e a posicão zero nao tem um item anterior
*/
Degrau = Degrau - Degrau(1);
Vazao = Vazao - Vazao(1);


/*
    IDENTIFICAR ATRASO NA AMOSTRA
    - Plotar o gráfico, identificar quando o degrau inicia
    - N = x / t
        - N -> primeira amostra válida
        - x -> posicao do gráfico em x
        - t -> tempo de amostragem

    - Degrau -> remover 1as 29 posicoes
    - Vazao -> remover 1as 29 posicoes
    - Tempo -> remover ultimas 29 posicoes
*/
DegrauNorm = Degrau(29:end,1);
VazaoNorm = Vazao(29:end,1);
TempoNorm = Tempo(1:end-28,1);

/*--------------------------[NORMALIZACAO]--------------------------*/



/*--------------------------[IDENTIFICACAO]--------------------------*/


/*
    IDENTIFICAR ATRASO NA RESPOSTA
    - Plotar o gráfico, identificar quando o degrau inicia
    - k = x / t
        - k -> atraso, em x é quando o sistema comeca a responder
        - x -> posicao do gráfico em x
        - t -> tempo de amostragem
*/
k = 21;

/*
    MONTAR MATRIZ SS [space-state]
     
     Y  = a1y(k-1) + a2y(k-2) + bu(k-1)
    [Y] = [Y1(n-1) Y2(n-2) U1(n-1) ]  * [a1] 
                                        [a2]
                                        [b1]
*/
m = length(VazaoNorm);
while (k <= m)
   Y(k,1) = VazaoNorm(k);
   Psi(k,1) = VazaoNorm(k-1);
   Psi(k,2) = DegrauNorm(k-20);
   k = k + 1;  
end


/*
    EQUACAO SOLUCAO 
    - Theta = inv(Psi'*Psi)*Psi'*Y
    - Theta é um valor de duas posicoes para o exemplo
*/
Theta = inv(Psi'*Psi)*Psi'*Y;


/*--------------------------[IDENTIFICACAO]--------------------------*/



/*--------------------------[VALIDACAO]--------------------------*/

/*
    PLOTA RESULTADO
    - Usando os valores de theta para a equacao identificada
    - Plotar o grafico
    - Para o exemplo: 
        - atraso = 21 [k]
        - a1 = Theta(1)
        - b1 = Theta(2)
        - y = a1y(k-1) + bu(k-1)
*/
k = 21;
a1 = Theta(1);
b1 = Theta(2);
Ye(1:20,1) = 0;
while(k <= m)
    Ye(k,1) = a1*Ye(k-1,1) + b1*DegrauNorm(k-20,1);
    k = k +1;    
end

sysZ = tf(b1,[1 -a1],0.1,'InputDelay',20)
sysS = d2c(sysZ)

// -> plot
plot(TempoNorm,DegrauNorm,TempoNorm,VazaoNorm, TempoNorm,Ye,'g')
grid
/*--------------------------[VALIDACAO]--------------------------*/




