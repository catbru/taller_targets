# About the Project

## Overview

This R project is designed to analyze and visualize the evolution of housing prices in Catalonia. It leverages the power of the `targets` and `tarchetypes` packages to create a reproducible pipeline for data processing and visualization.

## Structure

The project is structured around a series of targets that represent the data processing and visualization tasks. Each target is a step in the pipeline, responsible for a specific piece of the analysis.

### Key Files and Directories:

-   `R/idealista_functions.R`: Contains all the custom functions used in the pipeline.
-   `data/`: Directory where raw data files are stored.
-   `docs/`: Contains the document for presenting the analysis.

## Dependencies

This project relies on several R packages for data manipulation, visualization, and pipeline management:

-   `targets`: For creating and managing the project pipeline.
-   `tarchetypes`: For using target archetypes to simplify the definition of targets.
-   `readr`, `dplyr`, `tidyr`, `lubridate`, `stringr`: For data manipulation and cleaning.
-   `ggplot2`: For creating visualizations.
-   `mapSpain`: For drawing maps specific to Spain.

## Pipeline Overview

The pipeline is defined as a series of `tar_target` calls, each representing a step in the analysis:

1.  **Data Importation**: Raw data for price evolution and locations are imported from specified CSV files.
2.  **Data Cleaning**: The raw data is cleaned and transformed into a more analysis-friendly format.
3.  **Data Joining**: Price evolution data is joined with location data to enrich the dataset.
4.  **Analysis**: Calculations and transformations are applied to prepare the data for visualization.
5.  **Visualization**: Several plots are created to visualize the rent prices by province, district, and municipality.
6.  **Reporting**: A Quarto document is generated to report the findings in a structured format.

## Getting Started

To use this project, clone the repository and ensure you have all the necessary R packages installed. You can run the pipeline using the `targets` package's functions, such as `tar_make()` to execute the entire pipeline or `tar_visnetwork()` to visualize the pipeline structure.

## Setup

Per configurar i començar a utilitzar aquest projecte, segueix els passos següents:

1.  **Clonar el repositori:** Clona el repositori utilitzant Git amb la comanda següent:

    ``` bash
    git clone https://github.com/catbru/taller_targets.git
    ```

2.  **Crear un projecte d'R Studio:** Utilitzant R Studio ves al directori que acabes de clonar i crea un nou projecte d'R Studio utilitzant l'opció 'using Renv'.

3.  **Activar renv:** En R Studio, obre la consola i activa l'entorn de renv amb:

    ``` r
    renv::activate()
    ```

4.  **Restaurar les dependències:** Encara en la consola, restaura les dependències del projecte amb:

    ``` r
    renv::restore()
    ```

5.  **Visualitzar la xarxa de dependències dels targets:** Per entendre millor com estan interconnectats els diferents components del projecte, pots visualitzar la xarxa de dependències dels targets amb:

    ``` r
    targets::tar_visnetwork(targets_only = TRUE)
    ```

6.  **Executar el pipeline:** Finalment, per executar el pipeline complet del projecte, utilitza la següent comanda:

    ``` r
    targets::tar_make()
    ```
