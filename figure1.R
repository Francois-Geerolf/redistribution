library(tidyverse)
library(curl)
library(scales)

curl_download("https://www.insee.fr/fr/statistiques/fichier/5371275/RPM2021_D2.xlsx",
              destfile = "RPM2021_D2.xlsx",
              quiet = F)

load("RPM2021_D2_manuel.RData")

names(RPM2021_D2_manuel)

RPM2021_D2_manuel |>
  gather(variable, value, -`Dixième`) |>
  mutate(variable = factor(variable, levels = c("Impôts payés sur les revenus et transferts",
                                                "Impôts nets payés sur les revenus et transferts"))) |>
  ggplot() + geom_line(aes(x = `Dixième`, y = value, color = variable, group = variable), size = 1) +
  theme_minimal() + xlab("") + ylab("En % du revenu avant transferts") +
  scale_color_manual(name = "Variable",
                     values = c("Impôts payés sur les revenus et transferts" = '#F8766D',
                                "Impôts nets payés sur les revenus et transferts" = '#619CFF'),
                     drop = FALSE) +
  scale_y_continuous(breaks = 0.01*seq(-200, 2000, 20),
                     labels = percent_format(accuracy = 1)) +
  theme(legend.position = c(0.7, 0.2),
        legend.title = element_blank(),
        axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  geom_label(data = . %>%
               filter(`Dixième` %in% c("D1- (10% les + pauvres)", "D9+ (10% les + riches)")),
             aes(x = `Dixième`, y = value, color = variable, label = percent(value, acc = 1)), legend = FALSE) +
  geom_hline(yintercept = 0, linetype = "dashed", size = 1)


ggsave("figure1.png", width = 1.25*6, height = 1.25*3.375, bg = "white")
ggsave("figure1.pdf", width = 1.25*6, height = 1.25*3.375)
