render_bericht <- function(bfs_nr, jahr = NULL) {
  
  output_file_name <- paste0(jahr, "-bfs-nr-", bfs_nr, "-",  "bericht.pdf")
  
  print(paste("Ausgabedatei: ", output_file_name))
  
  quarto::quarto_render(input = here::here("docs/index.qmd"), 
                        output_format = "pdf", 
                        output_file = output_file_name, 
                        cache_refresh = TRUE,
                        execute_params = list(bfs_nr = bfs_nr, jahr = jahr))
  
  fs::dir_create(here::here(paste0("output/", bfs_nr)))
                 
  fs::file_move(here::here(output_file_name), 
                here::here(paste0("output/", 
                                  bfs_nr, "/",
                                  output_file_name)))
}
