## read in the required libraries

library(shiny)
library(DT)
library(formattable)
library(readr)
library(dplyr)
library(ggplot2)
library(ggthemes)

unit.scale = function(x)
  return(x / 1)

hh_formatter <- formatter("span",
                          style = x ~ style (
                            display = "block",
                            `background-color` = ifelse(x != 6, "#F48FB1", "none")
                          ))

hh_eq_formatter <- formatter("span",
                            style = ~ style(
                              display = "block",
                              `background-color` = ifelse(!hh_equal, "#BBDEFB", "none")
                            ))

log_formatter <- formatter("span",
                          style = x ~ style (
                            display = "block",
                            `background-color` = ifelse(x, "#F48FB1", "none")
                          ))

log_formatter_ <- formatter("span",
                           style = x ~ style (
                             display = "block",
                             `background-color` = ifelse(x, "#BBDEFB", "none")
                           ))



## read in the required data
survey_summ <-
  read_csv('Data/survey_summ.csv', col_types = "iccciiicccccil")
survey_hh_summ <-
  read_csv('Data/survey_hh_summ.csv', col_types = "iccciiii")
prov_cover <-
  read_csv('Data/coverage_prov.csv', col_types = "cinin")
div_cover <-
  read_csv('Data/coverage_div.csv', col_types = "ccinin")
dist_cover <-
  read_csv('Data/coverage_dist.csv', col_types = "ccinin")
enum_cover <-
  read_csv('Data/coverage_enum.csv', col_types = "cccinin")

hh_monitor <-
  read_csv('Data/hh_monitor_filt.csv', col_types = "cciiiilliill")

hh_list <-
  read_csv('Data/survey_list.csv')

survey_summ$hh_equal <- survey_summ$n_hh == survey_summ$n_hh_child

survey_hh_summ$n_hh <- NULL

timeUpdated <- readRDS('timeUpdated.RDS')
global_coverage <- readRDS('Data/coverage_global.rds')

polio_cov <- paste0(round(global_coverage[['polio']] * 100, 1), '%')
tcv_cov <- paste0(round(global_coverage[['tcv']] * 100, 1), '%')

## format the data
formattedSummary <- formattable(
  survey_summ,
  list(
    n_hh = hh_formatter,
    n_hh_child = hh_eq_formatter,
    hh_equal = FALSE,
    hh_error = log_formatter
  )
)

formattedProvCov <- formattable(
  prov_cover,
  list(
    tcv = color_bar("#BBDEFB", fun = unit.scale),
    polio = color_bar("#BBDEFB", fun = unit.scale)
  )
)

formattedProvCov$tcv <-  percent(formattedProvCov$tcv, 0)
formattedProvCov$polio <-  percent(formattedProvCov$polio, 0)

formattedDivCov <- formattable(
  div_cover,
  list(
    tcv = color_bar("#BBDEFB", fun = unit.scale),
    polio = color_bar("#BBDEFB", fun = unit.scale)
  )
)

formattedDivCov$tcv <-  percent(formattedDivCov$tcv, 0)
formattedDivCov$polio <-  percent(formattedDivCov$polio, 0)

formattedDistCov <- formattable(
  dist_cover,
  list(
    tcv = color_bar("#BBDEFB", fun = unit.scale),
    polio = color_bar("#BBDEFB", fun = unit.scale)
  )
)

formattedDistCov$tcv <-  percent(formattedDistCov$tcv, 0)
formattedDistCov$polio <-  percent(formattedDistCov$polio, 0)

formattedEnumCov <- formattable(
  enum_cover,
  list(
    tcv = color_bar("#BBDEFB", fun = unit.scale),
    polio = color_bar("#BBDEFB", fun = unit.scale)
  )
)

formattedEnumCov$tcv <-  percent(formattedEnumCov$tcv, 0)
formattedEnumCov$polio <-  percent(formattedEnumCov$polio, 0)


formattedhhMon <- formattable(
  hh_monitor,
  list(
    check_tcv = log_formatter,
    no_cov_tcv = log_formatter_,
    check_polio = log_formatter,
    no_cov_polio = log_formatter_
  )
)


formattedSummary$cluster_code <- as.numeric(formattedSummary$cluster_code)