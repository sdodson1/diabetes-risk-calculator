# Simple deployment script for the Diabetes Risk Calculator


# Load the pre-trained model coefficients
model_coefficients <- readRDS("data/model_coefficients.rds")

calculate_diabetes_risk <- function(bmi_change_pct_centered, age_continuous, gender, baseline_a1c, baseline_bmi, ckd, cvd, smoking, hypertension, hyperlipidemia, comorbidity_count) {
  # Load model coefficients
  model_coefficients <- readRDS("data/model_coefficients.rds")
  
  # Create a data frame for input variables
  input_data <- data.frame(
    bmi_change_pct_centered = bmi_change_pct_centered,
    age_continuous = age_continuous,
    baseline_a1c = baseline_a1c,
    baseline_bmi = baseline_bmi,
    ckd = as.numeric(ckd),
    cvd = as.numeric(cvd),
    smoking = as.numeric(smoking),
    hypertension = as.numeric(hypertension),
    hyperlipidemia = as.numeric(hyperlipidemia),
    comorbidity_count = comorbidity_count
  )
  
  # Explicitly handle gender as a dummy variable
  # If gender is 1 (Male), then genderM = 1, otherwise 0
  input_data$genderM <- ifelse(as.numeric(gender) == 1, 1, 0)
  
  # Create a vector to match model coefficients
  input_vector <- numeric(length(model_coefficients))
  names(input_vector) <- names(model_coefficients)
  
  # Handle intercept term if present
  if ("(Intercept)" %in% names(model_coefficients)) {
    input_vector["(Intercept)"] <- 1
  }
  
  # Map input values to corresponding coefficients
  for (name in names(model_coefficients)) {
    if (name == "(Intercept)") next
    if (name %in% names(input_data)) {
      input_vector[name] <- as.numeric(input_data[[name]])
    } else {
      # Handle missing variable
      warning(paste("Missing input variable:", name))
      input_vector[name] <- 0  # Default value
    }
  }
  
  # Calculate linear predictor using dot product
  linear_predictor <- sum(input_vector * model_coefficients, na.rm = TRUE)
  
  # Calculate probability using logistic function
  probability <- 1 / (1 + exp(-linear_predictor))
  
  # Convert to percentage
  risk_percentage <- probability * 100
  
  return(risk_percentage)
}

calculate_risk <- function(input_data, model_coefficients) {
  # Debug prints
  cat("Input data types:\n")
  print(sapply(input_data, class))
  
  # Convert all inputs to numeric
  input_vector <- numeric(length(model_coefficients))
  names(input_vector) <- names(model_coefficients)
  
  # Set intercept term
  input_vector[1] <- 1
  
  # Fill the vector with user inputs (skipping intercept)
  for (name in names(model_coefficients)[-1]) {
    if (name %in% names(input_data)) {
      input_vector[name] <- as.numeric(input_data[[name]])
    } else {
      # Handle missing variables
      warning(paste("Missing input variable:", name))
      input_vector[name] <- 0  # Default to zero
    }
  }
  
  # Calculate linear predictor manually (avoid matrix multiplication)
  linear_predictor <- sum(input_vector * model_coefficients)
  
  # Apply logistic function to get probability
  probability <- 1 / (1 + exp(-linear_predictor))
  
  return(probability)
}



# Define the Shiny application
shinyApp(
  ui = fluidPage(
    titlePanel("Diabetes Risk Calculator"),
    sidebarLayout(
      sidebarPanel(
        numericInput("bmi_change_pct_centered", "BMI Change (% Centered):", value = 0),
        numericInput("age_continuous", "Age (Continuous):", value = 30),
        selectInput("gender", "Gender:", choices = list("Female" = 0, "Male" = 1)),
        numericInput("baseline_a1c", "Baseline A1C:", value = 5.7),
        numericInput("baseline_bmi", "Baseline BMI:", value = 25),
        checkboxInput("ckd", "Chronic Kidney Disease:", value = FALSE),
        checkboxInput("cvd", "Cardiovascular Disease:", value = FALSE),
        checkboxInput("smoking", "Smoking:", value = FALSE),
        checkboxInput("hypertension", "Hypertension:", value = FALSE),
        checkboxInput("hyperlipidemia", "Hyperlipidemia:", value = FALSE),
        numericInput("comorbidity_count", "Comorbidity Count:", value = 0),
        actionButton("calculate", "Calculate Risk")
      ),
      mainPanel(
        textOutput("risk_output")
      )
    )
  ),
  server = function(input, output) {
    observeEvent(input$calculate, {
      risk <- calculate_diabetes_risk(
        input$bmi_change_pct_centered,
        input$age_continuous,
        input$gender,
        input$baseline_a1c,
        input$baseline_bmi,
        input$ckd,
        input$cvd,
        input$smoking,
        input$hypertension,
        input$hyperlipidemia,
        input$comorbidity_count
      )
      output$risk_output <- renderText({
        paste("Estimated Risk of Developing Diabetes: ", round(risk, 2), "%")
      })
    })
  }
)