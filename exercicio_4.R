
## Fa�a todos os gr�ficos utilizando um tema que voc� ache mais adequado
## e nomeie os eixos x e y da maneira adequada

## Carregue o banco world do pacote poliscidata

library(poliscidata)
library(tidyverse)
library(ggplot2)
library(ggthemes)
banco <- world

## Observe o banco de dados com as fun��es adequadas

glimpse (banco)
head (banco)
tail (banco)
str (banco)
summary (banco)


## A vari�vel democ_regime08 indica se um pa�s � democr�tico.
## Usando as ferramentas de manipulacao de bancos de dados, verifique
## quantos paises sao democraticos ou nao, e apresente esta vari�vel 
## graficamente

banco %>% 
  count(democ_regime08)

ggplot(banco, aes(democ_regime)) +
geom_bar() + theme_classic() +
labs(title = "Divis�o por regime",
     x = "o pa�s � democr�tico ou n�o")

## Teste a rela��o entre a vari�vel democ_regime08 e a vari�vel
## muslim (que indica se um pa�s � mu�ulmano ou n�o). E represente
## visualmente as vari�veis para visualizar se esta religi�o
## aumenta ou diminui a chance de um pa�s ser democr�tico
## Qual seria sua conclus�o com rela��o a associa��o destas duas
## vari�veis?

banco %>%
  chisq.test(banco$muslim, banco$democ_regime08 )

  ggplot(banco, aes(democ_regime08, fill = muslim)) +
  geom_bar(position = "fill") + 
  theme_classic()
    
# R: pode-se inferir que h� uma rela��o entre as ambas as vari�veis, considerando que
#    poucos pa�ses mul�umanos s�o democr�ticos. 


## A vari�vel gdppcap08 possui informa��o sobre o PIB per capta
## dos pa�ses. Fa�a uma representa��o gr�fica desta vari�vel

banco %>% 
    count(gdppcap08)
    ggplot(banco, aes(gdppcap08)) +
    geom_histogram() + theme_clean() +
    labs(title = "Renda per capita", x = "valor da renda per capita")

## Fa�a um sumario com a m�dia, mediana e desvio padr�o do pib per capta
## para cada tipo de regime politico, represente a associa��o destas
## vari�veis graficamente, e fa�a o teste estat�stico adequado para
## chegar a uma conclus�o. Existe associa��o entre as vari�veis?

    
banco %>%
  group_by(democ_regime08) %>%
  summarise( 
        media = mean(gdppcap08, na.rm = TRUE), 
        mediana = median(gdppcap08, na.rm = TRUE), 
        desvio = sd(gdppcap08, na.rm = TRUE)
            
  ) %>%

ggplot(banco, aes(democ_regime08, gdppcap08)) +
         geom_boxplot() + theme_economist() +
        labs( title = "Correla��o entre regime pol�tico e desenolvimento econ�mico",
             x ="regime democr�tico ou n�o",
               y = "renda per capita")

t.test(gdppcap08 ~ democ_regime08 , data = banco)

# R: Considerando o p-valor registrar um valor baixo, pode-se inferir que h� uma
#    uma correla��o entre as vari�veis. 


## Por fim, ao inv�s de utilizar uma vari�vel bin�ria de democracia,
## utilize a vari�vel dem_score14 para avaliar se existe uma associa��o
## entre regime pol�tico e desenvolvimento econ�mico. Represente
## a associa��o graficamente, fa�a o teste estat�stico e explica sua
## conclus�o


banco %>%

  ggplot(banco, aes(dem_score14, gdppcap08)) +
  geom_point(alpha = 0.4) +
  theme_clean() +
  labs( title = "Correla��o entre regime pol�tico e desenolvimento econ�mico",
      x ="pontua��o em termos de democracia",
      y = "renda per capita")

  cor.test(banco$dem_rank14, banco$gdppcap08)

# R: Verifica-se que h�  um correla��o entre a duas vari�veis a julgar pelos 
#    resultados do teste. H� uma signific�ncia est�stica inferior a 0,05. 
  
## Teste a associa��o entre renda perca capta e religiao (com a vari�vel
## muslim) e represente graficamente. Qual � sua conclus�o? 

banco %>%
  t.test(gdppcap08 ~ muslim, data = banco)
  boxplot(gdppcap08 ~ muslim, data = banco) + theme_clean()
  
# R: pode-se apontar que existe uma correla��o entre as duas vari�veis, visto que
# pa�ses mul�umanos registramuma renda per capita em m�dia menor do que a m�dia dos
# n�o mul�umanos 


## Comparando suas conclus�es anteriores, � poss�vel afirmar qual
## das duas vari�veis possui maior impacto no desenvolvimento economico?
## Por que?
## R: a religi�o, porque considerando os resultados do p-valor, a signific�ncia
##    estat�stica da correla��o entre relig�o e desenolvimento � maior do que aquela
##    registrado entre democracia e renda per capita. 



##########################################################################

## Exerc�cio te�rico
## Levando em considera��o as vari�veis de seu trabalho final,
## qual dos 3 testes estat�sticos utilizados seria adequado utilizar?

# R: Dado que os bancos trabalham com vari�veis cont�nuas, o mais adequado � usar 
#  o test r de pearson com a fun��o cor.test