library(WDI)

# Extract data from WDI for selected countries
data <- WDI(
  country = c("CHN", "MYS", "BGD", "RWA", "IND"),
  indicator = c("NY.GDP.MKTP.CD", "NY.GDP.MKTP.KD.ZG", "CC.EST", "SL.UEM.TOTL.ZS", "BX.KLT.DINV.WD.GD.ZS"),
  start = 2000,
  end = 2023
)

# Rename columns
names(data) <- c(
  "country", "iso2c", "iso3c", "year", 
  "gdp_current_usd", "gdp_growth", 
  "control_of_corruption", "unemployment_rate", "fdi_percent_gdp"
)

# Clean data
library(dplyr)
clean_data <- data %>%
  filter(!is.na(gdp_growth), !is.na(control_of_corruption)) %>%
  filter(gdp_growth > -50, gdp_growth < 50)

# Plot GDP Growth
library(ggplot2)
ggplot(clean_data, aes(x = year, y = gdp_growth, color = country)) +
  geom_line(size = 1.2) +
  labs(
    title = "GDP Growth Trends (2000-2023)",
    x = "Year",
    y = "GDP Growth (%)",
    color = "Country"
  ) +
  theme_minimal()

# Plot Control of Corruption
ggplot(clean_data, aes(x = year, y = control_of_corruption, color = country)) +
  geom_line(size = 1.2) +
  labs(
    title = "Control of Corruption Trends (2000-2023)",
    x = "Year",
    y = "Control of Corruption Index",
    color = "Country"
  ) +
  theme_minimal()

# Plot Unemployment Rate
ggplot(clean_data, aes(x = year, y = unemployment_rate, color = country)) +
  geom_line(size = 1.2) +
  labs(
    title = "Unemployment Rate Trends (2000-2023)",
    x = "Year",
    y = "Unemployment Rate (%)",
    color = "Country"
  ) +
  theme_minimal()

# Plot FDI as % of GDP
ggplot(clean_data, aes(x = year, y = fdi_percent_gdp, color = country)) +
  geom_line(size = 1.2) +
  labs(
    title = "FDI as % of GDP (2000-2023)",
    x = "Year",
    y = "FDI (% of GDP)",
    color = "Country"
  ) +
  theme_minimal()

# Compare GDP Growth and Unemployment in Rwanda
rwanda_data <- clean_data %>% filter(country == "Rwanda")
ggplot(rwanda_data) +
  geom_line(aes(x = year, y = gdp_growth, color = "GDP Growth"), size = 1.2) +
  geom_line(aes(x = year, y = unemployment_rate, color = "Unemployment Rate"), size = 1.2) +
  labs(
    title = "Comparison of GDP Growth and Unemployment Rate in Rwanda (2000-2023)",
    x = "Year",
    y = "Percentage",
    color = "Indicator"
  ) +
  theme_minimal()
