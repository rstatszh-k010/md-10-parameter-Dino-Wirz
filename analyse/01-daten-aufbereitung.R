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
  # Eine Auswahl von Spalten aus "wohnungsbestand" auswählen, neu anordnen und als neue Tabelle speichern
  select(bfs_nr, gebiet_name, indikator_name, indikator_id, 
         indikator_jahr, indikator_value)

leerwohungen_klein <-  leerwohungen |> 
  # dito für Tabelle "leerwohnungen"
  select(bfs_nr, gebiet_name, indikator_name, indikator_id,
         indikator_jahr, indikator_value)

leerwohungen_wohnungsbestand <- wohnungsbestand_klein |> 
  # die Zeilen beider Tabellen in einer neuen Tabelle aneinanderhängen. Gleiche Spaltennamen (in diesem Fall alle Spalten) zu einer längeren Spalte zusammengeführt
  bind_rows(leerwohungen_klein) |> 
  # nur Zeilen, die aus den Jahren vor 2024 stammen
  filter(indikator_jahr < 2024) |> 
  # Gebietseinheiten grösser als Gemeinden entfernen. Diese weisen bfs_nr Null auf.
  filter(bfs_nr != 0) |>
  # Zeilen entfernen, die den String "bis" im Gemeindenamen haben. Dies wurde gemacht bei Gemeindefusionen
  filter(!str_detect(gebiet_name, "bis"))

# Daten speichern ----------------------------------------------------------

write_csv(leerwohungen_wohnungsbestand, 
          here::here("daten/processed/leerwohungen_wohnungsbestand.csv"))

