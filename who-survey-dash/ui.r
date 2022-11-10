## define the UI of the app


n_clusters <- nrow(survey_summ)
hh_ideal <- n_clusters * 6
hh_reached <- sum(survey_summ$n_hh)
hh_rej_notfound <- hh_ideal - hh_reached
hh_done <- sum(survey_summ$n_hh_child)
hh_no_children <- hh_reached - hh_done
n_children <- sum(survey_summ$n_children)
hh_reached_per_cluster <- round(hh_reached / n_clusters, 1)
hh_done_per_cluster <- round(hh_done / n_clusters, 1)
children_per_cluster <- round(n_children / n_clusters, 1)


ui <- basicPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  tags$head(
    HTML(
      "
          <script>
          var socket_timeout_interval
          var n = 0
          $(document).on('shiny:connected', function(event) {
          socket_timeout_interval = setInterval(function(){
          Shiny.onInputChange('count', n++)
          }, 15000)
          });
          $(document).on('shiny:disconnected', function(event) {
          clearInterval(socket_timeout_interval)
          });
          </script>
          "
    )
  ),
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"
  ),
  tabsetPanel(
    id = 'intervalDashContain',
    tabPanel(
      "Summary",
      div(
        id = "summTableContain",
        style = "font-size: 90%",
        h2("Survey Progress", class = "table_header"),
        p("Clusters-wise summaries", class = "table-desc"),
        tags$ul(
          class = "summary-list",
          tags$li("Clusters reached - ", tags$b(class = "summary-stat", n_clusters)),
          tags$li(
            "Households reached - ",
            tags$b(class = "summary-stat", hh_reached)
          ),
          tags$li(
            "Households rejected/ not found yet - ",
            tags$span(class = "summary-stat-inv", hh_rej_notfound)
          ),
          tags$li(
            "Households interviewed - ",
            tags$b(class = "summary-stat", hh_done)
          ),
          tags$li(
            "Households with no eligible children - ",
            tags$span(class = "summary-stat-inv", hh_no_children)
          ),
          tags$li("Children reached - ", tags$b(class = "summary-stat", n_children))
        ),
        tags$ul(
          class = "summary-list",
          tags$li(
            "Households reached per cluster - ",
            tags$b(class = "summary-stat-inv", hh_reached_per_cluster)
          ),
          tags$li(
            "Households interviewed per cluster - ",
            tags$span(class = "summary-stat-inv", hh_done_per_cluster)
          ),
          tags$li(
            "Children per cluster - ",
            tags$span(class = "summary-stat-inv", children_per_cluster)
          ),
        ),
        DT::dataTableOutput("summary"),
        h3("Variable Key"),
        tags$ol(
          tags$li(tags$b("n_hh"), " - Households appearing in roster"),
          tags$li(
            tags$b("n_hh_child"),
            " - Households in roster that have eligible children"
          ),
          tags$li(tags$b("n_children"), " - Children covered")
        )
      )
    ),
    tabPanel(
      "HH level summary",
      div(
        id = "hhSummTableContain",
        style = "font-size: 90%",
        h2("Household level summary", class = "table_header"),
        p("A table to review household level summary for a cluster of interest", class = "table-desc"),
        DT::dataTableOutput("survey_hh_summ"),
      )
    ),
    tabPanel(
      "Coverage",
      div(
        id = "vacTableContain",
        style = "font-size: 90%",
        h2("Vaccine Coverage", class = "table_header"),
        p("Global numbers", class = "table-desc"),
        tags$ol(class = "summary-list",
                tags$li(
                  "TCV - ", tags$b(class = "summary-stat", tcv_cov)
                ),
                tags$li(
                  "Polio - ", tags$b(class = "summary-stat", polio_cov)
                )),
        h4("Province-wise", class = "sub-header"),
        DT::dataTableOutput("coverage_prov"),
        h4("Division-wise", class = "sub-header"),
        DT::dataTableOutput("coverage_div"),
        h4("District-wise", class = "sub-header"),
        DT::dataTableOutput("coverage_dist"),
        h4("Supervisor-wise", class = "sub-header"),
        DT::dataTableOutput("coverage_enum"),
        h3("Variable Key"),
        tags$ol(
          tags$li(tags$b("elig_tcv"), " - Children eligible for TCV vaccination"),
          tags$li(tags$b("tcv"), " - Percent Children vaccinated for TCV"),
          tags$li(
            tags$b("elig_polio"),
            " - Children eligible for polio vaccination"
          ),
          tags$li(tags$b("polio"), " - Percent Children vaccinated for polio")
        )
      )
    ),
    tabPanel(
      "Age Dist.",
      div(
        class = "agePlot",
        style = "height: 700px;",
        h2("Age distribution", class = "table_header", style = "margin-bottom: 40px;"),
        div(
          class = 'controls',
          radioButtons(
            "filter_type",
            label = tags$b("Filter type:"),
            choices = list(
              "Overall" = "Overall",
              "Province" = "Province",
              "Division" = "Division"
            ),
            selected = "Overall"
          ),
          selectInput(
            "filter",
            "Filter:",
            "Names"
          )
          
        ),
        plotOutput("agePlot"),
        plotOutput("agePlotProv")
      )
    ),
    tabPanel(
      "Household Mon.",
      div(
        id = "hhMonTableContain",
        style = "font-size: 90%",
        h2("Household Monitoring", class = "table_header"),
        p(
          "The table shows households in which children from the same household have different vaccination status. The table also shows cases where no child is vaccinated for either TCV or polio.",
          class = "table-desc"
        ),
        DT::dataTableOutput("hh_monitor"),
        h3("Variable Key"),
        tags$ol(
          tags$li(
            tags$b("elig_tcv"),
            " - Children in the household eligible for TCV vaccination"
          ),
          tags$li(tags$b("count_tcv"), " - Number of children vaccinated for TCV"),
          tags$li(
            tags$b("check_tcv"),
            " - Children in the same household have different TCV vaccination status"
          ),
          tags$li(tags$b("no_cov_tcv"), " - No child found to be TCV vaccinated"),
          tags$li(
            tags$b("elig_polio"),
            " - Children in the household eligible for polio vaccination"
          ),
          tags$li(
            tags$b("count_polio"),
            " - Number of children vaccinated for polio"
          ),
          tags$li(
            tags$b("check_polio"),
            " - Children in the same household have different polio vaccination status"
          ),
          tags$li(tags$b("no_cov_polio"), " - No child found to be Polio vaccinated")
        )
      )
    ),
    tabPanel("Child level data", div(
      h3("Child level survey data", class = "sub-header"),
      downloadButton('download', "Download")
    ))
  ),
  p(paste('Last updated:', timeUpdated), class = "update-text"),
  textOutput("keepAlive")
)

##textOutput("keepAlive")