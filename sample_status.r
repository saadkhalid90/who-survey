sample_wide <- read_csv('who-survey-dash/Data/sample-wide.csv')
sample_long <- read_csv('who-survey-dash/Data/sample-long.csv')

roster_hh_list <- roster %>%
  group_by(cluster_code) %>%
  summarise(hh02 = unique(hh02))

roster_hh_list <-
  roster_hh_list %>% left_join(hh_entries %>% select(cluster_code, hh02, hh08_name))

getHHList <- function(clust_no, roster_hh_list) {
  clust_list <-
    roster_hh_list %>% filter(cluster_code == clust_no) %>% arrange(cluster_code, hh02)
  return(clust_list$hh02)
}

getHHListHeads <- function(clust_no, roster_hh_list) {
  clust_list <-
    roster_hh_list %>% filter(cluster_code == clust_no) %>% arrange(cluster_code, hh02)
  return(clust_list$hh08_name)
}

getSampledHHList <- function(clust_no, sample_data) {
  subset_sample_data <-
    sample_data %>% filter(cluster_code == clust_no)
  return(as.integer(subset_sample_data[1, 4:9]))
}

getSampledHHListHeads <- function(clust_no, sample_data) {
  subset_sample_data <-
    sample_data %>% filter(cluster_code == clust_no)
  return(return(subset_sample_data$head_of_house_hold))
}

getHHList(1, roster_hh_list)
getHHListHeads(1, roster_hh_list)
getSampledHHList(907, sample_wide)
getSampledHHListHeads(907, sample_long)


hh_list_vec <- c()
hh_list_head_vec <- c()
hh_sampled_list_vec <- c()
hh_sampled_list_head_vec <- c()
hh_diff_vec <- c()
hh_diff_n <- c()

for (rowIdx in 1:nrow(survey_summ)) {
  clust_code <- as.integer(survey_summ$cluster_code[rowIdx])
  if (!(is.na(clust_code))) {
    print(rowIdx)
    hh_list <- getHHList(clust_code, roster_hh_list)
    sampled_hh_list <-
      getSampledHHList(clust_code, sample_wide)
    hh_list_head <- getHHListHeads(clust_code, roster_hh_list)
    hh_sampled_list_head <-
      getSampledHHListHeads(clust_code, sample_long)
    hh_diff <- setdiff(sampled_hh_list, hh_list)
    hh_list_vec <- c(hh_list_vec, paste(hh_list, collapse = " "))
    hh_list_head_vec <-
      c(hh_list_head_vec, paste(hh_list_head, collapse = " | "))
    hh_sampled_list_vec <-
      c(hh_sampled_list_vec, paste(sampled_hh_list, collapse = " "))
    hh_sampled_list_head_vec <-
      c(hh_sampled_list_head_vec,
        paste(hh_sampled_list_head, collapse = " | "))
    hh_diff_vec <-
      c(hh_diff_vec, paste(hh_diff, collapse = " "))
    hh_diff_n <- c(hh_diff_n, length(hh_diff))
  }
}

sampled_hh_diff_df <- data.frame(
  cluster_code = survey_summ$cluster_code[!is.na(survey_summ$cluster_code)],
  hh_list = hh_list_vec,
  hh_list_head = hh_list_head_vec,
  hh_sampled_list = hh_sampled_list_vec,
  hh_sampled_list_head = hh_sampled_list_head_vec,
  hh_diff = hh_diff_vec,
  hh_diff_n = hh_diff_n
)

survey_summ <- survey_summ %>% left_join(sampled_hh_diff_df)
survey_summ$hh_error <-
  survey_summ$hh_diff_n != 6 - survey_summ$n_hh

write.csv(
  survey_summ,
  'who-survey-dash/Data/survey_summ.csv',
  row.names = F,
  na = ""
)
