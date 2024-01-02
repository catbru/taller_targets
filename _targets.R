library(targets)
library(tarchetypes)

source('R/idealista_functions.R')

tar_option_set(packages =
  c('readr','dplyr','tidyr','lubridate','stringr','ggplot2','mapSpain','quarto')
)

list(
  tar_target(
    price_evolution_file,
    "data/20231229_idealista_price_evolution_ppcc.csv",
    format = "file"
  ),
  tar_target(
    locations_file,
    "data/20231229_idealista_locations_ppcc.csv",
    format = "file"
  ),
  tar_target(
    price_evolution_raw,
    read_raw_data(price_evolution_file)
  ),
  tar_target(
    locations_raw,
    read_raw_data(locations_file)
  ),
  tar_target(
    prices_evolution,
    clean_prices_evolution(price_evolution_raw)
  ),
  tar_target(
    locations,
    clean_locations(locations_raw)
  ),
  tar_target(
    locations_with_price_evolution,
    join_price_evolution_with_locations(prices_evolution, locations)
  ),
  tar_target(
    locations_last_price,
    get_last_price(locations_with_price_evolution)
  ),
  tar_target(
    plot_rent_price_by_province,
    draw_plot_line_rent_price_evolution_by_province(locations_with_price_evolution)
  ),
  tar_target(
    plot_rent_price_by_bcn_districts,
    draw_plot_line_rent_price_evolution_by_bcn_districts(locations_with_price_evolution)
  ),
  tar_target(
    map_sale_price_muni_cat,
    draw_map_sale_price_muni_cat(locations_last_price)
  ),
  tar_render(article, "docs/article.Rmd")
)






