
## Faça todos os gráficos utilizando um tema que você ache mais adequado
## e nomeie os eixos x e y da maneira adequada

## Carregue o banco world do pacote poliscidata

library(poliscidata)
library(tidyverse)
library(ggplot2)
library(ggthemes)
banco <- world

## Observe o banco de dados com as funções adequadas

glimpse (banco)
head (banco)
tail (banco)
str (banco)
summary (banco)


## A variável democ_regime08 indica se um país é democrático.
## Usando as ferramentas de manipulacao de bancos de dados, verifique
## quantos paises sao democraticos ou nao, e apresente esta variável 
## graficamente

banco %>% 
  count(democ_regime08)

ggplot(banco, aes(democ_regime)) +
geom_bar() + theme_classic() +
labs(title = "Divisão por regime",
     x = "o país é democrático ou não")

## Teste a relação entre a variável democ_regime08 e a variável
## muslim (que indica se um país é muçulmano ou não). E represente
## visualmente as variáveis para visualizar se esta religião
## aumenta ou diminui a chance de um país ser democrático
## Qual seria sua conclusão com relação a associação destas duas
## variáveis?

banco %>%
  chisq.test(banco$muslim, banco$democ_regime08 )

  ggplot(banco, aes(democ_regime08, fill = muslim)) +
  geom_bar(position = "fill") + 
  theme_classic()
    
# R: pode-se inferir que há uma relação entre as ambas as variáveis, considerando que
#    poucos países mulçumanos são democráticos. 


## A variável gdppcap08 possui informação sobre o PIB per capta
## dos países. Faça uma representação gráfica desta variável

banco %>% 
    count(gdppcap08)
    ggplot(banco, aes(gdppcap08)) +
    geom_histogram() + theme_clean() +
    labs(title = "Renda per capita", x = "valor da renda per capita")

## Faça um sumario com a média, mediana e desvio padrão do pib per capta
## para cada tipo de regime politico, represente a associação destas
## variáveis graficamente, e faça o teste estatístico adequado para
## chegar a uma conclusão. Existe associaçào entre as variáveis?

    
banco %>%
  group_by(democ_regime08) %>%
  summarise( 
        media = mean(gdppcap08, na.rm = TRUE), 
        mediana = median(gdppcap08, na.rm = TRUE), 
        desvio = sd(gdppcap08, na.rm = TRUE)
            
  ) %>%

ggplot(banco, aes(democ_regime08, gdppcap08)) +
         geom_boxplot() + theme_economist() +
        labs( title = "Correlação entre regime político e desenolvimento econômico",
             x ="regime democrático ou não",
               y = "renda per capita")

t.test(gdppcap08 ~ democ_regime08 , data = banco)

# R: Considerando o p-valor registrar um valor baixo, pode-se inferir que há uma
#    uma correlação entre as variáveis. 


## Por fim, ao invés de utilizar uma variável binária de democracia,
## utilize a variável dem_score14 para avaliar se existe uma associação
## entre regime político e desenvolvimento econômico. Represente
## a associação graficamente, faça o teste estatístico e explica sua
## conclusão


banco %>%

  ggplot(banco, aes(dem_score14, gdppcap08)) +
  geom_point(alpha = 0.4) +
  theme_clean() +
  labs( title = "Correlação entre regime político e desenolvimento econômico",
      x ="pontuação em termos de democracia",
      y = "renda per capita")

  cor.test(banco$dem_rank14, banco$gdppcap08)

# R: Verifica-se que há  um correlação entre a duas variáveis a julgar pelos 
#    resultados do teste. Há uma significância estástica inferior a 0,05. 
  
## Teste a associação entre renda perca capta e religiao (com a variável
## muslim) e represente graficamente. Qual é sua conclusão? 

banco %>%
  t.test(gdppcap08 ~ muslim, data = banco)
  boxplot(gdppcap08 ~ muslim, data = banco) + theme_clean()
  
# R: pode-se apontar que existe uma correlação entre as duas variáveis, visto que
# países mulçumanos registramuma renda per capita em média menor do que a média dos
# não mulçumanos 


## Comparando suas conclusões anteriores, é possível afirmar qual
## das duas variáveis possui maior impacto no desenvolvimento economico?
## Por que?
## R: a religião, porque considerando os resultados do p-valor, a significância
##    estatística da correlação entre religão e desenolvimento é maior do que aquela
##    registrado entre democracia e renda per capita. 



##########################################################################

## Exercício teórico
## Levando em consideração as variáveis de seu trabalho final,
## qual dos 3 testes estatísticos utilizados seria adequado utilizar?

# R: Dado que os bancos trabalham com variáveis contínuas, o mais adequado é usar 
#  o test r de pearson com a função cor.test