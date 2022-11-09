## define the UI of the app

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
  tabsetPanel(id = 'intervalDashContain',
              tabPanel(
                "Summary",
                div(
                  id = "summTableContain",
                  style = "font-size: 90%",
                  h2("Survey Progress", class = "table_header"),
                  p("Clusters-wise summaries", class = "table-desc"),
                  tags$ol(
                    class = "summary-list",
                    tags$li("Clusters reached - ", tags$b(class = "summary-stat", nrow(survey_summ))),
                    tags$li("Households interviewed - ", tags$b(class = "summary-stat", sum(survey_summ$n_hh_child))),
                    tags$li("Children reached - ", tags$b(class = "summary-stat", sum(survey_summ$n_children)))
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
                "Coverage",
                div(
                  id = "vacTableContain",
                  style = "font-size: 90%",
                  h2("Vaccine Coverage", class = "table_header"),
                  p("Global numbers", class = "table-desc"),
                  tags$ol(
                    class = "summary-list",
                    tags$li("TCV - ", tags$b(class = "summary-stat", tcv_cov)),
                    tags$li("Polio - ", tags$b(class = "summary-stat", polio_cov))
                  ),
                  h4("Province-wise", class = "sub-header"),
                  DT::dataTableOutput("coverage_prov"),
                  h4("District-wise", class = "sub-header"),
                  DT::dataTableOutput("coverage_dist"),
                  h3("Variable Key"),
                  tags$ol(
                    tags$li(tags$b("elig_tcv"), " - Children eligible for TCV vaccination"),
                    tags$li(tags$b("tcv"), " - Percent Children vaccinated for TCV"),
                    tags$li(tags$b("elig_polio"), " - Children eligible for polio vaccination"),
                    tags$li(tags$b("polio"), " - Percent Children vaccinated for polio")
                  )
                )
              ),
              tabPanel(
                "Household Mon.",
                div(
                  id = "hhMonTableContain",
                  style = "font-size: 90%",
                  h2("Household Monitoring", class = "table_header"),
                  p("The table shows households in which children from the same household have different vaccination status. The table also shows cases where no child is vaccinated for either TCV or polio.", class = "table-desc"),
                  DT::dataTableOutput("hh_monitor"),
                  h3("Variable Key"),
                  tags$ol(
                    tags$li(tags$b("elig_tcv"), " - Children in the household eligible for TCV vaccination"),
                    tags$li(tags$b("count_tcv"), " - Number of children vaccinated for TCV"),
                    tags$li(tags$b("check_tcv"), " - Children in the same household have different TCV vaccination status"),
                    tags$li(tags$b("no_cov_tcv"), " - No child found to be TCV vaccinated"),
                    tags$li(tags$b("elig_polio"), " - Children in the household eligible for polio vaccination"),
                    tags$li(tags$b("count_polio"), " - Number of children vaccinated for polio"),
                    tags$li(tags$b("check_polio"), " - Children in the same household have different polio vaccination status"),
                    tags$li(tags$b("no_cov_polio"), " - No child found to be Polio vaccinated")
                  )
                )
              ),tabPanel("Household list", div(
                h3("Download household list and associated data", class = "sub-header"),
                downloadButton('download', "HH List")
              ))),
  p(paste('Last updated:', timeUpdated), class = "update-text"),
  textOutput("keepAlive")
)

##textOutput("keepAlive")