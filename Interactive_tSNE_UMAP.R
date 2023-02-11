#Author: M. Dereviankin
#Date: 11-Feb-2023
#Title: Interactive GUI tSNE & UMAP

# load ggplot2
library(ggplot2)
library(hrbrthemes)
library(tidyverse)
library(dplyr)
library(wesanderson)
library(RColorBrewer)
library(manipulate)
library(umap)
library(plotly)
library(shiny)
library(leaflet)
library(mice)
library(VIM)
library(GGally)
library(tidymodels)
library(yardstick)
library(mosaic)
library(Rtsne)

# UMAP & tSNE --------------------------------------------------------------------

#set wd to location where plots will be saved. First step is to upload the initial data. 

dt <- read.csv('data.csv')

#Run to the UMAP

df <- as.matrix(dt[, 16:29]) #remember to only set columns which will be used in the UMAP calculation

custom.config = umap.defaults  #manual settings
custom.config$n_components = 3
custom.config$n_neighbors = 10
custom.config$min_dist = 0.2

data_tsne <- Rtsne(df, dims = 3, perplexity = 30, check_duplicates = FALSE)

data_umap <-umap(df, config = custom.config)

data_raw  <- as.data.frame(data_umap$layout)

tSNE_df <- data_tsne$Y %>% 
  as.data.frame()%>%
  rename(tSNE1="V1",
         tSNE2="V2",
         tSNE3="V3")

data_plot <- cbind(data_raw, dt)

data_tsne_plot <- cbind(tSNE_df, dt)

#running graphics script. Make sure to change color and size to appropriate labels
#This is the visual that will get manipulated playing around with the UMAP parameters

UMAP_plot <- ggplot(data_plot, aes(x = V1, y = V3, color = Type)) +
  labs(title = '2D UMAP') +
  geom_point(alpha = 0.7, shape =19 ) + 
  theme_light() +
  theme(axis.text.y = element_text(size = 15),
        axis.text.x = element_text(size = 10),
        axis.title = element_text(size = 15),
        plot.title = element_text(size = 17),
        legend.text = element_text(size=15)) +
  scale_radius(range=c(4, 10))

colors <- c('#4AC6B7', '#1972A4', '#965F8A', '#FF7070', 'darkolivegreen', 'blue')

UMAP_2D <- plot_ly(data_plot, x= ~V1, y= ~V2, color = ~Type,  Type = "scatter", mode = "markers", text = ~paste('ID:', ID))

UMAP_3D <- plot_ly(data_plot, x= ~V1, y= ~V2, z= ~V3, Type="scatter3d", mode="markers", color = ~Type, text = ~paste('ID:', ID))

UMAP_3D <- UMAP_3D %>% layout(title = '3D UMAP',
                              paper_bgcolor = 'grey',
                              plot_bgcolor = 'black')

print(UMAP_plot)
print(UMAP_2D)
print(UMAP_3D)

write.csv(data_plot, "data_plot.csv")

#visual for tSNE

tSNE_plot <- ggplot(data_tsne_plot, aes(x = tSNE1, y = tSNE3, color = Type)) +
  labs(title = '2D UMAP') +
  geom_point(alpha = 0.7, shape =19 ) + 
  theme_light() +
  theme(axis.text.y = element_text(size = 15),
        axis.text.x = element_text(size = 10),
        axis.title = element_text(size = 15),
        plot.title = element_text(size = 17),
        legend.text = element_text(size=15)) +
  scale_radius(range=c(4, 10))

colors <- c('#4AC6B7', '#1972A4', '#965F8A', '#FF7070', 'darkolivegreen', 'blue')

tSNE_2D <- plot_ly(data_tsne_plot, x= ~tSNE1, y= ~tSNE2, color = ~Type,  Type = "scatter", mode = "markers", text = ~paste('ID:', ID))

tSNE_3D <- plot_ly(data_tsne_plot, x= ~tSNE1, y= ~tSNE2, z= ~tSNE3, Type="scatter3d", mode="markers", color = ~Type, text = ~paste('ID:', ID))

tSNE_3D <- tSNE_3D %>% layout(title = '3D UMAP',
                              paper_bgcolor = 'grey',
                              plot_bgcolor = 'black')

print(tSNE_plot)
print(tSNE_2D)
print(tSNE_3D)

write.csv(data_plot, "data_plot_tsne.csv")