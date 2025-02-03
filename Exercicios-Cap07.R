# Solução Lista de Exercícios - Capítulo 7 

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
projeto_path = "D:/FCDados/[07] - Manipulacao em R/[03] - Projetos/"
input_path = "D:/FCDados/[07] - Manipulacao em R/[01] - InputData/"
output_path = "D:/FCDados/[07] - Manipulacao em R/[02] - OutputData/"
setwd(projeto_path)
getwd()


# Formatando os dados de uma página web
library(rvest)
library(stringr)
library(tidyr)

# Exercício 1 - Faça a leitura da url abaixo e grave no objeto pagina
# http://forecast.weather.gov/MapClick.php?lat=42.31674913306716&lon=-71.42487878862437&site=all&smap=1#.VRsEpZPF84I
x <- read_html("http://forecast.weather.gov/MapClick.php?lat=42.31674913306716&lon=-71.42487878862437&site=all&smap=1#.VRsEpZPF84I")
x
View(x)
# Exercício 2 - Da página coletada no item anterior, extraia o texto que contenha as tags:
# "#detailed-forecast-body .forecast-text"
detailed_forecast <- x  %>% html_nodes("#detailed-forecast-body b , .forecast-text")
detailed_forecast

# Exercício 3 - Transforme o item anterior em texto
resultado <- html_text(detailed_forecast)
resultado

# Exercício 4 - Extraímos a página web abaixo para você. Agora faça a coleta da tag "table"
url <- 'http://espn.go.com/nfl/superbowl/history/winners'
pagina <- read_html(url)
tabela <- pagina  %>% html_nodes("table")
tabela

# Exercício 5 - Converta o item anterior em um dataframe
x <- as.data.frame(html_table(tabela))
View(x)


# Exercício 6 - Remova as duas primeiras linhas e adicione nomes as colunas
colnames(x) <-c("Numero", "Data", "Site", "Resultado")
x <- x[-1:-2,]
x

# Exercício 7 - Converta de algarismos romanos para números inteiros
x[, 1] <- as.numeric(as.roman(x[, 1]))
x

# Exercício 8 - Divida as colunas em 4 colunas
x <- separate(x, Resultado, c("Vencedor", "Perdedor"), sep = ", ", remove = TRUE)
head(x)
View(x)

# Exercício 9 - Inclua mais 2 colunas com o score dos vencedores e perdedores
# Dica: Você deve fazer mais uma divisão nas colunas

string_sep = " (?<=[A-Za-z ])(?=[0-9])"
y <- separate(x, Vencedor, c("Time Vencedor", "Score Vencedor"), sep = string_sep, remove = TRUE)
y <- separate(y, Perdedor, c("Time Perdedor", "Score Perdedor"), sep = string_sep, remove = TRUE)
y

# Exercício 10 - Grave o resultado em um arquivo csv
setwd(output_path)
write.csv(y, file = "resultado.csv")


