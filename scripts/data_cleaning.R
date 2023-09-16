library(tidyverse)
library(readxl)
library(ICplots)
library(ggtext)

theme_set(theme_ic())

# Data munging ----------------------------------------------------------------
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

police_export <- full_join(polisur, polizulia) %>%
  mutate(group = ifelse(!is.na(polisur), "Polisur",
                        ifelse(!is.na(polizulia), "CPBEZ", NA)),
         year = as.numeric(format(`End Date`, "%Y"))) 
police_export$denuncias <- ifelse(is.na(police_export$denuncias), 0,
                                  police_export$denuncias)

write_excel_csv(police_export, "data/cleaned_data.csv")
# additional cases added manually

d3_data <- read_xlsx("data/cleaned_data.xlsx") %>%
  select(year, group, denuncias) %>%
  pivot_wider(names_from = group, values_from = denuncias)

write_csv(d3_data, "data/d3_data.csv")
