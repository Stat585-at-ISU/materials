library(shiny)
library(ggplot2)
library(dplyr)

nyc <- read.csv("nyc_emergency.csv")

shinyServer(function(input, output) {

    nyc_subset <- reactive({
        nyc %>%
            filter(Incident.Type == input$incident_type)
    })

    output$crime <- renderPlot({
        ggplot(data = nyc_subset(), aes(x = Borough, fill = Borough)) +
            geom_bar(stat = "count") +
            theme_bw() +
            ggtitle(paste("Number of", input$incident_type, "Reports by Borough"))
    })

    output$location <- renderPlot({
      ggplot(data = nyc_subset(), aes(x = Longitude, y = Latitude)) +
        geom_point(aes(colour = Borough)) +
        theme_bw() +
        ggtitle("Locations of incidents")
    })
})
