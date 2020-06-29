install.packages("poliscidata")
install.packages("tidyverse")
library(tidyverse)
library(poliscidata)

library(ggplot2)
   library(dplyr)

install.packages("ggbeeswarm")
library(ggbeeswarm)

install.packages("scales")
library (scales)

# Utilizando o banco world do pacote poliscidata, faça um 
# histograma que também indique a média  e um boxplot 
# da variável gini10
# Descreva o que você pode observar a partir deles.
# R: É possível apontar uma diferença nos dois gráficos. No boxplot, a maior parte das observações
# registra GINI entre 39 e 47, com execção de uma, enquanto no histograma, situa as observações entre 40,05 e 40,150.

banco <- world %>%
   summarise(media_desigualdade = mean(gini10, na.rm = TRUE)) %>%
    
ggplot(banco, aes(media_desigualdade)) +
geom_histogram(color="white")
 
ggplot(world, aes(gini10))+
geom_boxplot()
         

# Utilizando as funções de manipulação de dados da aula passada,
# faça uma tabela que sumarize a media (função mean), 
# mediana (funcao median) e o desvio padrão (fundao sd) da 
# renda per capta (variável gdppcap08), agrupada por tipo de regime 
# (variável democ).


banco_mundial <- world  %>% 
select(democ, gdppcap08) %>% 
group_by(democ) %>%
summarise(mediaPerCapita = mean(gdppcap08, na.rm = TRUE),
          medianaPerCapita = median(gdppcap08, na.rm = TRUE),
          desvio = sd (gdppcap08, na.rm = TRUE)
            
          )


# Explique a diferença entre valores das médias e medianas.
# R: a divergência resulta da forma como as funções realizam os cálculos. Enquanto
# a mediana organiza os dados de forma crescente, de modo atenuar distorções, a média
# emprega os dados na ordem como estão dispostos, o que pode gerar um retrato não tão
# fiel da realidade. 

# Ilustre com a explicação com gráfico de boxplot.
# Os dados corroboram a hipótese da relação entre democracia
# e desempenho economico?
# R: Não. Pode-se constatar em todos os gráficos representados abaixo que a maioria das
# observações se situam à direta da mediana. Ou seja, regime não-democráticos também 
# apresentam alta renda per capita.

ggplot(banco_mundial, aes(mediaPerCapita)) +
geom_boxplot()

ggplot(banco_mundial, aes(medianaPerCapita)) +
geom_boxplot()

ggplot(world, aes(gdppcap08)) +
geom_boxplot()

# Carregue o banco states que está no pacote poliscidata 
# Mantenha apenas as variáveis obama2012, conpct_m, hs_or_more,
# prcapinc, blkpct10, south, religiosity3, state
?states

banco2 <- states %>%
select(obama2012, conpct_m, hs_or_more, prcapinc, blkpct10, south, religiosity3, state)

# Carregue o banco nes que está no pacote poliscidata
# Mantenha apenas as variáveis obama_vote, ftgr_cons, dem_educ3,
# income5, black, south, relig_imp, sample_state


banco3 <- nes %>%
select(obama_vote, ftgr_cons, dem_educ3, income5, black, south, relig_imp, sample_state)

# As variáveis medem os mesmos conceitos, voto no obama em 2012, 
# conservadorismo, educação, renda, cor, norte-sul, 
# religiosidade e estado. A diferença é que o nes é um banco de
# dados com surveys individuais e o states é um banco de dados
# com informações por estado
#
# Faça um gráfico para cada banco representando o nível de
# conservadorismo. Comente as conclusões que podemos ter
# a partir deles sobre o perfil do eleitorado estadunidense.
# Para ajudar, vocês podem ter mais informações sobre os bancos
# de dados digitando ?states e ?nes, para ter uma descrição das
# variáveis

ggplot(banco2, aes(conpct_m)) +
geom_density()
?states
ggplot(banco3, aes(ftgr_cons))+
geom_density()

# COMENTÁRIO: ambos os gráficos convegem em seus achados: a maior parcela da população
# norte-americana se situa no centro do espectro político. Esse constação é evidente 
# pelo maior adensamento dos dados no meio dos gráficos.


# Qual é o tipo de gráfico apropriado para descrever a variável
# de voto em obama nos dois bancos de dados?
# Justifique e elabore os gráficos

# R: Para o banco NES, a melhor opção é um gráfico de barras, já que os dados estão agrupados
# em dois conjuntos. Por outro lado, para o banco STATES, o histograma é a representação mais 
# adequada, porque a amostragem é maior. 

ggplot(banco3, aes(x = obama_vote, na.rm = TRUE)) +
geom_bar()  

ggplot(banco2, aes(obama2012)) +
geom_histogram(bins = 25, color = "white")

# Crie dois bancos de dados a partir do banco nes, um apenas com
# respondentes negros e outro com não-negros. A partir disso, faça
# dois gráficos com a proporção de votos no obama.
# O que você pode afirmar a partir dos gráficos?
# R: A variável raça influencia a escolha individual do eleitorado.  
# Você diria que existe uma relação entre voto em Obama e cor?
# R: Sim, a julgar pelo fato que negros votam macissamente  em Obama. 

voto_negro <- nes %>%
  select(obama_vote, dem_raceeth2) %>%
  filter(dem_raceeth2 == "Black")

ggplot(voto_negro, aes(obama_vote, na.rm = TRUE)) + geom_bar()
 

voto_branco <- nes %>%
   select(obama_vote, dem_raceeth2) %>%
   filter(dem_raceeth2 != "Black")

ggplot(voto_branco, aes(obama_vote, na.rm = TRUE)) + geom_bar()


# A partir do banco de dados states, faça uma comparação semelhante.
# Faça um gráfico com as porcentagens de votos em Obama para estados
# que estão acima da mediana da porcentagem de população negra nos estados,
# e outro gráfico com as porcentagens de votos em Obama para os estados
# que estão abaixo da mediana de população negra.
# O que você pode afirmar a partir dos gráficos?
# Podemos chegar a mesma conclusão anterior? R: não, porque mesmo em estados onde 
# a população negra fica abaixo da mediana, Obama obetve uma votação expressiva.
# Em alguns casos, até superior a 60%

states %>%
   
summarise(mediana_negros = median(blkpct10, na.rm = TRUE))


voto_racial1 <- states %>% 
select(obama2012, blkpct10, state) %>%
   filter(blkpct10>8.25)

ggplot(voto_racial1, aes(obama2012)) + 
   geom_histogram()

voto_racial2 <- states %>%
   select(obama2012, blkpct10, state) %>%
   filter(blkpct10<8.25)
   
ggplot(voto_racial2, obama2012) +
   geom_histogram()

# A partir da varíavel X do banco df abaixo
df <- data.frame(x = cos(seq(-50,50,0.5)))

ggplot(df, aes (x, "")) +
geom_beeswarm()


ggplot(df, aes(x,)) +
geom_boxplot()

# Faça os tipos de gráficos que representem esse tipo de variável
# comentando as diferenças entre elas e qual seria a mais adequada

# R: o gráfico mais dequado seria o do tipo beeswarm, porque ele mostra com maior precisão
# a distruibição das observações. Enquanto o modelo boxplot não consegue produzir um retrato tão
# fiel. 



# responsa as questões teóricas abaixo

# 1- instalidade regional (variável indep) ------- > democracia (variável depend)
# dispusta militarizadas (proxy)                  democracy Index ou/e Human Freedom Index$ 
# Hipótese: quanto mais dispustas militirazidas interestatais haver em uma região, menos democrática ela é

# 2 - Dois dos três banco mencionados estão diposníveis par acesso público: Military Interestated Disputes e CATO Humam Freedom Index

#   a) O Humam Freedom index reúne dados sobre a situação da liberdade humam em vários países do mundo
# anlisando-a a partir de dimensão civil, pessoal e econômica. 
#     b) O dataset contém dados de 2008 a 2017 e engloba 162 países.
#     c) Sim, porque emula um conceito amplo e abrangente de democracia que não se baseia somente em práticas
#        eleitorais, mas também direitos individuais. 
#     d) Penso que não seria necessário um melhoramento devido à abrangência já salientda do dataset.

# 3 - No que diz respeito à validade, o Index democracy e Humam Freedom Index conseguem expressear o cocneito teórico de democracial (dependente),
# pois, engloba a dimensão institucional e individual desse fenômemno.. Por outro lado, há limites na represenação da instabilidade regional 
# através de MID, porque este banco inclui apenas conflitos estatais, e em alguns casos atores não estatais
# são responsáveis por ondas de violência em eescala regional. Por sua vez, no que se refere à confibialidade, 
# outros bancos não mostrariam resultados muito divergentes. Na verdade, quanto se sobrepõem bancos sobre
# democracia ou liberdade, há uma semelhança considerável.

# 4 - Conforme o esquema da questão 1, a operacionalização seria da seguinte forma: a variável independente 
# teria como proxy as dispustas interestatais militarizaas, enquanto a variável dependente corresponderia
# empregaria o HUMAM FREEDOM index e Democratic Index

