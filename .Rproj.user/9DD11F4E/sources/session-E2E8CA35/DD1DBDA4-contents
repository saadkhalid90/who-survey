## get necessary libraries
library(dplyr)
library(readr)
library(tidyr)

## function to read in the data (credentials revised)
readInODK <- function(svcLink, dataIndex, download) {
  Sys.setenv(ODKC_URL = "https://surveygat.info/")
  Sys.setenv(ODKC_SVC = svcLink)
  Sys.setenv(ODKC_UN = "gat3@gmail.com")
  Sys.setenv(ODKC_PW = "gat23456789@")
  
  ruODK::ru_setup(
    svc = Sys.getenv("ODKC_SVC"),
    un = Sys.getenv("ODKC_UN"),
    pw = Sys.getenv("ODKC_PW"),
    tz = "Asia/Karachi",
    verbose = TRUE
  )
  
  fq_svc <- ruODK::odata_service_get()
  loc <- fs::path("media")
  
  fq_data <- ruODK::odata_submission_get(
    table = fq_svc$name[dataIndex],
    local_dir = loc,
    wkt = TRUE,
    download = download
  )
  
  return(fq_data)
}

## read in the survey data
hh_entries <-
  readInODK("https://surveygat.info/v1/projects/2/forms/3-Eligible_Children.svc",
            1,
            F)

roster_adults <-
  readInODK("https://surveygat.info/v1/projects/2/forms/3-Eligible_Children.svc",
            2,
            F)

roster_children <-
  readInODK("https://surveygat.info/v1/projects/2/forms/3-Eligible_Children.svc",
            3,
            F)

survey <-
  readInODK("https://surveygat.info/v1/projects/2/forms/3-Eligible_Children.svc",
            4,
            F)

hh_entries <- hh_entries %>% select(
  c(
    "id",
    "enumerator_name",
    "enumerator_mobile",
    "survey_day",
    "survey_time",
    "id_2",
    "detail_province_name",
    "detail_division",
    "detail_district_name",
    "detail_tehsil_name",
    "detail_unname",
    "detail_settlement_name",
    "ss_hh02",
    "ss_hh07",
    "ss_hh07_male",
    "ss_hh07_female",
    "ss_hh08_name",
    "ss_hh08_address",
    "br1_count",
    "br2_count"
  )
)

names(hh_entries) <-   c(
  "id",
  "enumerator_name",
  "enumerator_mobile",
  "survey_date",
  "survey_time",
  "cluster_code",
  "province",
  "division",
  "district",
  "tehsil",
  "uc",
  "settlement",
  "hh02",
  "hh07",
  "hh07_male",
  "hh07_female",
  "hh08_name",
  "hh08_address",
  "adult_count",
  "children_count"
)

roster_adults$roster_type <- "adult"
roster_children$roster_type <- "child"

roster_adults <- roster_adults %>% select(
  c(
    "hl2_br1",
    "hl3_br1",
    "hl3_br1_other",
    "hl4_br1",
    "dob_br1",
    "age_days_br1",
    "age_years_br1",
    "roster_type",
    "hl7_br1",
    "hl8_br1",
    "submissions_id"
  )
)

roster_children <- roster_children %>% select(
  c(
    "hl2_br2",
    "hl3_br2",
    "hl3_br2_other",
    "hl4_br2",
    "dob_br2",
    "age_days_br2",
    "age_years_br2",
    "roster_type",
    "hl7_br2",
    "hl8_br2",
    "submissions_id"
  )
)

rename_roster_vars <- c(
  "hl2",
  "hl3",
  "hl3_other",
  "hl4",
  "dob",
  "age_days",
  "age_years",
  "roster_type",
  "age_months",
  "hl8",
  "id"
)

names(roster_adults) <- rename_roster_vars
names(roster_children) <- rename_roster_vars

timeUpdated <- format(Sys.time(), "%a %b %d  %Y %X")
saveRDS(object = timeUpdated, file = 'who-survey-dash/timeUpdated.RDS')
