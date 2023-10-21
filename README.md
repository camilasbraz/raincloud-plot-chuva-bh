# Rain in Belo Horizonte with raincloud plot

### Raincloud plot

The raincloud plot is a type of hybrid visualization that allows for a more comprehensive and effective representation of data. It is formed by combining three types of charts:

Scatter plot, which presents the original data clearly and displays individual data points to highlight variations or patterns.
Violin plot (cut in half) to show the density and distribution of data. It allows you to visualize how the data is distributed and identify characteristics and nuances, such as whether the distribution is unimodal, bimodal, symmetric, or asymmetric.
Box plot, which summarizes the main statistical indicators of the dataset, including the median, quartiles, and possible outliers. This helps in identifying central trends and assessing data dispersion. (If you want to learn more about box plots, you can visit the post: link provided)
The name "Raincloud Plot" is derived from the visual similarity of the plot to a cloud with rain falling beneath it, which occurs when these three charts are plotted together and analyzed simultaneously.

Through this plot, it is possible to have a clearer view of the data and analyze them more efficiently since it combines the strengths of each of the three mentioned types of charts. Additionally, it helps avoid the problem of visualization becoming overly complex, which can happen when trying to analyze these aspects separately.

In the image generated with thi code, we have the plot in question with daily precipitation data for Belo Horizonte. I have lived in BH for 12 years, and I have always had the idea that it has been raining much less in recent years than when I arrived. To test this hypothesis, I used data from INMET (National Institute of Meteorology) and the Google Maps API to collect data from meteorological stations. The codes are on my GitHub: link provided

Through this analysis, we can see that, despite variations in precipitation volume, it maintains a constant and similar behavior. My perception of increased drought in the city may be related to rising temperatures and heatwaves. However, this analysis has some limitations that need to be investigated further for a more comprehensive analysis, such as the absence of information about precipitation in various areas.

### Data extactions

The data were collected freely from the [National Institute of Meteorology (INMET)](https://bdmep.inmet.gov.br/#) portal, wherevarious information related to data collected by weather stations, such as precipitation, temperature, humidity and wind are available for download

### Stations location with `Python`, `Google Maps API` and `pandas`

The information is collected by stations, which have a name, a latitude, and a longitude for geographic identification. To select only the stations in the city of Belo Horizonte, a code was implemented that uses the Google Maps API to search for coordinates and return the address. If Belo Horizonte is included in that address, the station was considered to be in the city, otherwise, it was not analyzed.

### Analysis and Raincloud plot with `R`, `dplyr` and `ggplot2`

To generate the raincloud plot, the station data was grouped by taking the mean over 6-year periods with the removal of null values. This data was used to feed another code created with the `tidyquant`, `ggdist`, and `ggthemes` libraries to create the raincloud plot.

### License

Project and code under the MIT License
