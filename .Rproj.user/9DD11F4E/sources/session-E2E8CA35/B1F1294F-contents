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
                  h2("Listing Summary", class = "table_header"),
                  p("Progress across clusters", class = "table-desc"),
                  DT::dataTableOutput("summary"),
                  h3("Variable Key"),
                  tags$ol(
                    tags$li(tags$b("days_taken"), " - Days taken to complete listing"),
                    tags$li(tags$b("n"), " - Total entries"),
                    tags$li(tags$b("n_str"), " - Total structures"),
                    tags$li(tags$b("max_str"), "- Maximum structure index"),
                    tags$li(tags$b("n_hh"), "- Total households"),
                    tags$li(tags$b("max_hh"), "- Maximum household index"),
                    tags$li(tags$b("est_hh_who"), "- Estimated households (WHO)"),
                    tags$li(
                      tags$b("disc_hh"),
                      "- Proportion of listed household to WHO estimate (more than 25% discrepancy is highlighted - > 1.25 or < 0.75)"
                    ),
                    tags$li(tags$b("n_dwelling"), "- Total dwellings"),
                    tags$li(tags$b("n_non_dwelling"), "- Total non-dwellings"),
                    tags$li(tags$b("n_subs"), "- Number of submissions"),
                    tags$li(tags$b("seg_id"), "- ID of randomly chosen segment"),
                    tags$li(tags$b("seg_name"), "- Name of randomly chosen segment"),
                    tags$li(tags$b("seg_count"), "- Estimated households in randomly chosen segment")
                  )
                )
              ),
              tabPanel(
                "Segments",
                div(
                  id = "segmentTableContain",
                  style = "font-size: 90%",
                  h2("Listing Summary", class = "table_header"),
                  p("Progress across clusters", class = "table-desc"),
                  DT::dataTableOutput("segments"),
                )
              ),
              tabPanel(
                "Approved",
                div(
                  id = "segmentTableContain",
                  style = "font-size: 90%",
                  h2("Listing Summary", class = "table_header"),
                  p("Progress across clusters", class = "table-desc"),
                  DT::dataTableOutput("summary_app"),
                )
              ),
              tabPanel(
                "Rejected",
                div(
                  id = "segmentTableContain",
                  style = "font-size: 90%",
                  h2("Listing Summary", class = "table_header"),
                  p("Progress across clusters", class = "table-desc"),
                  DT::dataTableOutput("summary_rej"),
                )
              ),
              tabPanel(
                "Has Issues",
                div(
                  id = "segmentTableContain",
                  style = "font-size: 90%",
                  h2("Listing Summary", class = "table_header"),
                  p("Progress across clusters", class = "table-desc"),
                  DT::dataTableOutput("summary_hi"),
                )
              ),
              tabPanel(
                "Sample",
                div(
                  id = "segmentTableContain",
                  style = "font-size: 90%",
                  h2("Sample", class = "table_header"),
                  p("Sampled Households", class = "table-desc"),
                  p("Long format", class = "table-desc"),
                  DT::dataTableOutput("sample_long"),
                  p("Wide format (Just indexes)", class = "table-desc"),
                  DT::dataTableOutput("sample_wide")
                )
              ),
              tabPanel("Listing Data", div(
                h2("Download Processed Listing Data", class = "table_header"),
                downloadButton('download', "Download listing data")
              )), ),
  p(paste('Last updated:', timeUpdated), class = "update-text"),
  textOutput("keepAlive")
)

##textOutput("keepAlive")