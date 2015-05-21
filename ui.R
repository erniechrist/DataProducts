library(shiny)

shinyUI(
    pageWithSidebar(
        headerPanel("Guess the Linear Regression"),
        sidebarPanel(
            HTML("<br><I><strong>Step One</I></strong><br>"),
            "Select a variable to see the actual MPG values",
            radioButtons("predict_var", "Predictor variable",
                         c("# of Cylinders" = "cyl",
                           "Displacement (cubic inches)" = "disp",
                           "Horse Power" = "hp",
                           "Rear axel ratio" = "drat",
                           "Weight (per 100 lbs)" = "wt",
                           "Quarter Mile Time (seconds)" = "qsec",
                           "Engine Type" = "vs",
                           "Transmission Type" = "am",
                           "Number of Gears" = "gear",
                           "Number of Carburetors" = "carb"
                            ),
                         selected="am"
            ),
            HTML("<strong><I>Step Two</I></strong>,<br>"),
            HTML("Enter your guesses<br>"),
            numericInput("numIntercept","Intercept",0),
            numericInput("numSlope","Slope",0),
            HTML("<strong><I>Step Three</I></strong><br>"),
            checkboxInput("cbxDraw", label = "Show regression lines", value = FALSE),
            helpText("Actual regression line will be shown in blue, your guess will be shown in red."),
            HTML("<strong><I>Try Again</I></strong><br>"),
            helpText("Unselect the checkbox and selecta new variable")
        ),
        mainPanel(
            plotOutput('newPlot'),
            verbatimTextOutput("txtTest"),
            verbatimTextOutput("msgIntercept"),
            verbatimTextOutput("msgSlope")
        )
    )
)
