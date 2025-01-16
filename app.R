# HELLO BABY YOU ARE READING CODE COMMENTS

# I LOVE YOU THIS IS FOR YOU PLEASE ENJOY

library(shiny)

# user interface
ui <- fluidPage(

  # title
  h2("My dearest darling,"),
  h1("Happy 10!"),
  h2("Please enjoy all the Leslie Knope-style praise you could ever wish for!"),
  # show a compliment
  h2(textOutput(outputId = 'compliment')),
  h3("I love you and I like you <3"),
  br(),
  br(),
  # choose random or canon praise
  radioButtons(inputId = "type", label = "What kind of praise?",
               choices = c("Random", "Canon")
  ),
  # input from user (YAYA) via action buttons 
  actionButton(inputId = 'praise', label = 'Praise', width = '100px'),
  br(),
  br(),
  br(),
  h6("How cool is this? Maybe just a little cool. But still.")
  )

# global commands to set up randomization
data <- read.csv('all_praise.csv', sep = ";") # the compliments live in this file. no peeking!
adjective <- as.vector(data$adjective)
noun <- as.vector(data$noun)

server <- function(input, output, session) {

  compliment <- eventReactive(input$praise, {
    if (input$type == "Random")
    paste(sample(adjective, 1), sample(noun, 1))
    
    else if (input$type == "Canon"){
      line <- sample(seq_along(adjective), 1)
      paste(adjective[line], noun[line])
    }
  })
  
  greeting <- eventReactive(input$praise, {
    
    # LOOK AT BANNER MICHAEL!
    # ok not banner, but if look below, here live the different greetings! extraordinary
    paste(
      sample(
        c("Oh,", "Dearest", "My", "Esteemed", "OLÁ"),
        size = 1
      ), 
      
      sample(
        c("Buba,", "Pumpkin,", "Bebe,", "Yaya,", "mi Bella,", "Білочка,", 
          "Love,", "Darling,", "Boo,", "CIVIL,"
          ),
        size = 1
      ),
      "you"
    )
  })

  # render compliment as output to the ui
  output$compliment <- renderText({ 
    paste(greeting(), compliment())
  }, sep = "")
  
  # output$greeting <- renderText({
  #   greeting()
  # })

}

shinyApp(ui = ui, server = server)


# wow you went all the way to the end! 
# have a cookie: O
