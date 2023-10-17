library(dplyr)
library(tidyquant)
library(ggdist)
library(ggthemes)
library(tidyverse)
pal <- c("#FF8C00", "#A034F0", "#159090")


setwd("~/github/0raincloud-plot")
# Leitura de dados
estacoes_automaticas <- read.csv("dados_estacoes_automaticas_bh.csv")
estacoes_convencionais <- read.csv("dados_estacoes_convencionais_bh.csv")

# Escolher qual tipo de estação utiliza
dados <- estacoes_automaticas %>% 
  rename("precipitacao_diaria_mm" = "PRECIPITACAO.TOTAL..DIARIO..AUT..mm.")


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
# Defina a fonte Roboto
theme_set(theme_minimal(base_family = "Roboto"))

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
    point_colour = NA,
    alpha = 0.8
  ) +
  geom_boxplot(
    aes(color = periodo_6_anos,
        color = after_scale(darken(color, .1, space = "HLS")),
        fill = after_scale(desaturate(lighten(color, .8), .4))),
    width = .2, 
    outlier.shape = NA,
    outlier.color = NA,
    alpha = 0.5
  ) +
  stat_summary(
    geom = "text",
    fun = "median",
    aes(label = round(..y.., 2),
        color = periodo_6_anos,
        color = after_scale(darken(color, .1, space = "HLS"))),
    family = "Roboto Mono",
    fontface = "bold",
    size = 4.5,
    #vjust = -3.5
  ) +

  # geom_boxplot(
  # width = 0.12,
    # removing outliers
  # outlier.color = NA,
  # alpha = 0.5
  #) +
  stat_dots(
    # ploting on left side
    side = "left",
    # adjusting position
    justification = 1.1,
    # adjust grouping (binning) of observations
    binwidth = 0.25,
    color = "transparent"
  ) +
  theme_tq() +
  scale_color_manual(values = pal) +
  scale_fill_manual(values = pal)+
  labs(
    title = "Precipitação em BH com RainCloud Plot",
    x = "Período",
    y = "Precipitacao mensal",
    fill = "Período"
  ) +
  coord_flip(xlim = c(1.2, NA), clip = "off") +
  scale_y_continuous(
    limits = c(0, 30),
    breaks = seq(0, 30, by = 5),
    expand = c(.001, .001)
  ) +
  theme(panel.background = element_rect(fill = "#f2f2f2"),
                      #panel.grid.major = element_blank(),
                      panel.grid.minor = element_blank(),
                       #panel.background = element_blank()
                       )


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
    binwidth = 0.15,
    color = "red"
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

