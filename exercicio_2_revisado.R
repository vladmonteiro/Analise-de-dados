install.packages("tidyverse")
library(tidyverse)
install.packages("poliscidata")
library(poliscidata)




# Suponha que tenhamos o dataframe df abaixo
#
# x     y
# A     5
# A     3
# B     8
# B    12
#
# Complete o c�digo que obt�m o seguinte resultado:
#
#        z
#        7
#

df %>%
summarise (z = mean(y))

#######################################################################

# Suponha que tenhamos o dataframe df abaixo
#
# y1    y2    y3    y4
# 8.04  9.14  7.46  6.58
# 6.95  8.14  6.77  5.76
# 7.58  8.74  12.74 7.71
#
# Complete o c�digo que obt�m o seguinte resultado:
#
# y1    
# 8.04  
# 6.95  
# 7.58  

df %>%
select(y1) 
  
#######################################################################

# Suponha que tenhamos o dataframe df abaixo
#
#    x  y
#   1  10
#   6  8
#   2  3
#   4  5
#
# Complete o c�digo que obt�m o seguinte resultado, fazendo uma opera��o
# entre x e y
#
#    x  y   z
#   1  10  -9
#   6  8   -2
#   2  3   -1
#   4  5   -1
#

df %>%
mutate (z = y[1:4]-x[1:4] )
  
########################################################################

#
# Suponha que tenhamos o dataframe df abaixo
#
#    city sales
# Boston   220
# Boston   125
#    NYC   150
#    NYC   250
#
# Complete o c�digo que obt�m o seguinte resultado:
#
# city   avg_sales
# Boston      172
# NYC         200 

df %>%
  group_by (city) %>%
  summarise(avg_sales = mean(sales))
  
########################################################################

# Suponha que tenhamos o dataframe df abaixo
#
#week   min   max
#  3    55    60
#  2    52    56
#  1    60    63
#  4    65    67
#
# Complete o c�digo que obt�m o seguinte resultado:
#
#week   min   max
#  1    60    63
#  2    52    56
#  3    55    60
#  4    65    67

df %>%
 arrage (week) %>%

########################################################################

# Suponha que tenhamos o dataframe df abaixo
#
# x_b_1  x_b_2  y_c_1  y_c_2
#  A      2      W1     25
#  A      4      W2     21
#  B      6      W1     26
#  B      8      W2     30
#
# Complete o c�digo que obt�m o seguinte resultado:
#
# y_c_1  y_c_2
#  W1     25
#  W2     21
#  W1     26
#  W2     30

df %>%
select(-x_b_1, -x_b_2) %>%

#########################################################################
  
# Suponha que tenhamos o dataframe df abaixo
#
# Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
# 78           6.7         3.0          5.0         1.7 versicolor
# 121          6.9         3.2          5.7         2.3  virginica
# 11           5.4         3.7          1.5         0.2     setosa
# 92           6.1         3.0          4.6         1.4 versicolor
# 146          6.7         3.0          5.2         2.3  virginica
# 62           5.9         3.0          4.2         1.5 versicolor
# 50           5.0         3.3          1.4         0.2     setosa
# 17           5.4         3.9          1.3         0.4     setosa
# 69           6.2         2.2          4.5         1.5 versicolor
# 143          5.8         2.7          5.1         1.9  virginica
#
# Complete o c�digo que obt�m o seguinte resultado:
#
#Species      Sepal.Area
#versicolor      20.10
#virginica       22.08
#setosa          19.98
#versicolor      18.30
#virginica       20.10
#versicolor      17.70
#setosa          16.50
#setosa          21.06
#versicolor      13.64
#virginica      15.66


df %>%
  group_by (Species) %>%
  summarise (Sepal.Area = Sepal.Widith*Sepal.Length) %>%

########################################################################

# Suponha que tenhamos o dataframe df abaixo
#
#name         start       end         party     
#Eisenhower   1953-01-20  1961-01-20  Republican
#Kennedy      1961-01-20  1963-11-22  Democratic
#Johnson      1963-11-22  1969-01-20  Democratic
#Nixon        1969-01-20  1974-08-09  Republican
#Ford         1974-08-09  1977-01-20  Republican
#Carter       1977-01-20  1981-01-20  Democratic
#Reagan       1981-01-20  1989-01-20  Republican
#Bush         1989-01-20  1993-01-20  Republican
#Clinton      1993-01-20  2001-01-20  Democratic
#Bush         2001-01-20  2009-01-20  Republican
#Obama        2009-01-20  2017-01-20  Democratic
#
#Crie um c�digo abaixo para que se altere a vari�vel party
#deixando apenas a primeira letra dos partidos

df %>%
  mutate (party = recode (party, 
                          Republican ="R"
                          Democratic ="D")) 

###############################################################################

# No pacote poliscidata existe um banco de dados chamado nes, com informa��es 
# do American National Election Survey. Para os exer�cicios a seguir, instale 
# o pacote poliscidata e tidyverse, carregue-os e crie um objeto chamado
# df com os dados do nes. 

banco <- nes


# Fa�a uma primeira explora��o do banco de dados com todos os comandos
# passados at� aqui que possuem esse objetivo
head (nes)
tail (nes)
str (nes)
summary (nes)

 
# Quantos respondentes possui na pesquisa?
#  5916

# Caso queiram ter mais informa��es sobre as vari�veis do nes, basta rodar
# o c�digo `?nes`, que no canto inferior direito aparecer� uma descri��o.
# Como temos muitas vari�veis, deixe apenas as colunas
# ftgr_cons, dem_raceeth, voted2012, science_use, preknow3, obama_vote
# income5, gender.

b1 <- nes %>%
    select (ftgr_cons, dem_raceeth, voted2012, science_use, preknow3, obama_vote, income5, gender)




# Se quisermos ter informa��es apenas de pessoas que votaram na
# elei��o de 2012, podemos usar a vari�vel voted2012. Tire do banco
# os respondentes que n�o votaram

b2 <- b1 %>%
    filter (voted2012 == "Voted")
    glimpse(b2)
    
# Quantos respondentes sobraram?
#    4.404


# Crie uma vari�vel chamada white que indica se o respondente � branco
# ou n�o a partir da vari�vel dem_raceeth, crie a vari�vel ideology a
# partir da vari�vel ftgr_cons (0-33 como liberal, 34 a 66 como centro,
# e 67 a 100 como conservador), ao mesmo tempo em que muda
# a vari�vel obama_vote para trocar o 1 por "Sim" e 2 por "n�o"


b3 <-b2 %>% 
  select(dem_raceeth)  %>%
  fator_ordenado <- factor (dem_raceeth, ordered = TRUE, levels =  c("SIM", "N�O", "N�O","N�O"))
  
  transmute (dem_raceeth, voted2012, science_use, preknow3, income5, gender,
         
               
         white = recode(dem_raceeth, factor_ordenado),
              
         ideology = case_when ( ftgr_cons >= 0 & ftgr_cons <= 33 ~ "liberal",
                           ftgr_cons >= 34 & ftgr_cons <= 66 ~ "centro",
                           ftgr_cons >= 67 & ftgr_cons <= 100 ~ "conservador"),
           
             
          obama_vote = case_when (obama_vote == 0 ~ "N�o",
                                      obama_vote == 1 ~ "Sim")) 


glimpse(b3)


 

# Demonstre como observar a quantidade de pessoas em cada uma das
# categorias de science_use
 
obsv_1 <- segundo_banco %>%
      count (science_use)

      glimpse(obsv_1)


# Demonstre como observar a m�dia de conservadorismo (vari�vel 
# ftgr_cons) para cada categoria de science_use

obsv_2 <- segundo_banco %>%
    group_by (science_use) %>%
    summarise (media = mean(ftgr_cons, na.rm = T))
    
###############################################################################

# Responder as quest�es te�ricas da aula abaixo



#1) Como n�o h� uma literatura espec�fica sobre o problema que pretendo abordar, escolhi uma obra de uma agenda 
#   de pesquisa que se aproxima com o tema. O texto � de Jennifer Brauner e se intitula Military Spending and Democracy
#   A proposta da autora � mostrar empiricamente se democracias registram maiores gastos em defesa do que autocracias.
#   Analisando dados de 112 pa�se, numa escala de tempora que vai de 1960 a 2000, ela chega a conclus�o que o regime pol�tica
#   influencia de fato no volume de gastos, ou seja, democracias gastam menos. 
#   1- democracias gastam mais em defesa do que autocracias?
#   2- o arcabou�o te�rico do trabalho se baseia na tese da paz democr�tica. O argumento central postula que regimes desse tipo gastam menos com defesa
#   3- O desenho de pesquisa se estrutura como um estudo de caso de N grande, empregando m�todos quantitativos para testar a hip�tese. 
#   4- O trabalho consegue mostrar a robustez da causalidade, mas falha em apontar se outras vari�veis podem influenciar no resultado.
#   5- a conclus�o j� foi mencionada 
#   6- Minha pesquisa pode ampliar o alcance da agenda ao acrescentar a vari�vel externa na causalidade. A partir dela, consigo elaobrar um mencanismo
#   de causalidade mais amplo entre gastos em defesa e democracia.  
#2) A instabilidade no ambiente regional inibe a democratiza��o?
#3) 3.1 A proposta do trabalho � explicar o processo democr�tico a partir das condi��es estruturantes do ambiente 
#   externo em um dada regi�o geogr�fica. Argumento que dispusta e conflitos em regi�o constrage a possibilide a mudan�a 
#   de regime. O porqu� est� no efeito dessas vari�veis para as institui��es internas. A prote��o contra a  
#   a instibilidade externa incentiva volumosos gastos em defesa. Esse processo significa tamb�m a retirada de recursos 
#   de outras �reas (educa��o, sa�de etc). Logo, em um arranjo instituicional n�o-democr�tico, um l�der pode o fazer
#   sem enfrentar contrangimentos do tipo "chekcs and balance". Nesse sentido, haveria menor incentivos para ele promover 
#   reformas liberais.
#   3.2 N�o se pode deixar de considerar que haja um causalidade inversa. H� uma vasta produ��o acad�mcia 
#   sobre a tese da paz democr�tica. Nesse cso, regimes desse tipo n�o entram em conflito entre eles. 
#   Sob essa �tica, a estabilidade regional emanaria da configura��o institucional interna dos pa�ses.
#   O contr�rio tamb�m seria verdadeiro, ou seja, a causa da volatilidade no ambiente externo residiria
#   na preval�ncia de regimes autocr�ticos. 
#   3.3 Analisando os dois bancos de dados mencionados no exer�cios anterior, � poss�vel identificar que os 
#   dados sobre liberdade e democrcias apresentam os valores mais baixos em �reas marcadas por dispustas
#   militarizadas, a exemplo do Oriente M�dio, onde se registra um alto gasto em defesa. Sendo assim, pode-se
#   apontar uma covaria��o.
#   - Em resumo, o trabalho consegue apresentar potencial em alguns pontos, mas falhas em outros. Enquanto 
#   a quest�o de pesquisa � pertinente e interessante, h� dificuldes na articula��o entres vari�veis, principalmente
#   na elabora��o do mecanismo causal. 
