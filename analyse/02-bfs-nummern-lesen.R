# Pakete laden ------------------------------------------------------------

library(tidyverse)

# Daten importieren -------------------------------------------------------

leerwohungen_wohnungsbestand <- read_csv(here::here("daten/processed/leerwohungen_wohnungsbestand.csv")) 

gemeinde_bfs_nr <- leerwohungen_wohnungsbestand  |> 
  distinct(bfs_nr, gebiet_name) |> 
  filter(bfs_nr %in% c(37, 176, 261, 298))

