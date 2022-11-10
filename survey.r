survey$age_years <- floor(as.numeric(survey$sia12a_calc1) / 365.25)
survey$age_years[survey$age_years == 15] <- 14

survey <- survey %>% select(
  c(
    "sia04_name",
    "sia03",
    "sia05",
    "sia06_sex",
    "sia07",
    "sia08",
    "sia08_other",
    "child_date_of_birth",
    "sia12a_calc1",
    "age_years",
    "sia12a_calc2",
    "sia12",
    "sia12a",
    "sia12extra_polio_calc",
    "sia12extra",
    "sia13",
    "sia14",
    "sia15",
    "sia15_other",
    "sia16",
    "sia17",
    "sia17_other",
    "sia18",
    "sia20",
    "sia20_other",
    "sia21",
    "sia22",
    "sia22_other",
    "sia23",
    "submissions_id"
  )
)



names(survey) <- c(
  "sia04",
  "sia03",
  "sia05",
  "sia06",
  "sia07",
  "sia08",
  "sia08_other",
  "dob",
  "age_days",
  "age_years",
  "tcv_elig",
  "sia12",
  "sia12a",
  "polio_elig",
  "sia12extra",
  "sia13",
  "sia14",
  "sia15",
  "sia15_other",
  "sia16",
  "sia17",
  "sia17_other",
  "sia18",
  "sia20",
  "sia20_other",
  "sia21",
  "sia22",
  "sia22_other",
  "sia23",
  "id"
)

survey_hh <- hh_entries %>% select(
  "id",
  "enumerator_name",
  "survey_date",
  "survey_time",
  "cluster_code",
  "province",
  "division",
  "district",
  "hh02"
) %>%
  right_join(survey) %>%
  left_join(hh_entries %>% select(id, supervisor_info))

survey_hh$dob <-
  as.Date(gsub(survey_hh$dob, pattern = "T.*", replacement = ""))
survey_hh$survey_date <- as.Date(survey_hh$survey_date)

write.csv(
  survey_hh,
  'who-survey-dash/Data/survey_list.csv',
  row.names = F,
  na = ""
)

year_dist <- data.frame(table(survey_hh$age_years))
