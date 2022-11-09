names(survey)

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
) %>% right_join(survey)

survey_hh$dob <- as.Date(gsub(survey_hh$dob, pattern = "T.*", replacement = ""))
survey_hh$survey_date <- as.Date(survey_hh$survey_date)

names(survey_hh)

survey_list <- survey_hh %>% 
  select(
    c(
      "id",
      "enumerator_name",
      "survey_date",
      "survey_time",    
      "cluster_code",
      "province",
      "division",
      "district",       
      "hh02"
    )
  )


write.csv(
  survey_list,
  'who-survey-dash/Data/survey_list.csv',
  row.names = F,
  na = ""
)
