# Interactive GUI for tSNE and UMAP

## Introduction

This R code provides an interactive GUI for exploring dimensionality reduction techniques on a given dataset. The script creates visualizations of tSNE and UMAP projections of the data, allowing users to interact with and manipulate the projections. The code is written in R and uses several libraries such as ggplot2, dplyr, plotly, shiny, and Rtsne among others.

## Input Data

The script starts by loading the required libraries, then reads in the input dataset using read.csv function with the file name 'data.csv'. This input file should contain the data that needs to be explored.

## UMAP & tSNE

Once the input data is loaded, the script calculates the UMAP and tSNE projections. It sets the matrix of the data to be used in the UMAP calculation by only selecting certain columns (specified by the user) of the input dataset. The user can then manually set the parameters for the UMAP calculation, including n_components, n_neighbors, and min_dist. The tSNE calculation is performed using the Rtsne function, with the user specifying the dimensions (3), perplexity (30), and the check_duplicates parameter set to FALSE.

## Plotting the Visualizations

The script creates two types of visualizations for both UMAP and tSNE: a 2D scatter plot and a 3D scatter plot. The 2D scatter plot is created using the ggplot2 library and the plotly library is used to create the interactive 3D scatter plot. The plotly visualization allows the user to rotate the plot, zoom in and out, and hover over the points to see additional information.

The script also sets various plot aesthetics such as plot title, axis text and title sizes, and point shapes and colors using the labs, theme, and scale_radius functions from ggplot2 library.

Finally, the script saves the UMAP projection data to a .csv file using the write.csv function.

## Running the Script

The code can be run from an R environment, such as RStudio. Before running the code, make sure to set the working directory to the location where the visualizations and saved .csv file will be stored.

## Conclusion

This interactive GUI for tSNE and UMAP provides a flexible and user-friendly way to explore and visualize complex datasets in reduced dimensions. By adjusting the parameters and observing the resulting visualizations, users can gain insights into the underlying structure of the data and make informed decisions on the appropriate dimensionality reduction technique to use for their specific problem.
