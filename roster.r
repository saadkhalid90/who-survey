roster_adults_hh <- hh_entries %>% right_join(roster_adults)
roster_children_hh <- hh_entries %>% right_join(roster_children)

roster <- rbind(roster_adults_hh, roster_children_hh)
roster <- roster %>% arrange(cluster_code, hh02)
