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
  
  output$segments = DT::renderDataTable(server = FALSE, {
    as.datatable(
      formattedSegments,
      filter = list(position = 'top', clear = FALSE),
      options = list(
        pageLength = 50,
        buttons = c('csv', 'excel'),
        dom = 'Bfrtip'
      ),
      extensions = 'Buttons',
      callback = JS(buttonStyle)
    )
  })
  
  output$summary_app = DT::renderDataTable(server = FALSE, {
    as.datatable(
      formattedSummaryApp,
      filter = list(position = 'top', clear = FALSE),
      options = list(
        pageLength = 50,
        buttons = c('csv', 'excel'),
        dom = 'Bfrtip'
      ),
      extensions = 'Buttons',
      callback = JS(buttonStyle)
    )
  })
  
  output$summary_rej = DT::renderDataTable(server = FALSE, {
    as.datatable(
      formattedSummaryRej,
      filter = list(position = 'top', clear = FALSE),
      options = list(
        pageLength = 50,
        buttons = c('csv', 'excel'),
        dom = 'Bfrtip'
      ),
      extensions = 'Buttons',
      callback = JS(buttonStyle)
    )
  })
  
  output$summary_hi = DT::renderDataTable(server = FALSE, {
    as.datatable(
      formattedSummaryHi,
      filter = list(position = 'top', clear = FALSE),
      options = list(
        pageLength = 50,
        buttons = c('csv', 'excel'),
        dom = 'Bfrtip'
      ),
      extensions = 'Buttons',
      callback = JS(buttonStyle)
    )
  })
  
  output$sample_long = DT::renderDataTable(
    sample_long, options = list(
      pageLength = 50,
      buttons = c('csv', 'excel'),
      dom = 'Bfrtip'
    ),
    filter = list(position = 'top', clear = FALSE),
    extensions = 'Buttons',
    callback = JS(buttonStyle)
  )
  
  output$sample_wide = DT::renderDataTable(
    sample_wide, options = list(
      pageLength = 50,
      buttons = c('csv', 'excel'),
      dom = 'Bfrtip'
    ),
    filter = list(position = 'top', clear = FALSE),
    extensions = 'Buttons',
    callback = JS(buttonStyle)
  )

  output$download <- downloadHandler(
    filename = function() {
      "data.csv"
    },
    content = function(fname) {
      write.csv(listing, fname, na = "", row.names = F)
    }
  )
  
  output$keepAlive <- renderText({
    req(input$count)
    paste("keep alive ", input$count)
  })
}
