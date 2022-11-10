buttonStyle = '$("button.dt-button")
                    .css("background-color","#0D47A1")
                    .css("color","white")
                    .css("border","none");
                    return table;'

province_list <- sort(unique(hh_list$province))
division_list <- sort(unique(hh_list$division))

server <- function(input, output, session) {
  subset_hh_list <- reactive({
    req(input$filter_type)
    req(input$filter)
    if (input$filter_type == "Overall") {
      df <- hh_list
    }
    else {
      if (input$filter_type == "Division") {
        df <- hh_list %>% filter(division == input$filter)
      } else {
        df <- hh_list %>% filter(province == input$filter)
      }
    }
  })
  
  output$summary = DT::renderDataTable(server = FALSE, {
    as.datatable(
      formattedSummary,
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
  
  output$survey_hh_summ = DT::renderDataTable(
    survey_hh_summ,
    filter = list(position = 'top', clear = FALSE),
    options = list(
      pageLength = 50,
      buttons = c('csv', 'excel'),
      dom = 'Bfrtip'
    ),
    extensions = 'Buttons',
    callback = JS(buttonStyle)
  )

output$coverage_prov = DT::renderDataTable(server = FALSE, {
  as.datatable(
    formattedProvCov,
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

output$coverage_div = DT::renderDataTable(server = FALSE, {
  as.datatable(
    formattedDivCov,
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

output$coverage_dist = DT::renderDataTable(server = FALSE, {
  as.datatable(
    formattedDistCov,
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

output$coverage_enum = DT::renderDataTable(server = FALSE, {
  as.datatable(
    formattedEnumCov,
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

customUpdateSI <- function(session, inputName, choices) {
  return(updateSelectInput(session,
                           inputName,
                           choices = choices))
}

observe({
  if (input$filter_type == "Overall") {
    customUpdateSI(session, "filter", c(""))
  }
  if (input$filter_type == "Province") {
    customUpdateSI(session, "filter", province_list)
  }
  if (input$filter_type == "Division") {
    customUpdateSI(session, "filter", division_list)
  }
})

output$agePlot <- renderPlot(width = 800,
                             height = 500,
                             res = 96,
                             {
                               ggplot(data = data.frame(table(subset_hh_list()$age_years)), aes(x = Var1, y = Freq)) +
                                 geom_bar(stat = "identity",
                                          fill = "steelblue",
                                          width = 0.85) +
                                 theme_hc() + labs(x = "Age (completed years)", y = "Frequency") + theme(
                                   plot.margin =  margin(
                                     t = 30,
                                     b = 20,
                                     r = 15,
                                     l = 30
                                   ),
                                   axis.text = element_text(size = 8),
                                   axis.title = element_text(size = 10)
                                 ) + ggtitle("Distribution of children's age")
                             })

output$hh_monitor = DT::renderDataTable(server = FALSE, {
  as.datatable(
    formattedhhMon,
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
