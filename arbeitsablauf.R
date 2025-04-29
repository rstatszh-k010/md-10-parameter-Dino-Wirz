# Funktion laden-------------------------------------------------------------

source(here::here("R/render-bericht.R"))
source(here::here("analyse/02-bfs-nummern-lesen.R"))

# einen Bericht für ein Jahr erstellen -------------------------------------

render_bericht(bfs_nr = 261, jahr = 2021)

# for loop um Berichte für alle Gemeinden zu erstellen --------------------

for (bfs_nr in gemeinde_bfs_nr$bfs_nr) {
  render_bericht(bfs_nr = bfs_nr, jahr = 2021)
}
