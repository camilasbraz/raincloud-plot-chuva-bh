library(dplyr)
library(tidyquant)
library(ggdist)
library(ggthemes)
library(tidyverse)

setwd("~/github/0raincloud-plot")
# Leitura de dados
estacoes_automaticas <- read.csv("dados_estacoes_automaticas_bh.csv")
estacoes_convencionais <- read.csv("dados_estacoes_convencionais_bh.csv")

# Escolher qual tipo de estação utiliza
dados <- estacoes_automaticas %>% 
  rename("precipitacao_diaria_mm" = "PRECIPITACAO.TOTAL..DIARIO..AUT..mm.")

#

dados$Data.Medicao <- as.Date(dados$Data.Medicao)


df_precipitacao <- dados %>% 
  na.omit(df) %>% 
  mutate(ano = lubridate::year(Data.Medicao),
         mes = lubridate::month(Data.Medicao, label = TRUE, abbr = FALSE),
         ano_num = as.numeric(ano),
         periodo_6_anos = paste0(floor((ano_num - min(ano_num)) / 6) *
                                 6 + min(ano_num), "-", floor((ano_num - min(ano_num)) / 6) * 6 + min(ano_num) + 4)) %>% 
  group_by(ano, mes,periodo_6_anos) %>%
  summarize(mean_precipitation = mean(precipitacao_diaria_mm, na.rm = TRUE))


df_precipitacao %>%
  ggplot(aes(x = factor(periodo_6_anos), y = mean_precipitation, fill = factor(periodo_6_anos))) +

  # add half-violin from {ggdist} package
  stat_halfeye(
    # adjust bandwidth
    adjust = 0.5,
    # move to the right
    justification = -0.2,
    # remove the slub interval
    .width = 0,
    point_colour = NA
  ) +
  geom_boxplot(
    width = 0.12,
    # removing outliers
    outlier.color = NA,
    alpha = 0.5
  ) +
  stat_dots(
    # ploting on left side
    side = "left",
    # adjusting position
    justification = 1.1,
    # adjust grouping (binning) of observations
    binwidth = 0.25
  ) +
  # Themes and Labels
  scale_fill_tq() +
  theme_tq() +
  labs(
    title = "Precipitação em BH com RainCloud Plot",
    x = "Período",
    y = "Precipitacao mensal",
    fill = "Período"
  ) +
  coord_flip()


df_precipitacao <- dados %>% 
  na.omit(df) %>% 
  group_by(Data.Medicao) %>%
  summarize(mean_precipitation = mean(precipitacao_diaria_mm, na.rm = TRUE)) %>% 
  mutate(ano = lubridate::year(Data.Medicao),
         ano_num = as.numeric(ano),
         periodo_6_anos = paste0(floor((ano_num - min(ano_num)) / 6) *
                                   6 + min(ano_num), "-", floor((ano_num - min(ano_num)) / 6) * 6 + min(ano_num) + 4))


df_precipitacao %>%
  ggplot(aes(x = factor(periodo_6_anos), y = mean_precipitation, fill = factor(periodo_6_anos))) +
  
  # add half-violin from {ggdist} package
  stat_halfeye(
    # adjust bandwidth
    adjust = 0.5,
    # move to the right
    justification = -0.2,
    # remove the slub interval
    .width = 0,
    point_colour = NA
  ) +
  geom_boxplot(
    width = 0.12,
    # removing outliers
    outlier.color = NA,
    alpha = 0.5
  ) +
  stat_dots(
    # ploting on left side
    side = "left",
    # adjusting position
    justification = 1.1,
    # adjust grouping (binning) of observations
    binwidth = 0.25
  ) +
  # Themes and Labels
  scale_fill_tq() +
  theme_tq() +
  labs(
    title = "Precipitação em BH com RainCloud Plot",
    x = "Período",
    y = "Precipitacao mensal",
    fill = "Período"
  ) +
  coord_flip()

