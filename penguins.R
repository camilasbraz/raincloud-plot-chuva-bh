library(palmerpenguins)
library(ggtext)
library(colorspace)
library(ragg)



pal <- c("#FF8C00", "#A034F0", "#159090")

add_sample <- function(x){
  return(c(y = max(x) + .025, 
           label = length(x)))
}

penguins %>% 
  group_by(periodo_6_anos) %>% 
  mutate(bill_ratio = bill_length_mm / bill_depth_mm) %>% 
  filter(!is.na(bill_ratio))
# %>% 
  
  df_precipitacao %>%
  ggplot(aes(x = factor(periodo_6_anos), y = mean_precipitation)) +
  ggdist::stat_halfeye(
    aes(color = periodo_6_anos,
        fill = after_scale(lighten(color, .5))),
    adjust = .5, 
    width = .75, 
    .width = 0,
    justification = -.4, 
    point_color = NA) + 
    
  geom_boxplot(
    aes(color = periodo_6_anos,
        color = after_scale(darken(color, .1, space = "HLS")),
        fill = after_scale(desaturate(lighten(color, .8), .4))),
    width = .2, 
    outlier.shape = NA
  ) +
    
    stat_dots(
      # ploting on left side
      side = "left",
      # adjusting position
      justification = 1.1,
      # adjust grouping (binning) of observations
      binwidth = 0.25
    )
    
  geom_point(
    aes(fill = periodo_6_anos),
    color = "transparent",
    shape = 21,
    stroke = .4,
    size = 2,
    alpha = .3,
    position = position_jitter(seed = 1, width = .12)
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
    vjust = -3.5
  ) +
    
  stat_summary(
    geom = "text",
    fun.data = add_sample,
    aes(label = paste("n =", ..label..),
        color = periodo_6_anos,
        color = after_scale(darken(color, .1, space = "HLS"))),
    family = "Roboto Condensed",
    size = 4,
    hjust = 0
  ) +
    
  coord_flip(xlim = c(1.2, NA), clip = "off") +
  scale_y_continuous(
    limits = c(0, 30),
    breaks = seq(0, 30, by = 5),
    expand = c(.001, .001)
  ) +
    
  scale_color_manual(values = pal, guide = "none") +
  scale_fill_manual(values = pal, guide = "none")
    
  theme_minimal(base_family = "Zilla Slab", base_size = 15) +
    
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_blank(),
    axis.ticks = element_blank(),
    axis.text.x = element_text(family = "Roboto Mono"),
    axis.text.y = element_text(
      color = rev(darken(pal, .1, space = "HLS")), 
      size = 18
    ),
    axis.title.x = element_text(margin = margin(t = 10),
                                size = 16),
    plot.title = element_markdown(face = "bold", size = 21),
    plot.subtitle = element_text(
      color = "grey40", hjust = 0,
      margin = margin(0, 0, 20, 0)
    ),
    plot.title.position = "plot",
    plot.caption = element_markdown(
      color = "grey40", lineheight = 1.2,
      margin = margin(20, 0, 0, 0)),
    plot.margin = margin(15, 15, 10, 15)
  )
  
  +
    
    # geom_point(
    #  aes(color = periodo_6_anos,
    #      color = after_scale(darken(color, .1, space = "HLS"))),
#  fill = "white",
    #  shape = 21,
    #  stroke = .4,
  #  size = 2,
  #   position = position_jitter(seed = 1, width = .12)
  #  ) + 
    
  #+
    
    # labs(
    #  x = NULL,
    #  y = "Precipitação média mensal",
    #   title = "Precipitação em BH com Raincloud Plot",
  #   subtitle = "Distribuição da Precipitação Média Mensal",
    #   caption = "Dados do "
    # ) 
  
