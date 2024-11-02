# setup (I like to put all of my libraries and settings at the top)
# You need the plotly package if you want to make something interactive
# In which case, uncomment & run Line 4
# install.packages("plotly")
library(tidyverse)
tuesdata<-tidytuesdayR::tt_load("2024-10-29")

extrafont::loadfonts(device="win")

genres.df<-tuesdata$monster_movie_genres
movies.df<-tuesdata$monster_movies

rm(tuesdata) # Remove tuesdata - we no longer need it!

# View and Summarize
####################

View(genres.df) # opens data frame in new Rstudio tab
View(movies.df)

summary(movies.df)
summary(genres.df)

# Data Cleanup and Transform 
#############################

# Combine genres and movies into a single data frame in case I need this
combined.df <- movies.df %>% 
  select(-genres) %>% # remove the "genres" column so that I don't have a duplicate
  left_join( # this function combines the two data sets 
    genres.df,
    by="tconst" # match on this column
  )

# Graphs and Plots 
####################

# Set spooky Halloween theme for our graphs!
new.theme <- theme_minimal() +
  theme(
    # You can get Grenze from Google Fonts
    plot.title=element_text(family = "Grenze", face = "bold", size = 24, colour="#b5b5b5"),
    plot.subtitle=element_text(family = "Grenze", face = "plain", size = 18, colour="#b5b5b5"),
    plot.background = element_rect(fill = "black"),
    axis.text=element_text(family="Gill Sans MT", size=12),
    axis.title=element_text(family="Gill Sans MT", size=14, colour="#b5b5b5"),
    legend.text=element_text(family="Gill Sans MT", colour="#b5b5b5"),
    legend.title=element_text(family="Gill Sans MT", size=14, colour="#b5b5b5"),
    legend.position="bottom"
  )

theme_set(new.theme)

# Plot average ratings per genre
combined.df  %>%
    group_by(genres) %>%       
    filter(!is.na(genres)) %>% # Remove all missing genres
    summarise(
        genre_rating=mean(average_rating)
    ) %>% 
    ggplot(
        aes(y=fct_reorder(genres,genre_rating), x=genre_rating),
    )+
    geom_col(fill="orange")+
    theme_minimal() +
    labs(title="Average Ratings of Movie Genres for Movies involving Monsters",
         subtitle="Spooky Graph",
         x="Ratings",
         y="Genres",
    )


# Let's see how movie ratings change over time, but let's make this an interactive plot
# Start by making a standard plot
movies.df %>% 
  mutate(
    details=paste(primary_title, genres, sep="\n") # I'm concatenating the title and the genre 
  ) %>% 
  ggplot(
    aes(x=year, y=average_rating, colour=runtime_minutes, fill=details) # for most point shapes, there is no fill; it carries forward the info for later.
  ) +
  geom_point(
    size=2
  ) +
  scale_y_continuous(
    limits=c(1,10),
    breaks=c(1:10)
  ) +
  # I know that I have one movie that is very long, so stretching the red helps visualize the data
  scale_colour_gradientn(
    colours=c("#FFF5E0", "#A73121", "#A81908", "#952323"),
    values = c(0, 0.4, 0.67, 1),
    breaks=c(60, 120, 180, 240, 300),
    guide = guide_colourbar(
      display="rectangles", nbin=6,
      theme=theme(
        legend.key.height = unit(0.5, "lines"),
        legend.text.position = "top"
      )
    )
  ) +
  # I could hide the legends in the theme, but I want the legend telling me about runtime
  # so I use guides instead to remove only the legend associated with fill
  guides( 
    fill="none" 
  ) +
  labs(
    title="Monsters on the big screen",
    subtitle="How ratings have changed over the years",
    x=NULL,
    y="Average rating",
    colour="Movie length (minutes)"
  ) -> fig # this is the same as the <- operator, but in the opposite direction

# Without interactivity, here's the plot
fig

# The plot becomes interactive with a pretty simple line of code
# but doesn't look great. Some improving required.
fig %>% plotly::ggplotly()
