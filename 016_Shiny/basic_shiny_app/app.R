# Load shiny package
if (!requireNamespace("shiny", quietly = TRUE)) {
  install.packages("shiny")
}
library(shiny)

# UI definition
ui <- fluidPage(
  titlePanel("Basic Shiny App"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("num",
                  "Choose a number:",
                  min = 1,
                  max = 100,
                  value = 50)
    ),

    mainPanel(
      textOutput("selected_num"),
      plotOutput("hist_plot")
    )
  )
)

# Server logic
server <- function(input, output) {

  # Show selected number
  output$selected_num <- renderText({
    paste("You selected:", input$num)
  })

  # Generate histogram
  output$hist_plot <- renderPlot({
    set.seed(123)
    data <- rnorm(100, mean = input$num, sd = 10)
    hist(data, main = "Histogram of Random Data", col = "skyblue", border = "white")
  })
}

# Run the app
shinyApp(ui = ui, server = server)
