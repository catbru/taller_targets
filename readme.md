# About the Project

## Overview

This R project is designed to analyze and visualize the evolution of housing prices in Catalonia. It leverages the power of the `targets` and `tarchetypes` packages to create a reproducible pipeline for data processing and visualization.

## Structure
The project is structured around a series of targets that represent the data processing and visualization tasks. Each target is a step in the pipeline, responsible for a specific piece of the analysis.

### Key Files and Directories:
- `R/idealista_functions.R`: Contains all the custom functions used in the pipeline.
- `data/`: Directory where raw data files are stored.
- `docs/`: Contains the Quarto document for presenting the analysis.

## Dependencies
This project relies on several R packages for data manipulation, visualization, and pipeline management:

- `targets`: For creating and managing the project pipeline.
- `tarchetypes`: For using target archetypes to simplify the definition of targets.
- `readr`, `dplyr`, `tidyr`, `lubridate`, `stringr`: For data manipulation and cleaning.
- `ggplot2`: For creating visualizations.
- `mapSpain`: For drawing maps specific to Spain.
- `quarto`: For creating a Quarto document to present the analysis.

## Pipeline Overview
The pipeline is defined as a series of `tar_target` calls, each representing a step in the analysis:

1. **Data Importation**: Raw data for price evolution and locations are imported from specified CSV files.
2. **Data Cleaning**: The raw data is cleaned and transformed into a more analysis-friendly format.
3. **Data Joining**: Price evolution data is joined with location data to enrich the dataset.
4. **Analysis**: Calculations and transformations are applied to prepare the data for visualization.
5. **Visualization**: Several plots are created to visualize the rent prices by province, district, and municipality.
6. **Reporting**: A Quarto document is generated to report the findings in a structured format.

## Getting Started
To use this project, clone the repository and ensure you have all the necessary R packages installed. You can run the pipeline using the `targets` package's functions, such as `tar_make()` to execute the entire pipeline or `tar_visnetwork()` to visualize the pipeline structure.
