library(shinydashboard)
library(shinyWidgets)
library(shiny)
library(mrgsolve)

## Dashboard Title Row
#title <- tag("font", list(size="6", "Everolimus Simulation"))
#row0 <- fluidPage(fluidRow(column(12,title,br())))

#Physiological parameters
physio <- menuItem("Change Species", icon = icon("cog", lib = "glyphicon"), #icon = icon("bar-chart-o")
         # Input directly under menuItem
         selectInput("SelectSpecies", "Spieces:",
                     choices = c("Mouse [30g]", "Rats [300g]", "Rabbit [2.5kg]", "Rhesus Monkey [5kg]", "Dog [10kg]", "Human [70kg]"), 
                     selected="Rats [300g]",
                     width = '98%')
         #,
         
         # # Input inside of menuSubItem
         # menuSubItem(icon = NULL,
         #             sliderInput("inputTest1", "Input test 2", min=0, max=10, value=5,
         #                         width = '95%')
         # ),
         # menuSubItem(icon = NULL,
         #             sliderInput("inputTest2", "Input test 2", min=0, max=10, value=2,
         #                         width = '95%')
         # )
)

# Inputs
Kabs_slider <- sliderInput("Kabs", "Kabs", 10,25,19.5,0.5)
#Kel_slider <- sliderInput("Kel", "Kel", 0.200,0.225,0.213,0.002)
CLint_slider <- sliderInput("CLint", "CLint (ml/min/kg)", 550,650,589,10)
display_selector <- selectInput("showme", "Display:", 
                              choices = c("Ci=f(t)", "Ci=f(Cu,i)", "(Ci/CBv)=f(CBv)", "Drug Abs & Rem"),
                              selected="Ci=f(t)")

bol_dose_slider <- sliderInput("bol_dose", "Dose (mg/kg)", 0,10,1,1)
bol_time_slider <- sliderInput("bol_time", "Dosing time", 0,25,2,1)
bol_freq_slider <- sliderInput("bol_ii", "Dosing freq", 1,10,1,1)
bol_addl_slider <- sliderInput("bol_addl", "Addl dose", 0,15,0,1)

inf_dose_slider <- sliderInput("inf_dose", "Dose (mg/kg)", 0,15,0,1)
inf_time_slider <- sliderInput("inf_time", "Dosing time", 0,25,5,1)
inf_freq_slider <- sliderInput("inf_ii", "Dosing freq", 1,10,1,1)
inf_rate_slider <- sliderInput("inf_rate", "Dosing rate", 0,10,0,1)
inf_addl_slider <- sliderInput("inf_addl", "Addl dose", 0,15,0,1)



## Data input - upper row
#param_row <- box(title="Parameters", Kabs_slider, Kel_slider, CLint_slider, br(), display_selector,width=2)
dosing_bol_row_1a <- box(title="Bolus dose",status="primary",background="navy",bol_dose_slider,bol_time_slider,bol_freq_slider,bol_addl_slider,width=3)
dosing_inf_row_1b <- box(title="Infusion dose",status="primary",background="navy",inf_dose_slider,inf_time_slider,inf_freq_slider,inf_rate_slider,inf_addl_slider, width=3)

## Dashboard Row 1
plot_panel <- box(plotOutput("gmplot",height="800px"), width=9)

#row1 <- fluidRow(param_row,plot_panel,dosing_bol_row_1a,dosing_inf_row_1b)
row1 <- fluidRow(plot_panel,dosing_bol_row_1a,dosing_inf_row_1b)


## Assemble pieces for dasyboard page
#logo <- tags$img(src='207490_logo_finalwhite.png', width="150px")
head <- dashboardHeader(title = "Everolimus Simulation")
#body <- dashboardBody(fluidPage(row0,row1))
body <- dashboardBody(fluidPage(row1))
side <- dashboardSidebar(sidebarMenu(br(),physio,br(),Kabs_slider, CLint_slider, br(), display_selector))


## Send it out
#dashboardPage(head,side,body,title="Everolimus Model",skin="green")
dashboardPage(head,side,body)
