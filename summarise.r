roster_hh_summ <- roster %>%
  group_by(cluster_code) %>%
  summarise(n_hh = length(unique(hh02)))

survey_summ <- survey_hh %>%
  group_by(cluster_code, province, division, district) %>%
  summarise(n_hh_child = length(unique(hh02)),
            n_children = n()) %>% left_join(roster_hh_summ)

survey_hh_summ <- survey_hh %>%
  group_by(cluster_code, province, division, district, hh02) %>%
  summarise(
    n_children = n(),
    elig_tcv = sum(tcv_elig == "1", na.rm = T),
    elig_polio = sum(polio_elig == "1", na.rm = T)
  ) %>% left_join(roster_hh_summ)

survey_summ <- survey_summ %>% select(
  c(
    "cluster_code",
    "province",
    "division",
    "district",
    "n_hh",
    "n_hh_child",
    "n_children"
  )
)


write.csv(
  survey_summ,
  'who-survey-dash/Data/survey_summ.csv',
  row.names = F,
  na = ""
)

write.csv(
  survey_hh_summ,
  'who-survey-dash/Data/survey_hh_summ.csv',
  row.names = F,
  na = ""
)

global_coverage <- list()
global_coverage[['tcv']] <-
  sum(survey_hh$sia12 == "1", na.rm = T) / sum(survey_hh$tcv_elig == "1", na.rm = T)
global_coverage[['polio']] <-
  sum(survey_hh$sia12extra == "1", na.rm = T) / sum(survey_hh$polio_elig == "1", na.rm = T)


coverage_prov <- survey_hh %>%
  group_by(province) %>%
  summarise(
    elig_tcv = sum(tcv_elig == "1", na.rm = T),
    tcv = sum(sia12 == "1", na.rm = T) / sum(tcv_elig == "1", na.rm = T),
    elig_polio = sum(polio_elig == "1", na.rm = T),
    polio = sum(sia12extra == "1", na.rm = T) / sum(polio_elig == "1", na.rm = T)
  )

coverage_div <- survey_hh %>%
  group_by(province, division) %>%
  summarise(
    elig_tcv = sum(tcv_elig == "1", na.rm = T),
    tcv = sum(sia12 == "1", na.rm = T) / sum(tcv_elig == "1", na.rm = T),
    elig_polio = sum(polio_elig == "1", na.rm = T),
    polio = sum(sia12extra == "1", na.rm = T) / sum(polio_elig == "1", na.rm = T)
  )

coverage_dist <- survey_hh %>%
  group_by(province, district) %>%
  summarise(
    elig_tcv = sum(tcv_elig == "1", na.rm = T),
    tcv = sum(sia12 == "1", na.rm = T) / sum(tcv_elig == "1", na.rm = T),
    elig_polio = sum(polio_elig == "1", na.rm = T),
    polio = sum(sia12extra == "1", na.rm = T) / sum(polio_elig == "1", na.rm = T)
  )

coverage_enum <- survey_hh %>%
  group_by(province, district, supervisor_info) %>%
  summarise(
    elig_tcv = sum(tcv_elig == "1", na.rm = T),
    tcv = sum(sia12 == "1", na.rm = T) / sum(tcv_elig == "1", na.rm = T),
    elig_polio = sum(polio_elig == "1", na.rm = T),
    polio = sum(sia12extra == "1", na.rm = T) / sum(polio_elig == "1", na.rm = T)
  )

write.csv(
  coverage_enum,
  'who-survey-dash/Data/coverage_enum.csv',
  row.names = F,
  na = ""
)

write.csv(
  coverage_dist,
  'who-survey-dash/Data/coverage_dist.csv',
  row.names = F,
  na = ""
)

write.csv(
  coverage_div,
  'who-survey-dash/Data/coverage_div.csv',
  row.names = F,
  na = ""
)

write.csv(
  coverage_prov,
  'who-survey-dash/Data/coverage_prov.csv',
  row.names = F,
  na = ""
)

saveRDS(global_coverage, file = 'who-survey-dash/Data/coverage_global.rds')
