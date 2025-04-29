# Aufgabe -----------------------------------------------------------------

# Dies ist ein R Skript. Es ist in etwa als wenn wir uns innerhalb eines
# einzigen Code-Block in einem Quarto Dokument befinden. Alles was wir 
# schreiben wird als Code angenommen, ausser wir setzen ein # am Anfang

# Aufgabe: Beschreibt den Code im Kapitel "Daten transfomieren" so wie ich
# es im Kapitel "Daten importieren" gemacht habe. Ich habe euch ein paar # 
# Symbole vorgegeben

# R-Pakete laden ----------------------------------------------------------

library(tidyverse)

# Daten importieren -------------------------------------------------------

# Daten aus dem ZH Web laden. Diese sind durch Tabs separiert, deshalb read_delim().
wohnungsbestand <- read_delim("https://www.web.statistik.zh.ch/ogd/data/KANTON_ZUERICH_140.csv") |> 
  # Eine Funktion, welche die Spaltennamen zu Kleinbuchstaben umwandelt
  janitor::clean_names() 

# Daten aus dem ZH Web laden. Diese sind durch Tabs separiert, deshalb read_delim().
leerwohungen <- read_delim("https://www.web.statistik.zh.ch/ogd/data/KANTON_ZUERICH_381.csv") |> 
  # Eine Funktion, welche die Spaltennamen zu Kleinbuchstaben umwandelt
  janitor::clean_names()

# Daten transformieren ----------------------------------------------------

wohnungsbestand_klein <- wohnungsbestand |> 
  # Beschreibung....
  select(bfs_nr, gebiet_name, indikator_name, indikator_id, 
         indikator_jahr, indikator_value)

leerwohungen_klein <-  leerwohungen |> 
  # Beschreibung....
  select(bfs_nr, gebiet_name, indikator_name, indikator_id,
         indikator_jahr, indikator_value)

leerwohungen_wohnungsbestand <- wohnungsbestand_klein |> 
  # Beschreibung....
  bind_rows(leerwohungen_klein) |> 
  # Beschreibung....
  filter(indikator_jahr < 2024) |> 
  # Beschreibung....
  filter(bfs_nr != 0) |>
  # Beschreibung....
  filter(!str_detect(gebiet_name, "bis"))

# Daten speichern ----------------------------------------------------------

write_csv(leerwohungen_wohnungsbestand, 
          here::here("daten/processed/leerwohungen_wohnungsbestand.csv"))

