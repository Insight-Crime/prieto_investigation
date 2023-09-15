library(tidyverse)
library(readxl)
library(ICplots)
library(ggtext)

police <- read_xlsx("data/cleaned_data.xlsx")

# Line chart date -------------------------------------------------------------
line_chart_date <- ggplot() +
  geom_line(data = police,
            mapping = aes(x = `End Date`, y = denuncias,
                          color = group), linewidth = 1) +
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
                          y = 57,
                          label = "Reported Police Abuse In Zulia"),
            family = "Roboto Black", size = 6,
            hjust = 0.05, color = "#3B3B3B") +
  geom_text(data = police,
            mapping = aes(x = as.POSIXct("01/10/2007", format = "%d/%m/%Y"),
                          y = 48,
                          label = "A Peek Into Security Forces Terror Under Prieto"),
            family = "Roboto", size = 5,
            hjust = 0.05, color = "#3B3B3B") +
  geom_text(data = police,
            mapping = aes(x = as.POSIXct("01/10/2007", format = "%d/%m/%Y"),
                          y = 37,
                          label = "  Security forces under Prieto’s control were notorious for abusing their power,\nattacking journalists, protestors, and his personal rivals."),
            family = "Roboto", size = 4,
            hjust = 0.05, color = "#3B3B3B") +
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
  scale_y_continuous(breaks = c(5, 10, 15, 20)) +
  scale_x_continuous(breaks = c(as.POSIXct("01/06/2008", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2009", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2010", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2011", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2012", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2013", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2014", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2015", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2016", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2017", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2018", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2019", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2020", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2021", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2022", format = "%d/%m/%Y")),
                     labels = c("2008", "2009", "2010", "2011", "2012", "2013",
                                "2014", "2015", "2016", "2017", "2018", "2019",
                                "2020", "2021", "2022")) +
  scale_color_manual(values = c("#C53630", "#374F98")) +
  xlab("") +
  ylab("Cases of Abuse") +
  theme(legend.position = c(.05, .2),
        legend.direction = "horizontal",
        axis.title.y = element_text(vjust = 0, hjust = 0, angle = 90,
                                    margin = margin(r = 10)),
        plot.title = element_markdown()) +
  hline
line_chart_date 

finalise_plot(line_chart_date, "     Source: PROVEA Annual Reports\n", "figures/line_test")

# Line chart year -------------------------------------------------------------
line_chart_year <- ggplot() +
  geom_line(data = police,
            mapping = aes(x = year, y = denuncias,
                          color = group), linewidth = 1) +
  geom_point(data = subset(police, year == 2020 & group == "CPBEZ"),
             mapping = aes(x = year, y = denuncias), color = "#C53630") +
  geom_text(data = police,
            mapping = aes(x = 2019.25, #31/03/2019
                          y = 10,
                          label = "Prieto governor\nof Zulia"),
            family = "Roboto",
            hjust = 0) +
  geom_text(data = police,
            mapping = aes(x = 2011.25, #"31/03/2011"
                          y = 10,
                          label = "Prieto mayor\nof San Francisco"),
            family = "Roboto",
            hjust = 0) +
  geom_text(data = police,
            mapping = aes(x = 2019.5, #"31/03/2011"
                          y = 148,
                          label = "148\nabuses"),
            family = "Roboto",
            hjust = 1) +
 # geom_text(data = police,
#            mapping = aes(x = 2006.02, #01/10/2006
#                          y = 62,
#                         label = "Reported Police Abuse In Zulia"),
#            family = "Roboto Black", size = 6,
#            hjust = 0.05, color = "#3B3B3B") +
  geom_text(data = police,
            mapping = aes(x = 2006.02, #01/10/2006
                          y = 53,
                          label = "Reported Police Abuse During the Prieto Administrations"),
            family = "Roboto Black", size = 6,
            hjust = 0.05, color = "#3B3B3B") +
  geom_text(data = police,
            mapping = aes(x = 2006.02, #01/10/2006
                          y = 42,
                          label = "  Security forces under Prieto’s control were notorious for abusing their power,\nattacking journalists, protestors, and his personal rivals."),
            family = "Roboto", size = 4,
            hjust = 0.05, color = "#3B3B3B") +
  annotate("rect", xmin = 2017.78, #10/12/2017
           xmax = max(police$year),
           ymax = 20,
           ymin = 0,
           fill = "#C53630", alpha = .2) +
  annotate("rect", xmin = 2008.89, #23/11/2008
           xmax = 2017.78, #10/12/2017
           ymax = 20,
           ymin = 0,
           fill = "#374F98", alpha = .2) +
  scale_y_continuous(breaks = c(5, 10, 15, 20), limits = c(0, 155),
                     expand = c(0, 0)) +
  scale_x_continuous(breaks = c(2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013,
                                2014, 2015, 2016, 2017, 2018, 2019,
                                2020, 2021),
                     labels = c("2006", "2007", "2008", "2009", "2010", "2011",
                                "2012", "2013", "2014", "2015", "2016", "2017",
                                "2018", "2019", "2020", "2021")) +
  scale_color_manual(values = c("#C53630", "#374F98")) +
  xlab("") +
  ylab("Cases of Abuse") +
  theme(legend.position = c(.05, .2),
        legend.direction = "horizontal",
        axis.title.y = element_text(vjust = 0, hjust = 0, angle = 90,
                                    margin = margin(r = 10)),
        plot.title = element_markdown(),
        axis.ticks.x = element_line(),
        axis.line.x = element_line(color = "#3B3B3B", linewidth = 1)) 
line_chart_year

finalise_plot(line_chart_year,
              "     Source: PROVEA Annual Reports\n",
              "figures/line_test")

# Bar chart date --------------------------------------------------------------
bar_chart <- ggplot() +
  geom_col(data = police,
           mapping = aes(x = `End Date`, y = denuncias,
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
                          y = 57,
                          label = "Reported Police Abuse In Zulia"),
            family = "Roboto Black", size = 6,
            hjust = 0.05, color = "#3B3B3B") +
  geom_text(data = police,
            mapping = aes(x = as.POSIXct("01/10/2007", format = "%d/%m/%Y"),
                          y = 48,
                          label = "A Peek Into Security Forces Terror Under Prieto"),
            family = "Roboto", size = 5,
            hjust = 0.05, color = "#3B3B3B") +
  geom_text(data = police,
            mapping = aes(x = as.POSIXct("01/10/2007", format = "%d/%m/%Y"),
                          y = 37,
                          label = "  Security forces under Prieto’s control were notorious for abusing their power,\nattacking journalists, protestors, and his personal rivals."),
            family = "Roboto", size = 4,
            hjust = 0.05, color = "#3B3B3B") +
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
  scale_y_continuous(breaks = c(5, 10, 15, 20)) +
  scale_x_continuous(breaks = c(as.POSIXct("01/06/2008", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2009", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2010", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2011", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2012", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2013", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2014", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2015", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2016", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2017", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2018", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2019", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2020", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2021", format = "%d/%m/%Y"),
                                as.POSIXct("01/06/2022", format = "%d/%m/%Y")),
                     labels = c("2008", "2009", "2010", "2011", "2012", "2013",
                                "2014", "2015", "2016", "2017", "2018", "2019",
                                "2020", "2021", "2022")) +
  scale_fill_manual(values = c("#C53630", "#374F98")) +
  xlab("") +
  ylab("Cases of Abuse") +
  theme(legend.position = c(.05, .2),
        legend.direction = "horizontal",
        axis.title.y = element_text(vjust = 0, hjust = 0, angle = 90,
                                    margin = margin(r = 10)),
        plot.title = element_markdown()) +
  hline
bar_chart 
# Bar chart year -------------------------------------------------------------
bar_chart_year <- ggplot() +
  geom_col(data = police,
            mapping = aes(x = year, y = denuncias,
                          fill = group), position = "dodge") +
  geom_text(data = police,
            mapping = aes(x = 2019.25, #31/03/2019
                          y = 10,
                          label = "Prieto governor\nof Zulia"),
            family = "Roboto",
            hjust = 0) +
  geom_text(data = police,
            mapping = aes(x = 2011.25, #"31/03/2011"
                          y = 10,
                          label = "Prieto mayor\nof San Francisco"),
            family = "Roboto",
            hjust = 0) +
  geom_label(data = police,
            mapping = aes(x = 2020, #"31/03/2011"
                          y = 150,
                          label = "148"),
            family = "Roboto", color =  "#C53630",
            hjust = .85, label.size = NA) +
  geom_text(data = police,
            mapping = aes(x = 2005, #01/10/2006
                          y = 53,
                          label = "Reported Police Abuse During the Prieto Administrations"),
            family = "Roboto Black", size = 6,
            hjust = 0, color = "#3B3B3B") +
  #geom_text(data = police,
   #         mapping = aes(x = 2006.02, #01/10/2006
    #                      y = 53,
     #                     label = "A Peek Into Security Forces Terror Under Prieto"),
      #      family = "Roboto", size = 5,
       #     hjust = 0.05, color = "#3B3B3B") +
  geom_text(data = police,
            mapping = aes(x = 2005, #01/10/2006
                          y = 42,
                          label = "Security forces under Prieto’s control were notorious for abusing their power,\nattacking journalists, protestors, and his personal rivals."),
            family = "Roboto", size = 4,
            hjust = 0, color = "#3B3B3B") +
  annotate("rect", xmin = 2017.78, #10/12/2017
           xmax = max(police$year),
           ymax = 20,
           ymin = 0,
           fill = "#C53630", alpha = .2) +
  annotate("rect", xmin = 2008.89, #23/11/2008
           xmax = 2017.78, #10/12/2017
           ymax = 20,
           ymin = 0,
           fill = "#374F98", alpha = .2) +
  scale_y_continuous(breaks = c(5, 10, 15, 20, 140, 145, 150),
                     limits = c(0, 155),
                     expand = c(0, 0)) +
  scale_x_continuous(breaks = c(2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013,
                                2014, 2015, 2016, 2017, 2018, 2019,
                                2020, 2021),
                     labels = c("2006", "2007", "2008", "2009", "2010", "2011",
                                "2012", "2013", "2014", "2015", "2016", "2017",
                                "2018", "2019", "2020", "2021"),
                     expand = c(0, 0)) +
  scale_fill_manual(values = c("#C53630", "#374F98"),
                    labels = c("Polisur" = "San Francisco Municipal Police",
                               "CPBEZ" = "Zulia State Police")) +
  xlab("") +
  ylab("Reported Cases of Abuse") +
  theme(legend.position = c(.0, .2),
        legend.direction = "horizontal",
        axis.title.y = element_text(vjust = 0, hjust = 0, angle = 90,
                                    margin = margin(r = 10)),
        plot.title = element_markdown(),
        axis.ticks.x = element_line(),
        axis.line.x = element_line(color = "#3B3B3B", linewidth = 1)) +
  geom_segment(aes(x = 2019, xend = 2020.5, y = 147.7, yend = 147.7),
               color = "#C53630",  linetype = 1) 
bar_chart_year

finalise_plot(bar_chart_year,
              "     Source: PROVEA Annual Reports\n",
              "figures/line_test")



258G258