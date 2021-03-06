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

# Utilizando o banco world do pacote poliscidata, fa�a um 
# histograma que tamb�m indique a m�dia  e um boxplot 
# da vari�vel gini10
# Descreva o que voc� pode observar a partir deles.
# R: � poss�vel apontar uma diferen�a nos dois gr�ficos. No boxplot, a maior parte das observa��es
# registra GINI entre 39 e 47, com exec��o de uma, enquanto no histograma, situa as observa��es entre 40,05 e 40,150.

banco <- world %>%
   summarise(media_desigualdade = mean(gini10, na.rm = TRUE)) %>%
    
ggplot(banco, aes(media_desigualdade)) +
geom_histogram(color="white")
 
ggplot(world, aes(gini10))+
geom_boxplot()
         

# Utilizando as fun��es de manipula��o de dados da aula passada,
# fa�a uma tabela que sumarize a media (fun��o mean), 
# mediana (funcao median) e o desvio padr�o (fundao sd) da 
# renda per capta (vari�vel gdppcap08), agrupada por tipo de regime 
# (vari�vel democ).


banco_mundial <- world  %>% 
select(democ, gdppcap08) %>% 
group_by(democ) %>%
summarise(mediaPerCapita = mean(gdppcap08, na.rm = TRUE),
          medianaPerCapita = median(gdppcap08, na.rm = TRUE),
          desvio = sd (gdppcap08, na.rm = TRUE)
            
          )


# Explique a diferen�a entre valores das m�dias e medianas.
# R: a diverg�ncia resulta da forma como as fun��es realizam os c�lculos. Enquanto
# a mediana organiza os dados de forma crescente, de modo atenuar distor��es, a m�dia
# emprega os dados na ordem como est�o dispostos, o que pode gerar um retrato n�o t�o
# fiel da realidade. 

# Ilustre com a explica��o com gr�fico de boxplot.
# Os dados corroboram a hip�tese da rela��o entre democracia
# e desempenho economico?
# R: N�o. Pode-se constatar em todos os gr�ficos representados abaixo que a maioria das
# observa��es se situam � direta da mediana. Ou seja, regime n�o-democr�ticos tamb�m 
# apresentam alta renda per capita.

ggplot(banco_mundial, aes(mediaPerCapita)) +
geom_boxplot()

ggplot(banco_mundial, aes(medianaPerCapita)) +
geom_boxplot()

ggplot(world, aes(gdppcap08)) +
geom_boxplot()

# Carregue o banco states que est� no pacote poliscidata 
# Mantenha apenas as vari�veis obama2012, conpct_m, hs_or_more,
# prcapinc, blkpct10, south, religiosity3, state
?states

banco2 <- states %>%
select(obama2012, conpct_m, hs_or_more, prcapinc, blkpct10, south, religiosity3, state)

# Carregue o banco nes que est� no pacote poliscidata
# Mantenha apenas as vari�veis obama_vote, ftgr_cons, dem_educ3,
# income5, black, south, relig_imp, sample_state


banco3 <- nes %>%
select(obama_vote, ftgr_cons, dem_educ3, income5, black, south, relig_imp, sample_state)

# As vari�veis medem os mesmos conceitos, voto no obama em 2012, 
# conservadorismo, educa��o, renda, cor, norte-sul, 
# religiosidade e estado. A diferen�a � que o nes � um banco de
# dados com surveys individuais e o states � um banco de dados
# com informa��es por estado
#
# Fa�a um gr�fico para cada banco representando o n�vel de
# conservadorismo. Comente as conclus�es que podemos ter
# a partir deles sobre o perfil do eleitorado estadunidense.
# Para ajudar, voc�s podem ter mais informa��es sobre os bancos
# de dados digitando ?states e ?nes, para ter uma descri��o das
# vari�veis

ggplot(banco2, aes(conpct_m)) +
geom_density()
?states
ggplot(banco3, aes(ftgr_cons))+
geom_density()

# COMENT�RIO: ambos os gr�ficos convegem em seus achados: a maior parcela da popula��o
# norte-americana se situa no centro do espectro pol�tico. Esse consta��o � evidente 
# pelo maior adensamento dos dados no meio dos gr�ficos.


# Qual � o tipo de gr�fico apropriado para descrever a vari�vel
# de voto em obama nos dois bancos de dados?
# Justifique e elabore os gr�ficos

# R: Para o banco NES, a melhor op��o � um gr�fico de barras, j� que os dados est�o agrupados
# em dois conjuntos. Por outro lado, para o banco STATES, o histograma � a representa��o mais 
# adequada, porque a amostragem � maior. 

ggplot(banco3, aes(x = obama_vote, na.rm = TRUE)) +
geom_bar()  

ggplot(banco2, aes(obama2012)) +
geom_histogram(bins = 25, color = "white")

# Crie dois bancos de dados a partir do banco nes, um apenas com
# respondentes negros e outro com n�o-negros. A partir disso, fa�a
# dois gr�ficos com a propor��o de votos no obama.
# O que voc� pode afirmar a partir dos gr�ficos?
# R: A vari�vel ra�a influencia a escolha individual do eleitorado.  
# Voc� diria que existe uma rela��o entre voto em Obama e cor?
# R: Sim, a julgar pelo fato que negros votam macissamente  em Obama. 

voto_negro <- nes %>%
  select(obama_vote, dem_raceeth2) %>%
  filter(dem_raceeth2 == "Black")

ggplot(voto_negro, aes(obama_vote, na.rm = TRUE)) + geom_bar()
 

voto_branco <- nes %>%
   select(obama_vote, dem_raceeth2) %>%
   filter(dem_raceeth2 != "Black")

ggplot(voto_branco, aes(obama_vote, na.rm = TRUE)) + geom_bar()


# A partir do banco de dados states, fa�a uma compara��o semelhante.
# Fa�a um gr�fico com as porcentagens de votos em Obama para estados
# que est�o acima da mediana da porcentagem de popula��o negra nos estados,
# e outro gr�fico com as porcentagens de votos em Obama para os estados
# que est�o abaixo da mediana de popula��o negra.
# O que voc� pode afirmar a partir dos gr�ficos?
# Podemos chegar a mesma conclus�o anterior? R: n�o, porque mesmo em estados onde 
# a popula��o negra fica abaixo da mediana, Obama obetve uma vota��o expressiva.
# Em alguns casos, at� superior a 60%

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

# A partir da var�avel X do banco df abaixo
df <- data.frame(x = cos(seq(-50,50,0.5)))

ggplot(df, aes (x, "")) +
geom_beeswarm()


ggplot(df, aes(x,)) +
geom_boxplot()

# Fa�a os tipos de gr�ficos que representem esse tipo de vari�vel
# comentando as diferen�as entre elas e qual seria a mais adequada

# R: o gr�fico mais dequado seria o do tipo beeswarm, porque ele mostra com maior precis�o
# a distruibi��o das observa��es. Enquanto o modelo boxplot n�o consegue produzir um retrato t�o
# fiel. 



# responsa as quest�es te�ricas abaixo

# 1- instalidade regional (vari�vel indep) ------- > democracia (vari�vel depend)
# dispusta militarizadas (proxy)                  democracy Index ou/e Human Freedom Index$ 
# Hip�tese: quanto mais dispustas militirazidas interestatais haver em uma regi�o, menos democr�tica ela �

# 2 - Dois dos tr�s banco mencionados est�o diposn�veis par acesso p�blico: Military Interestated Disputes e CATO Humam Freedom Index

#   a) O Humam Freedom index re�ne dados sobre a situa��o da liberdade humam em v�rios pa�ses do mundo
# anlisando-a a partir de dimens�o civil, pessoal e econ�mica. 
#     b) O dataset cont�m dados de 2008 a 2017 e engloba 162 pa�ses.
#     c) Sim, porque emula um conceito amplo e abrangente de democracia que n�o se baseia somente em pr�ticas
#        eleitorais, mas tamb�m direitos individuais. 
#     d) Penso que n�o seria necess�rio um melhoramento devido � abrang�ncia j� salientda do dataset.

# 3 - No que diz respeito � validade, o Index democracy e Humam Freedom Index conseguem expressear o cocneito te�rico de democracial (dependente),
# pois, engloba a dimens�o institucional e individual desse fen�memno.. Por outro lado, h� limites na represena��o da instabilidade regional 
# atrav�s de MID, porque este banco inclui apenas conflitos estatais, e em alguns casos atores n�o estatais
# s�o respons�veis por ondas de viol�ncia em eescala regional. Por sua vez, no que se refere � confibialidade, 
# outros bancos n�o mostrariam resultados muito divergentes. Na verdade, quanto se sobrep�em bancos sobre
# democracia ou liberdade, h� uma semelhan�a consider�vel.

# 4 - Conforme o esquema da quest�o 1, a operacionaliza��o seria da seguinte forma: a vari�vel independente 
# teria como proxy as dispustas interestatais militarizaas, enquanto a vari�vel dependente corresponderia
# empregaria o HUMAM FREEDOM index e Democratic Index

