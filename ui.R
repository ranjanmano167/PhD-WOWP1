# Define UI for application 

shinyUI(fluidPage(
  
  titlePanel(strong("Modelling of Washoff")),
  
  sidebarLayout(
    sidebarPanel(
      helpText(h3("Model description", style = "color:blue"),
               h4("Model -1: Power function"),
               img(src="model1.png", height = 112, width = 201,align = "center"),
               p("Load = Mass of pollutant washed off from the surface 
                 over the period of interest (kg);"),
               p("a = Coefficient dependent on pollutant and location (unit varies);"),
               p("A = Total catchment area (ha);"),
               p("t = Duration of the time step (units of time);"),
               p("I = Rainfall intensity in the time step (mm/hour);"),
               p("b = Constant dependant on the pollutant;"),
               p("n = Number of time steps over the period of interest;"),
               h4("Model -2: Exponential function"),
               img(src="model2.png", height = 55, width = 222),
               p("Load = Mass of pollutant washed off from the surface 
                 over the period of interest (kg);"),
               p("k = Availability factor;"),
               p("Po = Mass of pollutant at the beginning of the storm (kg);"),
               p("R = Cumulative runoff depth since the start of the storm (mm);"),
               p("w = Empirical washoff coefficient (mm-1)"),
               style = "color:black"),
      
      helpText(h3("Model input", style = "color:blue")),
      
      selectInput("model", label = ("Model type"), 
                  choices = list("Exponential" = 1, "Power" = 2), 
                  selected = 1),
      
      conditionalPanel(
        condition = "input.model == '1'",
        numericInput("p", 
                     label = "Initial load (kg):", 
                     value = 100)),
      
      conditionalPanel(
        condition = "input.model == '1'",
        sliderInput("k", 
                    label = "k:",
                    min = 0, max = 1, value = 0.1,step= 0.05)),
      
      conditionalPanel(
        condition = "input.model == '1'",
        sliderInput("w", 
                    label = "w:",
                    min = 0, max = 1, value = 0.1,step= 0.05)),
      
      conditionalPanel(
        condition = "input.model == '2'",
        numericInput("area", 
                     label = "Area (ha):", 
                     value = 100)),
      
      conditionalPanel(
        condition = "input.model == '2'",
        sliderInput("a", 
                    label = "a:",
                    min = 0, max = 5, value = 1,step= 0.1)),
      
      conditionalPanel(
        condition = "input.model == '2'",
        sliderInput("b", 
                    label = "b:",
                    min = 0, max = 5, value = 1,step= 0.1)),
      
      fileInput('file1', 
                label = "Upload rainfall intensity timeseries (mm/hr)",
                accept = c('.csv'))
      
    ),  
    
    mainPanel(
      helpText(h3("Model results", style = "color:blue")),
               plotOutput("plot"))
  )
))