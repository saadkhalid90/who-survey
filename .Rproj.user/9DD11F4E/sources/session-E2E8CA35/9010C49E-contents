hh_monitor <- survey_hh %>%
  group_by(province, district, cluster_code, hh02) %>%
  summarise(
    elig_tcv = sum(tcv_elig == "1", na.rm = T),
    count_tcv = sum(sia12 == "1", na.rm = T),
    check_tcv = !(sum(sia12 == "1", na.rm = T) == 0 |
                    (
                      sum(sia12 == "1", na.rm = T) == sum(tcv_elig == "1", na.rm = T)
                    )),
    no_cov_tcv = sum(sia12 == "1", na.rm = T) == 0 & sum(tcv_elig == "1", na.rm = T) != 0,
    elig_polio = sum(polio_elig == "1", na.rm = T),
    count_polio = sum(sia12extra == "1", na.rm = T),
    check_polio = !(sum(sia12extra == "1", na.rm = T) == 0 |
                    (
                      sum(sia12extra == "1", na.rm = T) == sum(polio_elig == "1", na.rm = T)
                    )),
    no_cov_polio = sum(sia12extra == "1", na.rm = T) == 0 & sum(polio_elig == "1", na.rm = T) != 0,
  ) 


hh_monitor_filt <- hh_monitor %>% 
  filter(check_tcv | check_polio | no_cov_tcv | no_cov_polio)

hh_monitor_cool <- hh_monitor %>% 
  filter(!check_tcv & !check_polio & !no_cov_tcv & !no_cov_polio)


write.csv(
  hh_monitor_filt,
  'who-survey-dash/Data/hh_monitor_filt.csv',
  row.names = F,
  na = ""
)


