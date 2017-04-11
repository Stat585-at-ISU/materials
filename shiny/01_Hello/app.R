library(shiny)
require(ggplot2)
require(dplyr)

# Define UI for application that draws a histogram
ui <- fluidPage(
    # Application title
    titlePanel("Hello Shiny World!"),

    # Sidebar with a slider input for the number of bins
	sidebarPanel(
	    sliderInput("num",
		        "Number of Samples:",
		        min = 1,
		        max = 5000,
		        value = 2500),
	    numericInput("mean", "Mean: ", value=0),
	    numericInput("sd", "Standard deviation:",
	                 value = 1, min=0.0001)
	),

	# Show a plot of the generated distribution
	mainPanel(
	    plotOutput("hist")
	)
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$hist <- renderPlot({
        dist <- rnorm(n = input$num)
        gg <- data.frame(dist) %>%
          ggplot(aes(x = dist)) + geom_histogram(binwidth = 0.25) +
          xlim(c(-10,10))
        print(gg)
    })
}

# Bind ui and server together
shinyApp(ui, server)

