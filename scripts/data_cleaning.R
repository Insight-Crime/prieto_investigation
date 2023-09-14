library(tidyverse)
library(readxl)
library(ICplots)
library(ggtext)

theme_set(theme_ic())

provea <- read_xlsx("data/graphics 2 data.xlsx")[1:9] %>%
  mutate(denuncias = as.numeric(`Denuncias/Discriminación según cuerpos de seguridad`))

polisur <- provea %>%
  filter(`Police Force` == "Municipal Police" &
           (grepl("San Francisco", Municipality) == TRUE |
              Municipality == "PoliSur")) %>%
  mutate(polisur = "Poli Sur")

polizulia <- provea %>%
  filter(`Police Force` == "Regional Police" &
         grepl("Zulia", State) == TRUE) %>%
  mutate(polizulia = "Poli Zulia")

police <- full_join(polisur, polizulia) %>%
  mutate(group = ifelse(!is.na(polisur), "Poli Sur",
                        ifelse(!is.na(polizulia), "Poli Zulia", NA))) %>%
  replace(is.na(denuncias), 0)

bar_chart <- ggplot() +
  geom_col(data = police,
           mapping = aes(x = `Start Date`, y = denuncias,
                         fill = group), position = "dodge") +
  geom_text(data = police,
            mapping = aes(x = as.POSIXct("31/03/2019", format = "%d/%m/%Y"),
                          y = 10,
                          label = "Prieto governor\nof Zulia"),
            family = "Roboto",
            hjust = 0) +
  geom_text(data = police,
            mapping = aes(x = as.POSIXct("31/03/2011", format = "%d/%m/%Y"),
                          y = 10,
                          label = "Prieto mayor\nof San Francisco"),
            family = "Roboto",
            hjust = 0) +
  geom_text(data = police,
            mapping = aes(x = as.POSIXct("01/10/2007", format = "%d/%m/%Y"),
                          y = 35,
                          label = "Abuses by Poli Sur and Poli Zulia"),
            family = "Roboto Black", size = 6,
            hjust = 0.09, color = "#3B3B3B") +
  annotate("rect", xmin = as.POSIXct("10/12/2017", format = "%d/%m/%Y"),
                          xmax = max(police$`End Date`),
                          ymax = 20,
                          ymin = 0,
            fill = "#C53630", alpha = .2) +
  annotate("rect", xmin = as.POSIXct("23/11/2008", format = "%d/%m/%Y"),
           xmax = as.POSIXct("10/12/2017", format = "%d/%m/%Y"),
           ymax = 20,
           ymin = 0,
           fill = "#374F98", alpha = .2) +
  scale_y_continuous(breaks = c(5, 10, 15, 20, 150)) +
  scale_fill_manual(values = c("#374F98", "#C53630")) +
  xlab("") +
  ylab("Cases of Abuse") +
  theme(legend.position = c(.05, .2),
        legend.direction = "horizontal",
        axis.title.y = element_text(vjust = 0, hjust = 0, angle = 90),
        plot.title = element_markdown()) +
  hline
bar_chart 
