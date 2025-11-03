# library(shiny)

parameter_tabs <- shiny::tabsetPanel(
  id = "params",
  type = "hidden",
  shiny::tabPanel(
    "normal",
    shiny::numericInput("mean", "mean", value = 1),
    shiny::numericInput("sd", "standard deviation", min = 0, value = 1)
  ),
  shiny::tabPanel(
    "uniform",
    shiny::numericInput("min", "min", value = 0),
    shiny::numericInput("max", "max", value = 1)
  ),
  shiny::tabPanel(
    "exponential",
    shiny::numericInput("rate", "rate", value = 1, min = 0),
  )
)

ui <- shiny::fluidPage(
  shiny::sidebarLayout(
    shiny::sidebarPanel(
      shiny::selectInput(
        "dist",
        "Distribution",
        choices = c("normal", "uniform", "exponential")
      ),
      shiny::numericInput("n", "Number of samples", value = 100),
      parameter_tabs,
    ),
    shiny::mainPanel(
      shiny::plotOutput("hist")
    )
  )
)

server <- function(input, output, session) {
  shiny::observeEvent(input$dist, {
    shiny::updateTabsetPanel(inputId = "params", selected = input$dist)
  })

  sample <- shiny::reactive({
    switch(
      input$dist,
      normal = stats::rnorm(input$n, input$mean, input$sd),
      uniform = stats::runif(input$n, input$min, input$max),
      exponential = stats::rexp(input$n, input$rate)
    )
  })
  output$hist <- shiny::renderPlot(graphics::hist(sample()), res = 96)
}


shiny::shinyApp(ui, server)
