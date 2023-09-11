library(tidyverse)
library(readxl)
library(ICplots)

theme_set(theme_ic())

provea <- read_xlsx("data/graphics 2 data.xlsx")[1:9] %>%
  mutate(denuncias = as.numeric(`Denuncias/Discriminación según cuerpos de seguridad`))

polisur <- provea %>%
  filter(`Police Force` == "Municipal Police" &
           (grepl("San Francisco", Municipality) == TRUE | Municipality == "PoliSur"))

polizulia <- provea %>%
  filter(`Police Force` == "Regional Police" &
         grepl("Zulia", State) == TRUE)

bar_chart <- ggplot() +
  geom_col(data = polisur, mapping = aes(x = `Start Date`,
                                         y = denuncias),
           fill = "red", position = "jitter") +
  geom_col(data = polizulia, mapping = aes(x = `Start Date`,
                                           y = denuncias),
           fill = "green", position = "jitter") +
  hline
bar_chart 

bar_chart <- ggplot() +
  geom_col(data = polizulia, mapping = aes(x = `Start Date`,
                                         y = denuncias))
bar_chart
