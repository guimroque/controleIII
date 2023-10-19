// IDENTIFICACAO [ SMITH - Exercicio exemplo ]


/*--------------------------[NORMALIZACAO]--------------------------*/
/*
    IMPORTACAO 
    - Ao importar os dados recebemos um 2 matrizes [2]linhas x [n]col
        - Não existe um valor exclusivo de tempo
        - Cada arquivo possui uma linha tempo
*/
Tempo = TARGET_DATA____Program_Degrau(1,:);
Degrau = TARGET_DATA____Program_Degrau(2,:);
Temperatura = TARGET_DATA____Program_Temperatura(2,:);

// -> remover soma de todas as temperaturas em y [trazer a funcao para a origem em zero]
Temp = Temperatura - Temperatura(1);

/*--------------------------[NORMALIZACAO]--------------------------*/

/*--------------------------[IDENTIFICACAO]--------------------------*/
/*
    ENCONTRAR theta e tal
    - theta: 1.3*t1_su - 0.29*t2_su [The_su] -> atraso de transporte
    - tal: 0.67*(t2_su - s1_su) [Tau_su] -> constante de tempo do sistema
        - Não existe um valor exclusivo de tempo
        - Cada arquivo possui uma linha tempo
        - K -> ganho do sistema [valor final do sinal/valor do degrau de entrada]
        - Temp_f -> valor final da temperatura
        - t1_su -> identificar o instante de tempo que o sinal vale 0.353 do ganho
        - t2_su -> identificar o instante de tempo que o sinal vale 0.853 do ganho
*/
Temp_f = Temp(1,end);

K = Temp_f/Degrau(1,end);


m = length(Temp);
i = 1;
while(i < m)    
    if (Temp(i) >= (0.283*Temp_f))
       t1_su = Tempo(i);
       break;
    end
    i = i + 1;
end 
i = 1;
while(i < m)    
    if (Temp(i) >= (0.632*Temp_f))
       t2_su = Tempo(i);
       break;
    end
    i = i + 1;
end


Tau_su = 1.5*(t2_su - t1_su);
The_su = t2_su - Thau_su;
/*--------------------------[IDENTIFICACAO]--------------------------*/


/*--------------------------[VALIDACAO]--------------------------*/
/*
    EQUACIONAR FCT
    - G_su =        K
                   ----         * eˆThe_su
                (Tau_su*s + 1)
*/
G_su = tf(K,[Tau_su 1],'InputDelay',The_su)

Temp_su = step(G_su,Tempo)
Temp_su = Temp_su*Degrau(1,end);
Temp_su = Temp_su(1:end-1,1)
plot(Tempo,Temp,Tempo,Temp_su,'r')

// -> matriz inversa apenas porque elas precisam ter as mesmas dimensoes (linas x colunas)
Temp_su = Temp_su';
EQM_su = sqrt(mean((Temp - Temp_su).^2))

/*--------------------------[VALIDACAO]--------------------------*/











