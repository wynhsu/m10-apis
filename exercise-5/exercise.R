### Exercise 5 ###
library(jsonlite)
library(dplyr)

# Write a function that allows you to specify a movie, then does the following:
queryMovie <- function(title) {

  # Replace all of the spaces in your movie title with plus signs (+)
  remove.space = gsub(" ", "+", title)
  
  # Construct a search query using YOUR api key
  # The base URL is https://api.nytimes.com/svc/movies/v2/reviews/search.json?
  # See the interactive console for more detail:https://developer.nytimes.com/movie_reviews_v2.json#/Console/GET/reviews/search.json
  base <- 'https://api.nytimes.com/svc/movies/v2/reviews/search.json'  
  api.key <- "&api-key=1b52fad341124f5a9c1c45a40898d181"
  search.query <- paste0(base, '?', 'query=', remove.space, api.key)
  
  # Request data using your search query
  request <- fromJSON(search.query)
  
  # What type of variable does this return?

  # Flatten the data stored in the `$results` key of the data returned to you
  flattened <- flatten(request$results)
  
  # From the most recent review, store the headline, short summary, and link to full article each in their own variables
  recent <- flattened[1,]
  headline <- recent$headline
  summary <- recent$summary_short
  link <- recent$link.url
  
  # Return an list of the three pieces of information from above
  movie.info <- list(headline=headline, summary=summary, link=link)
  return(movie.info)
}
# Test that your function works with a movie of your choice
my.movie <- queryMovie("The Dark Knight")
