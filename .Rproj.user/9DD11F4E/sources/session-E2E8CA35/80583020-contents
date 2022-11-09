buttonStyle = '$("button.dt-button")
                    .css("background-color","#0D47A1")
                    .css("color","white")
                    .css("border","none");
                    return table;'

server <- function(input, output) {
  output$summary = DT::renderDataTable(server = FALSE, {
    as.datatable(
      formattedSummary,
      filter = list(position = 'top', clear = FALSE ),
      options = list(
        pageLength = 50,
        buttons = c('csv', 'excel'),
        dom = 'Bfrtip'
      ),
      extensions = 'Buttons',
      callback = JS(buttonStyle)
    )
  })
  
  output$coverage_prov = DT::renderDataTable(server = FALSE, {
    as.datatable(
      formattedProvCov,
      filter = list(position = 'top', clear = FALSE ),
      options = list(
        pageLength = 50,
        buttons = c('csv', 'excel'),
        dom = 'Bfrtip'
      ),
      extensions = 'Buttons',
      callback = JS(buttonStyle)
    )
  })
  
  output$coverage_dist = DT::renderDataTable(server = FALSE, {
    as.datatable(
      formattedDistCov,
      filter = list(position = 'top', clear = FALSE ),
      options = list(
        pageLength = 50,
        buttons = c('csv', 'excel'),
        dom = 'Bfrtip'
      ),
      extensions = 'Buttons',
      callback = JS(buttonStyle)
    )
  })
  
  output$hh_monitor = DT::renderDataTable(server = FALSE, {
    as.datatable(
      formattedhhMon,
      filter = list(position = 'top', clear = FALSE ),
      options = list(
        pageLength = 50,
        buttons = c('csv', 'excel'),
        dom = 'Bfrtip'
      ),
      extensions = 'Buttons',
      callback = JS(buttonStyle)
    )
  })
  
  output$download <- downloadHandler(
    filename = function() {
      "data.csv"
    },
    content = function(fname) {
      write.csv(hh_list, fname, na = "", row.names = F)
    }
  )
  
  output$keepAlive <- renderText({
    req(input$count)
    paste("keep alive ", input$count)
  })
}
