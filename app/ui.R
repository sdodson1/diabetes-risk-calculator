library(shiny)

# Define the user interface for the diabetes risk calculator
ui <- fluidPage(
  titlePanel("Diabetes Risk Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("bmi_change_pct_centered", 
                   "BMI Change Percentage (Centered):", 
                   value = 0, 
                   min = -100, 
                   max = 100),
      
      numericInput("age_continuous", 
                   "Age (Continuous):", 
                   value = 30, 
                   min = 0, 
                   max = 120),
      
      selectInput("gender", 
                  "Gender:", 
                  choices = c("Male", "Female")),
      
      numericInput("baseline_a1c", 
                   "Baseline A1C (%):", 
                   value = 5.7, 
                   min = 4, 
                   max = 15),
      
      numericInput("baseline_bmi", 
                   "Baseline BMI:", 
                   value = 25, 
                   min = 10, 
                   max = 50),
      
      checkboxInput("ckd", "Chronic Kidney Disease", value = FALSE),
      checkboxInput("cvd", "Cardiovascular Disease", value = FALSE),
      checkboxInput("smoking", "Smoking Status", value = FALSE),
      checkboxInput("hypertension", "Hypertension", value = FALSE),
      checkboxInput("hyperlipidemia", "Hyperlipidemia", value = FALSE),
      
      numericInput("comorbidity_count", 
                   "Number of Comorbidities:", 
                   value = 0, 
                   min = 0, 
                   max = 10),
      
      actionButton("calculate", "Calculate Risk")
    ),
    
    mainPanel(
      h3("Calculated Risk of Developing Diabetes:"),
      verbatimTextOutput("risk_output")
    )
  )
)