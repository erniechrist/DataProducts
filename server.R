library(shiny)

library(ggplot2)
library(datasets)
data(mtcars)

df <- mtcars
df$cyl <- as.factor(df$cyl)
df$vs <- as.factor(df$vs)
levels(df$vs)<-c("V","straight")
df$am <- as.factor(df$am)
levels(df$am)<-c("automatic","manual")
df$gear <- as.factor(df$gear)
df$carb <- as.factor(df$carb)

shinyServer(
    function(input, output) {


        output$newPlot <- renderPlot({

            predict_var <- input$predict_var
            drawLine <-input$cbxDraw

            s_formula <- paste("mpg ~ ", predict_var)
            fit<-lm(formula=s_formula, data=df)

            slp<-fit$coef[2]
            inter<-fit$coef[1]

            if (predict_var == "cyl") {
                g2<-ggplot(aes(y=mpg, x=cyl), data = df)  + xlab("# of Cylinders")
            }
            else if (predict_var == "disp") {
                g2<-ggplot(aes(y=mpg, x=disp), data = df) + xlab("Displacement (cubic inches)")
            }
            else if (predict_var == "hp") {
                g2<-ggplot(aes(y=mpg, x=hp), data = df) + xlab("Horse Power")
            }
            else if (predict_var == "drat") {
                g2<-ggplot(aes(y=mpg, x=drat), data = df) + xlab("Rear axel ratio")
            }
            else if (predict_var == "wt") {
                g2<-ggplot(aes(y=mpg, x=wt), data = df) + xlab("Weight (per 100 lbs)")
            }
            else if (predict_var == "qsec") {
                g2<-ggplot(aes(y=mpg, x=qsec), data = df) + xlab("Quarter Mile Time (seconds)")
            }
            else if (predict_var == "vs") {
                g2<-ggplot(aes(y=mpg, x=vs), data = df) + xlab("Engine Type")
            }
            else if (predict_var == "am") {
                g2<-ggplot(aes(y=mpg, x=am), data = df) + xlab("Transmission Type")
            }
            else if (predict_var == "gear") {
                g2<-ggplot(aes(y=mpg, x=gear), data = df) + xlab("Number of Gears")
            }
            else if (predict_var == "carb") {
                g2<-ggplot(aes(y=mpg, x=carb), data = df) + xlab("Number of Carburetors")
            }
            else {}

            g2<- g2 + ggtitle("Actuals and Regression Model") + geom_point()


            if (drawLine) {
                g2<- g2 + geom_abline(intercept = inter, slope = slp, color='steelblue')
                guess_intercept <- input$numIntercept
                guess_slope <- input$numSlope
                g2<- g2 + geom_abline(intercept = guess_intercept, slope = guess_slope, color='red')

                msgActual<- paste("Actaul Intercept: ", as.character(inter),".  Actual slope: ", as.character(slp))
                msgI <- paste("Your intercept guess was off by ", as.character(guess_intercept - inter))
                msgS <- paste("Your slope guess was off by ", as.character(guess_slope - slp))

                output$txtTest <- renderPrint({ msgActual })
                output$msgIntercept <- renderPrint({ msgI })
                output$msgSlope <- renderPrint({ msgS })

            }

            if (!drawLine) {

                output$txtTest <- renderPrint({ "" })
                output$msgIntercept <- renderPrint({ "" })
                output$msgSlope <- renderPrint({ "" })

            }


            print(g2)



        })
    }
)

