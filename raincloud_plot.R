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

pal <- c("#00b4d8", "#0077b6", "#023e8a")
df_precipitacao %>%
  ggplot(aes(x = factor(periodo_6_anos), y = mean_precipitation, fill = factor(periodo_6_anos))) +
  stat_halfeye(
    adjust = 0.5,
    justification = -0.2,
    .width = 0,
    point_colour = NA,
    alpha = 0.8
  ) +
  geom_boxplot(
    aes(color = periodo_6_anos,
        # color = after_scale(darken(color, .1, space = "HLS")),
        #fill = after_scale(desaturate(lighten(color, .8), .4))),
        fill =  periodo_6_anos),
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
        #color = after_scale(darken(color, .1, space = "HLS"))
        ),
    family = "Roboto",
    fontface = "bold",
    size = 4.5,
    hjust = -0.2,
  ) +
  stat_dots(
    side = "left",
    justification = 1.1,
    binwidth = 0.25,
    color = "transparent"
  ) +
  theme_tq() +
  scale_color_manual(values = pal) +
  scale_fill_manual(values = pal)+
  labs(
    title = "",
    x = "",
    y = "",
    fill = ""
  ) +
  coord_flip(xlim = c(1.2, NA), clip = "off") +
  scale_y_continuous(
    limits = c(0, 30),
    breaks = seq(0, 30, by = 5),
    expand = c(.001, .001)
  ) +
  theme_minimal(base_family = "Roboto", base_size = 15) +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_blank(),
    axis.ticks = element_blank(),
    axis.text.x = element_text(family = "Roboto"),
    axis.text.y = element_text(
      #color = darken(pal, .1, space = "HLS"), 
      size = 18
    ),
    axis.title.x = element_text(margin = margin(t = 10),
                                size = 16),
 
   plot.margin = unit(c(1.5, 1.5, 1.5, 1.5), "cm"),
    legend.position="none",
   # element_rect(fill = "#f2f2f2")

  )


