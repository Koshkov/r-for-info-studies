#
# Week 1 Activity
# Visualizing Geographic Data
# 2024-10-24
#
####################

# R 101
###################
# - Any line that begins with a '#' is a comment and will not be interpreted as code
# - The arrow symbol '<-' is called the assignment operater 

# The library function loads tidyverse into our environment and allows us to access
# its functions
library(tidyverse) 

# The following line pulls in data from the Tidy Tuesday Repository
tuesdata<-tidytuesdayR::tt_load("2024-10-22") 
factbook_df<-tuesdata$cia_factbook

# We can use the view function to look at the data in an Excel style table
View(tuesdata$cia_factbook)

# The %>% or 'pipe' symbol allows us to 
factbook_df %>% glimpse()
factbook_df %>% summary()

factbook_df %>%
    filter(area == 0)

factbook_df<-factbook_df %>%
    filter(area>0)

map.base<-map_data("world") 

# We can create a simple map of the world using ggplot.
# ggplot is a function that allows us to quickly make robust charts.
map.base %>% 
    filter(region != "Antarctica")%>% # Remove Antarctica 
    ggplot(
        aes(x=long, y=lat)
    )+
    geom_polygon(
        aes(group=group, fill=region),
        color="black"
    )+
    theme_void()+
    guides(fill="none")


# Joining data sets
factbook_df %>% 
   rename(region=country) %>%
    anti_join(map.base, by="region")

map_df<- factbook_df %>% 
   rename(region=country) %>%
    left_join(map.base, by="region")
View(map_df)

map_df %>% 
    filter(region != "Antarctica")%>%
    ggplot(
        aes(x=long, y=lat)
    )+
    geom_polygon(
        aes(group=group, fill=internet_users/population),
        color="black"
    )+
    theme_void()

map_df %>% 
    filter(region != "Antarctica")%>%
    ggplot(
        aes(x=long, y=lat)
    )+
    geom_polygon(
        aes(group=group, fill=population_growth_rate),
        color="black"
    )+
    theme_void()
