read_raw_data <- function(path) {
  read_delim(path,
    delim = ";", escape_double = FALSE, trim_ws = TRUE
  )
}


clean_prices_evolution <- function(price_evolution_raw) {
  sales <- price_evolution_raw |>
    transmute(
      location_id = location_id,
      period = ymd(sale_period),
      price = as.numeric(sale_prices),
      operation = "sale"
    ) |>
    filter(!is.na(period))

  rents <- price_evolution_raw |>
    transmute(
      location_id = location_id,
      period = ymd(rent_period),
      price = as.numeric(rent_prices),
      operation = "rent"
    ) |>
    filter(!is.na(period))

  bind_rows(sales, rents)
}

clean_locations <- function(locations_raw) {
  loc.levels <- locations_raw |>
    transmute(
      location_id_ = location_id,
      location_id = location_id,
      name = name,
      level = case_when(
        str_count(location_id, "-") == 8 ~ "neighborhood",
        str_count(location_id, "-") == 7 ~ "district",
        str_count(location_id, "-") == 6 ~ "town",
        str_count(location_id, "-") == 3 ~ "province",
        TRUE ~ NA
      ),
      stock_ads_rent = as.numeric(stock_ads_rent),
      stock_ads_sale = as.numeric(stock_ads_sale),
      has_evolution = as.logical(has_evolution),
      stock_cadastre = as.numeric(stock_cadastre),
      representative_age = representativeage,
      representative_size = representativesize,
      stock_residential_building = as.numeric(stock_residential_building),
      url = url,
      geometry = geometry
    ) |>
    separate(
      location_id, "-",
      into = c(
        "digit_code",
        "ue_code",
        "county_code",
        "province_code",
        "town_code",
        "town_code2",
        "town_code3",
        "district_code1",
        "neighborhood_code"
      )
    )
  all_cal_na <- function(x) {
    sum(!is.na(x)) > 0
  }

  for (level_ in unique(loc.levels$level)) {
    loc.levels <- loc.levels |>
      left_join(
        loc.levels |>
          filter(level == level_) |>
          pivot_wider(
            id_cols = c(
              digit_code,
              ue_code,
              county_code,
              province_code,
              town_code,
              town_code2,
              town_code3,
              district_code1,
              neighborhood_code
            ),
            names_from = level, values_from = name
          ) |>
          select_if(all_cal_na)
      )
  }

  loc.levels |>
    transmute(
      location_id = location_id_,
      level,
      name,
      province,
      town,
      district,
      neighborhood,
      stock_ads_rent,
      stock_ads_sale,
      has_evolution,
      stock_cadastre,
      representative_age,
      representative_size,
      stock_residential_building,
      url,
      geometry
    )
}

join_price_evolution_with_locations <- function(price_evolution, locations) {
  price_evolution |>
    left_join(locations, by = "location_id") |>
    filter(has_evolution == TRUE)
}

get_last_price <- function(locations_with_price_evolution) {
  locations_with_price_evolution |>
    group_by(location_id, operation) |>
    slice_max(order_by = period, n = 1)
}

draw_plot_line_rent_price_evolution_by_province <- function(df) {
  df |>
    filter(level == 'province') |>
    filter(operation == 'rent') |>
    ggplot(aes(x = period, y = price)) +
    geom_line() +
    facet_wrap(~ name, scales = 'free_y') +
    theme_minimal() +
    theme(
      axis.text.x = element_text(angle = 90, hjust = 1)
    ) +
    labs(
      x = 'years',
      y = '€/m2',
      title = "Rent price evolution in PPCC's provinces"
    )
}

draw_plot_line_rent_price_evolution_by_bcn_districts <- function(df) {
  df |>
    filter(level == 'district') |>
    filter(town == 'Barcelona') |>
    filter(operation == 'rent') |>
    ggplot(aes(x = period, y = price)) +
    geom_line() +
    facet_wrap(~ name, scales = 'free_y') +
    theme_minimal() +
    theme(
      axis.text.x = element_text(angle = 90, hjust = 1)
    ) +
    labs(
      x = 'years',
      y = '€/m2',
      title = "Rent price evolution in Barcelona districts"
    )
}

draw_map_sale_price_muni_cat <- function(locations_last_price) {
  mapSpain::esp_munic.sf |>
    left_join(
      locations_last_price |>
        filter(level == 'town') |>
        filter(operation == 'sale') |>
        select(-geometry),
      by=c('name'='name')
    ) |>
    filter(ine.ccaa.name == 'Cataluña') |>
    ggplot() +
    geom_sf(aes(fill = price),
            color = "grey70",
            linewidth = .3
    ) +
    scale_fill_gradientn(
      colors = hcl.colors(10, "Blues", rev = TRUE),
      n.breaks = 10,
      guide = guide_legend(title = "Price €/m2")
    ) +
    labs(
      title = "Price evolution of sale houses in Catalonia",
      caption = "Source: Idealista",
      fill = "Price €/m2"
    )
}
