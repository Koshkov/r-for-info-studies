library(tidyverse)


tuesdata<-tidytuesdayR::tt_load("2024-10-22")

# Summarise data
View(tuesdata$cia_factbook)

factbook_df<-tuesdata$cia_factbook
factbook_df %>% glimpse()
factbook_df %>% summary()

factbook_df %>%
    filter(area == 0)

factbook_df<-factbook_df %>%
    filter(area>0)

map.base<-map_data("world") 

View(map.base)

map.base %>% 
    filter(region != "Antarctica")%>%
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
