library(tidyverse)
library(rvest)

# Start by reading a HTML page with read_html():
results <- read_html("https://elections.maryland.gov/elections/2024/Primary_Results/gen_results_2024_1.html")


#FIRST SCRAPE DEM RESULTS

# find elements that match a css selector or XPath expression
dem_candidates <- results %>% 
  html_nodes(xpath='//*[@id="primary_right_col"]/div/div[8]/table') %>%
  html_table()


#convert the tibble returned above to a data frame
dem_candidates <- as.data.frame(dem_candidates)

# remove the commas from the column total
dem_candidates$Total <- gsub(',', '', dem_candidates$Total)


#write to csv
write.csv(dem_candidates,"dem_candidates.csv", row.names = FALSE) 



# NEXT SCRAPE REPUBLICAN RESULTS

# Find elements that match a css selector or XPath expression
rep_candidates <- results %>% 
  html_nodes(xpath='//*[@id="primary_right_col"]/div/div[10]/table') %>%
  html_table()

#convert the tibble returned above to a data frame
rep_candidates <- as.data.frame(rep_candidates)

# remove the commas from the column total
rep_candidates$Total <- gsub(',', '', rep_candidates$Total)

#write to csv
write.csv(rep_candidates,"rep_candidates.csv", row.names = FALSE) 


# Start by reading a HTML page with read_html():
pres_results <- read_html("https://www.nytimes.com/interactive/2024/05/14/us/elections/results-maryland-primary.html")

# find elements that match a css selector or XPath expression
pres_candidates <- pres_results %>% 
  html_nodes(xpath='/html/body/div/main/article/section/div/div/section/section/section[2]/div[2]/div[1]/div/div/div[1]/div[1]/div[2]/table') %>%
  html_table()

#convert the tibble returned above to a data frame
pres_candidates <- as.data.frame(pres_candidates)

#this will delete the final row from the dataframe
  #Change to -2 to delete 2 rows
pres_candidates <- pres_candidates %>% filter(row_number() <= n()-1)

# remove the commas from the column votes
pres_candidates$Votes <- gsub(',', '', pres_candidates$Votes)


#write to csv
write.csv(pres_candidates,"pres_candidates.csv", row.names = FALSE) 


# Start by reading a HTML page with read_html():
test_results <- read_html("https://amarton.github.io/your-name-jour352/test-table.html")

# find elements that match a css selector or XPath expression
test_candidates <- test_results %>% 
  html_nodes(xpath='/html/body/table') %>%
  html_table()

#convert the tibble returned above to a data frame
test_candidates <- as.data.frame(test_candidates)


# remove the commas from the column votes
test_candidates$Total <- gsub(',', '', test_candidates$Total)

#this will delete the final row from the dataframe
  #Change to -2 to delete 2 rows
test_candidates <- test_candidates %>% filter(row_number() <= n()-1)


#write to csv
write.csv(test_candidates,"test_candidates.csv", row.names = FALSE) 

