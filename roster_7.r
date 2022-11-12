seven_clusts <- survey_summ$cluster_code[survey_summ$n_hh == 7]

roster_7_list <- lapply(seven_clusts, function(x) return(unique((roster_adults_hh %>% filter(cluster_code == x))$hh02)))

roster_7 <- data.frame(do.call(rbind, roster_7_list))
roster_7$clust_no <- seven_clusts

roster_7 <- roster_7 %>% select(clust_no, everything())

write.csv(roster_7, 'roster_7.csv', row.names = F)
