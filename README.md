# Rain in Belo Horizonte with raincloud plot

### Raincloud plot

Visualizing and Analyzing Data with the Raincloud Plot

The Raincloud Plot is a hybrid visualization that allows you to view data in a more comprehensive and effective way. It is formed by the combination of three types of graphs:

- Scatter plot, which presents the original data clearly and shows points with individual values to highlight existing variabilities or patterns.

- Violin plot (cut in half) to show the density and distribution of the data. You can visualize how the data is distributed and identify features and nuances, such as whether the distribution is unimodal, bimodal, symmetric, or asymmetric.

- Box plot, with key statistical indicators of the summarized dataset, including the median, quartiles, and possible outliers. This helps in identifying central trends and evaluating data dispersion. (If you want to learn more about box plots, you can access the post here: [link](https://www.linkedin.com/posts/camila-sbraz_analisededados-boxplots-cienciadedados-activity-7117584103842926594-VGX8?utm_source=share&utm_medium=member_desktop))
The name "Raincloud Plot" was given due to the visual similarity of the graph to a cloud with rain falling beneath it, which occurs when these three graphs are plotted together and analyzed simultaneously.

With it, you can have a clearer view of the data and analyze it more efficiently, as it combines the strengths of each of the three types of graphs mentioned. Additionally, it avoids the problem of visualization becoming a complex task, which can occur when trying to analyze these aspects separately.

In the image in this post, we have the plot in question with daily precipitation data from Belo Horizonte. I have lived in BH for 12 years and have always had the idea that it has rained much less in recent years than when I arrived. To test this hypothesis, I used data from INMET (National Institute of Meteorology) and the Google Maps API to collect data from meteorological stations. The codes are on my GitHub: [link]

Through this analysis, we can see that the median of precipitation shows a decreasing trend, despite the data distribution following a similar pattern over the years. We also see that in the last 5 years, there have been some instances of more extreme months in terms of precipitation.

Although this analysis was superficial, with just one visualization, we can draw many ideas about what happened and, consequently, what to investigate later.
### Data extactions

The data were collected freely from the [National Institute of Meteorology (INMET)](https://bdmep.inmet.gov.br/#) portal, wherevarious information related to data collected by weather stations, such as precipitation, temperature, humidity and wind are available for download

### Stations location with `Python`, `Google Maps API` and `pandas`

The information is collected by stations, which have a name, a latitude, and a longitude for geographic identification. To select only the stations in the city of Belo Horizonte, a code was implemented that uses the Google Maps API to search for coordinates and return the address. If Belo Horizonte is included in that address, the station was considered to be in the city, otherwise, it was not analyzed.

### Analysis and Raincloud plot with `R`, `dplyr` and `ggplot2`

To generate the raincloud plot, the station data was grouped by taking the mean over 6-year periods with the removal of null values. This data was used to feed another code created with the `tidyquant`, `ggdist`, and `ggthemes` libraries to create the raincloud plot.

### License

Project and code under the MIT License
