Exercicio 5
================
Vlademir

### Carregue o banco de dados `world` que está no pacote `poliscidata`.

``` r
library(tidyverse)
```

    ## -- Attaching packages ------------------------------------------- tidyverse 1.3.0 --

    ## v ggplot2 3.3.2     v purrr   0.3.4
    ## v tibble  3.0.1     v dplyr   1.0.0
    ## v tidyr   1.1.0     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.5.0

    ## -- Conflicts ---------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(poliscidata)
library(ggplot2)
```

banco \<- world

### Existem diversas medidas de democracia para os países: `dem_score14`, `democ11`, `fhrate04_rev`, `fhrate08_rev`, `polity`. Descreva-as graficamente e diga quais são as diferenças entre tais medidas.

banco %\>%

select (dem\_score14, democ11, fhrate04\_rev, fhrate08\_rev, polity)

ggplot(banco, aes (dem\_score14)) + geom\_boxplot()

ggplot(banco, aes (democ11)) + geom\_bar()

ggplot(banco, aes (fhrate04\_rev)) + geom\_bar()

ggplot(banco, aes (fhrate08\_rev)) + geom\_bar()

ggplot(banco, aes (polity)) + geom\_bar()

?world

\#R com execeção de dem\_score14, todas as demais são escalas fixas que
variam em intervalo específico.

### Avalie a relação entre todas as medidas de democracia e desigualdade, utilizando a variável `gini08`. Descreva graficamente esta variável, a relação entre as duas variáveis, meça a correlação entre elas e faça regressões lineares (interpretando em profundidade os resultados dos coeficientes e medidas de desempenho dos modelos). Enfatize as semelhanças e diferenças entre os resultados. Quais são suas conclusões?

banco %\>% select (dem\_score14, democ11, fhrate04\_rev, fhrate08\_rev,
polity, gini08)

ggplot(banco, aes(gini08))+ geom\_boxplot()

cor.test(banco\(gini08, banco\)dem\_score14) ggplot(banco, aes (gini08,
dem\_score14)) + geom\_point(alpha=0.5) + geom\_smooth (method = “lm”)

regression \<- lm(dem\_score14 \~ gini08, data = banco)
summary(regression)

# Comentário: variação positiva no Gini impacta de forma negativa a democracia. Ou seja com base nos coeficientes registrada, uma acréscimo de uma unidade em gini08 significa uma récuo de 0,04 em dem\_score14

cor.test(banco\(gini08, banco\)democ11) ggplot(banco, aes (gini08,
democ11)) + geom\_point(alpha=0.5) + geom\_smooth (method = “lm”)

regression1 \<- lm(democ11 \~ gini08, data = banco) summary(regression1)

\#Comentário: permanace o mesmo tipo de relação verificado no comentário
anterior. Há uma direção negativa entre as duas variáveis. Porém, o
impacto da desigualade é menor. Nota-se que pelos coeficiente que um
acréscimo do GINI impõe um déscrecimo de 0,02 em democ11

cor.test(banco\(gini08, banco\)fhrated04\_rev) ggplot(banco, aes
(gini08, fhrate04\_rev)) + geom\_point() + geom\_smooth (method=“lm”)

regression2 \<- lm(fhrated04\_rev \~ gini08, data = banco)
summary(regression2)

cor.test(banco\(fhrated08, banco\)gini08) ggplot(banco, aes (gini08,
fhrate08\_rev)) + geom\_point(alpha=0.5) + geom\_smooth (method = “lm”)

regression3 \<- lm(fhrated08\_rev \~ gini08, data = banco)
summary(regression3)

cor.test(banco\(polity, banco\)gini08) ggplot(banco, aes (gini08,
polity)) + geom\_point(alpha=0.5) + geom\_smooth (method = “lm”)

regression4 \<- lm(polity \~ gini08, data = banco) summary(regression4)

\#Comentário: em geral, os coeficientes registram a mesma tendência das
regressões anteriores. A diferência reside nos valores e na
significância estatística.

### Avalie a relação entre todas as medidas de democracia e crescimento econômico, utilizando a variável `gdppcap08`. Descreva graficamente esta variável, a relação entre as duas variáveis, meça a correlação entre elas e faça regressões lineares (interpretando em profundidade os resultados dos coeficientes e medidas de desempenho dos modelos). Enfatize as semelhanças e diferenças entre os resultados. Quais são suas conclusões?

banco %\>% select (dem\_score14, democ11, fhrate04\_rev, fhrate08\_rev,
polity, gdppcap08)

ggplot(banco, aes(gdppcap08)) + geom\_boxplot()

cor.test(banco\(gdppcap08, banco\)dem\_score14) ggplot(banco, aes
(gdppcap08, dem\_score14)) + geom\_point(alpha=0.5) + geom\_smooth
(method = “lm”)

rgr \<- lm(dem\_score14 \~ gdppcap08, data = banco) summary(rgr)

\#Comentário: constata-se uma direção positiva na variação entre as duas
variáveis. Em outras palavras, cada elevação no crescimento econômica
aumenta em 7,04 elavada a 5 o dem\_score14. Importante que há uma
significância estatística elevada a julgar pelo p-valor

cor.test(banco\(democ11, banco\)gini08) ggplot(banco, aes (democ11,
gdppcap08)) + geom\_point(alpha=0.5) + geom\_smooth (method = “lm”)

rgr0 \<- lm(democ11 \~gdppcap08, data = banco) summary(rgr0)

cor.test(banco\(fhrated04, banco\)gini08) ggplot(banco, aes
(factor(fhrate04\_rev), gini08)) + geom\_boxplot() + geom\_smooth
(method=“lm”)

rgr1 \<- lm(fhrate04\_rev \~ gdppcap08, data = banco) summary(rgr1)

\#A diferença dos resultados dessa regressão para as anteriores se
encontram no coeficiente da variável x: o valor de seu impacto é menor
do que os anteriores. Ainda assim, se conversa a direção positiva.

cor.test(banco\(fhrated08, banco\)gini08) ggplot(banco, aes
(fhrate08\_rev, gini08)) + geom\_point(alpha=0.5) + geom\_smooth (method
= “lm”)

rgr2 \<- lm(fhrate08\_rev \~ gdppcap08, data = banco) summary(rgr2)

\#Nesse caso, o impacto em termos de valor é ainda menor, devido ao
coeficiente ser menor do que os registrados anteirormente.

cor.test(banco\(polity, banco\)gini08) ggplot(banco, aes (polity,
gini08)) + geom\_point(alpha=0.5) + geom\_smooth (method = “lm”)

rgr3 \<- lm(polity \~ gdppcap08, data = banco) summary(rgr3)

# Comentário: em resumo, há uma direção positiva entre as duas variáveis. A diferenção entre as regressões rodadas reside no coeficientes. Em alguns exemplos, o gdppcap008 apresenta um valor maior, portanto seu impacto também é dimensionado nessa proporção. A signicância em todos os casos é alta.

### Avalie a relação entre todas as medidas de democracia e produção de petróleo, utilizando a variável `oil`. Descreva graficamente esta variável, a relação entre as duas variáveis, meça a correlação entre elas e faça regressões lineares (interpretando em profundidade os resultados dos coeficientes e medidas de desempenho dos modelos). Enfatize as semelhanças e diferenças entre os resultados. Quais são suas conclusões?

banco %\>% select (dem\_score14, democ11, fhrate04\_rev, fhrate08\_rev,
polity, oil)

ggplot(banco, aes(oil)) + geom\_histogram()

cor.test(banco\(oil, banco\)dem\_score14) ggplot(banco, aes (oil,
dem\_score14)) + geom\_point(alpha=0.5) + geom\_smooth (method = “lm”)

regressao1 \<- lm(dem\_score14 \~ oil, data = banco) summary(regressao1)

\#Comentário, a julgar pelos coeficientes, se nota um impacto negativo
da produção de petróleo sob a democracia. Cada aumento em oil gera um
decréscimo de 1,88 na variável dem\_score14.

cor.test(banco\(oil, banco\)democ11) ggplot(banco, aes (oil, democ11)) +
geom\_point(alpha=0.5) + geom\_smooth (method = “lm”)

regressao2 \<- lm(democ11 \~ oil, data = banco) summary(regressao2)

\#Comentário: apresenta significância estatística maior.

cor.test(banco\(oil, banco\)fhrated04\_rev) ggplot(banco, aes
(oil,fhrate04\_rev)) + geom\_point() + geom\_smooth (method=“lm”)

regressao3 \<- lm(fhrate04\_rev \~ oil, data = banco)
summary(regressao3)

cor.test(banco\(oil, banco\)fhrated08\_rev) ggplot(banco, aes (oil,
fhrate08\_rev)) + geom\_point(alpha=0.5) + geom\_smooth (method = “lm”)

regressao4 \<- lm(fhrate08\_rev \~oil, data = banco) summary(regressao4)

cor.test(banco\(oil, banco\)polity) ggplot(banco, aes (oil, polity)) +
geom\_point(alpha=0.5) + geom\_smooth (method = “lm”)

regressao5 \<- lm(polity \~ oil, data = banco) summary(regressao5)

# Comentário: Em todos os casos se revelam os mesmos padrões. Há um relação direção negativa entre democracia e produção de petroléo. O elemento diferenciador em cada situação está nos coeficientes. Em algumas, registra-se um impacto de oil maior, mas há que se considerar também a variação na significância estatística.

### Avalie a relação entre crescimento econômico e produção de petróleo. Descreva a relação entre as duas variáveis, meça a correlação entre elas e faça regressões lineares (interpretando em profundidade os resultados dos coeficientes e medidas de desempenho dos modelos). Enfatize as semelhanças e diferenças entre os resultados. Quais são suas conclusões?

banco %\>%

cor.test(banco\(oil, banco\)gdppcap08)

reg \<- lm (gdppcap08 \~ oil, data = banco) summary (reg)

\#Comentário: os coeficientes mostram um relação positiva entre as duas
variáveis. Ou seja, acréscimos na produção de petróleo geram elevações
no desempenho econômico. Essa correlação é apoaida pelo p-valor. Há uma
significancia estatística considerável.

### A partir das suas conclusões sobre a relação entre democracia, economia e produção de petróleo, quais considerações são possíveis fazer sobre a relação CAUSAL entre estas variáveis? Lembre dos 4 “hurdles” do livro *Fundamentals of Political Science Research*

# R: os resultados das regressões indicam uma correlação entre as variáveis. Porém, dizer que há uma causalidade requer mais elaborações. Primeiro, não se pode confirmar que há produção de petroleo isoladamente gera crescimento econômico. Na verdade, é possivel apontar o contrário: boom econômica gera maior demanda por petróleo. Da mesma forma, a relação entre fatores econômicas e democracia precisa de mais endosso. Embora a maiora das democracias sejam desenvolvidas, há outros fatores que influenciam essa equação conforme demonstra a literatura. Por fim, o vincúlo entre petróleo e democracia não pode dispensar mais elaboração. É patente que o primeiro produz impacto sob o segundo, mas não há como apontar firmamente que esse efeito é causal.
