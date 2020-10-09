Exercicio 10
================

### Continuaremos com a utilização dos dados do ESEB2018. Carregue o banco da mesma forma que nos exercicios anteriores

``` r
library(tidyverse)
library(haven)
library(margins)
library(InformationValue)

link <- "https://github.com/MartinsRodrigo/Analise-de-dados/blob/master/04622.sav?raw=true"

download.file(link, "04622.sav", mode = "wb")

banco <- read_spss("04622.sav") 

banco <- banco %>%
  mutate(D10 = as_factor(D10)) %>%
  filter(Q18 < 11,
         D9 < 9999998,
         Q1501 < 11,
         Q12P2_B < 3) %>%
  mutate(Q12P2_B = case_when(Q12P2_B == 1 ~ 0,  # Quem votou em Haddad = 0
                             Q12P2_B == 2 ~ 1)) # Quem votou em Bolsonaro = 1
```

### Crie a mesma variável de religião utilizada no exercício anterior

``` r
Outras <- levels(banco$D10)[-c(3,5,13)]

banco <- banco %>%
  mutate(religiao = case_when(D10 %in% Outras ~ "Outras",
                              D10 == "Católica" ~ "Católica",
                              D10 == "Evangélica" ~ "Evangélica",
                              D10 == "Não tem religião" ~ "Não tem religião"))
```

### Faça uma regressão linear utilizando as mesmas variáveis do exercício 9 - idade(D1A\_ID), educação (D3\_ESCOLA), renda (D9), nota atribuída ao PT (Q1501), auto-atribuição ideológica (Q18), sexo (D2\_SEXO) e religião (variável criada no passo anterior) - explicam o voto em Bolsonaro (Q12P2\_B).

``` r
regressao  <- lm(Q12P2_B ~ D1A_ID + D3_ESCOLA + D9 + D2_SEXO + religiao + Q1501 + Q18, data = banco)

options (scipen = 10)
summary(regressao)
```

    ## 
    ## Call:
    ## lm(formula = Q12P2_B ~ D1A_ID + D3_ESCOLA + D9 + D2_SEXO + religiao + 
    ##     Q1501 + Q18, data = banco)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.05532 -0.19854  0.01565  0.16182  0.96682 
    ## 
    ## Coefficients:
    ##                               Estimate    Std. Error t value Pr(>|t|)    
    ## (Intercept)               0.7066528237  0.0646893413  10.924  < 2e-16 ***
    ## D1A_ID                    0.0011401012  0.0007538896   1.512  0.13074    
    ## D3_ESCOLA                 0.0055466625  0.0052257983   1.061  0.28873    
    ## D9                       -0.0000009837  0.0000031963  -0.308  0.75832    
    ## D2_SEXO                  -0.0528631872  0.0208943372  -2.530  0.01154 *  
    ## religiaoEvangélica        0.0768358985  0.0236336987   3.251  0.00118 ** 
    ## religiaoNão tem religião -0.0027459861  0.0423769173  -0.065  0.94835    
    ## religiaoOutras           -0.0726267771  0.0367795766  -1.975  0.04855 *  
    ## Q1501                    -0.0772824015  0.0027990853 -27.610  < 2e-16 ***
    ## Q18                       0.0265094568  0.0030932523   8.570  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.3489 on 1138 degrees of freedom
    ## Multiple R-squared:  0.5028, Adjusted R-squared:  0.4989 
    ## F-statistic: 127.9 on 9 and 1138 DF,  p-value: < 2.2e-16

### Interprete o resultado dos coeficientes

Idade tem uma direção positiva e um ascréscimo unitário seu provoca um
aumento de 0,7 na variável dependente. Escoralidade também impacta de
forma positiva o voto em Bolsonaro, ao passo que cada elevação adiciona
0,005 a ela.Já a renda tem um efeito negativo, pois cada Cada unidade
adicionada a ela tira 0,00000009 da variável dependente. Sexo segue a
mesma direção, de modo que que ela reduz em 0,05 o voto em Bolsonaro. A
varíavel religião evangélica gera uma repercusão positiva, sendo que um
acréscimo nela aumenta 0,07 na varável dependnete comparada a religião
católica. Quando sofre uma elevação unitária, a categoria sem religão
substrai 0,002 da variável dependente. Nessa mesma direção, a categoria
outra contrai em 0,07 o voto em Bolsonaro. A nota dada ao PT produz um
impacto negativo e cada vez que ela se eleva há uma redução de 0,077 na
variável dependente. Por fim, a auto-avaliação ideológica provoca
efeitos positivos no voto em Bolsonaro, já que uma cada ascréscimo
unitário agrega 0,02 na variável dependente.

### O resultado difere dos encontrados anteriormente, quando a variavel dependente era a aprovação de Bolsonaro?

Sim, é possível notar mudanças tanto nos parâmetros estimados e nos
parâmetros de ajuste do modelo. Algumas váriais têm o valor do
coeficiente alterado, assim como uma inversão na direação. Entre nessa
categoria, para ilustrar, a variável escolaridade (D3\_ESCOLA), que no
exerício 9 registra um coeficiente de -0,113. Nota-se que,
anteriormente, ela produziua um efeito negativo sob a variável
dependente. Aqui se dá justamente o contrário. Deve-se atentar também
para as alterações na signifância estatística das variáveis. Algunas
conservam os mesmos índices, é o caso de D3\_ESCOLA, mas outras como
ReligiãoEvangélica ficam com uma significância menor. Por fim, o
coeficiente de determinação aqui é maior do que o do modelo usado no
exercício anterior (0,3).

### Faça uma regressão logistica com as mesmas variaveis

``` r
regressao1 <- glm(Q12P2_B ~ D1A_ID + D3_ESCOLA + D9 + D2_SEXO + + Q1501 + Q18+ religiao, data = banco, family = "binomial")

options (scipen = 10)
summary(regressao1)
```

    ## 
    ## Call:
    ## glm(formula = Q12P2_B ~ D1A_ID + D3_ESCOLA + D9 + D2_SEXO + +Q1501 + 
    ##     Q18 + religiao, family = "binomial", data = banco)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -2.7529  -0.5625   0.2518   0.4744   2.5830  
    ## 
    ## Coefficients:
    ##                              Estimate   Std. Error z value Pr(>|z|)    
    ## (Intercept)               0.820905327  0.529763447   1.550  0.12124    
    ## D1A_ID                    0.010013686  0.006336810   1.580  0.11405    
    ## D3_ESCOLA                 0.056341787  0.043575753   1.293  0.19602    
    ## D9                       -0.000004635  0.000023959  -0.193  0.84660    
    ## D2_SEXO                  -0.449713328  0.173903438  -2.586  0.00971 ** 
    ## Q1501                    -0.467805560  0.026663935 -17.545  < 2e-16 ***
    ## Q18                       0.224213882  0.027479605   8.159 3.37e-16 ***
    ## religiaoEvangélica        0.621655696  0.198470380   3.132  0.00173 ** 
    ## religiaoNão tem religião -0.021056111  0.347756068  -0.061  0.95172    
    ## religiaoOutras           -0.673554187  0.312177200  -2.158  0.03096 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 1557.84  on 1147  degrees of freedom
    ## Residual deviance:  862.45  on 1138  degrees of freedom
    ## AIC: 882.45
    ## 
    ## Number of Fisher Scoring iterations: 5

### Transforme os coeficientes estimados em probabilidade

``` r
margins(regressao1)
```

    ##    D1A_ID D3_ESCOLA            D9 D2_SEXO    Q1501     Q18 religiaoEvangélica
    ##  0.001171  0.006589 -0.0000005421 -0.0526 -0.05471 0.02622            0.07346
    ##  religiaoNão tem religião religiaoOutras
    ##                 -0.002521       -0.08172

``` r
summary(margins(regressao1))
```

    ##                    factor     AME     SE        z      p   lower   upper
    ##                    D1A_ID  0.0012 0.0007   1.5849 0.1130 -0.0003  0.0026
    ##                   D2_SEXO -0.0526 0.0202  -2.6078 0.0091 -0.0921 -0.0131
    ##                 D3_ESCOLA  0.0066 0.0051   1.2949 0.1953 -0.0034  0.0166
    ##                        D9 -0.0000 0.0000  -0.1935 0.8466 -0.0000  0.0000
    ##                     Q1501 -0.0547 0.0009 -57.9078 0.0000 -0.0566 -0.0529
    ##                       Q18  0.0262 0.0030   8.8434 0.0000  0.0204  0.0320
    ##        religiaoEvangélica  0.0735 0.0235   3.1280 0.0018  0.0274  0.1195
    ##  religiaoNão tem religião -0.0025 0.0417  -0.0605 0.9517 -0.0842  0.0791
    ##            religiaoOutras -0.0817 0.0379  -2.1574 0.0310 -0.1560 -0.0075

### Quais foram as diferenças no resultado entre usar a regressão linear e a logistica?

Houve mudanças pontuais em relação aos valores dos coeficientes. No
entanto, as variáveis apresentam a mesma direção e significância
estatística semelhantes em ambos os modelos.

### Verifique a quantidade de classificações corretas da regressao logistica e avalie o resultado

Pelo resultados, nota-se que o modelo consegue classificar 83% dos
respondentes.

``` r
prb <- predict(regressao1, type = "response")

1 - misClassError(banco$Q12P2_B, 
                  prb, 
                  threshold = 0.5)
```

    ## [1] 0.8301

``` r
opt_cutoff <- optimalCutoff(banco$Q12P2_B, 
                            prb)

confusionMatrix(banco$Q12P2_B, 
              prb, 
              threshold = opt_cutoff)
```

    ##     0   1
    ## 0 393 105
    ## 1  83 567

``` r
prop.table(confusionMatrix(banco$Q12P2_B, 
              prb, 
              threshold = opt_cutoff))
```

    ##            0          1
    ## 0 0.34233449 0.09146341
    ## 1 0.07229965 0.49390244
