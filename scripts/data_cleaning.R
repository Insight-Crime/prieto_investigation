library(tidyverse)
library(readxl)

import_all_excels <- function(i) {
  tmp_filepath <- paste0("data/", list.files("data/")[i])
  temp_df <- read_xlsx(path = tmp_filepath, sheet = 2)
}


all_excels <- tibble()

for (i in length(list.files("data/"))) {
  tmp_df <- import_all_excels(i)
  all_excels <- rbind(all_excels, tmp_df) %>%
    filter(grepl("Fuente", Patrón) == FALSE)
}

all_excels_long <- pivot_longer(all_excels, cols = colnames(all_excels)[2:6],
                                names_to = "Date")
all_excels_long <- all_excels_long %>%
  mutate(Date = as.numeric(sub("Ene.-Dic. ", "", all_excels_long$Date)))


ggplot(subset(all_excels_long, Patrón == "Torturas"), aes(x = Date, y = value)) +
  geom_line(group = 1)
         