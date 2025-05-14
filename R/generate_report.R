library(officer)
library(flextable)

generate_report <- function(risk_percentage, input_data) {
  # Create a new Word document
  doc <- read_docx()
  
  # Add title
  doc <- body_add_par(doc, "Diabetes Risk Assessment Report", style = "heading 1")
  
  # Add input data summary
  doc <- body_add_par(doc, "Input Data Summary:", style = "heading 2")
  input_summary <- data.frame(
    Variable = names(input_data),
    Value = unlist(input_data)
  )
  ft_input <- flextable(input_summary)
  doc <- body_add_flextable(doc, ft_input)
  
  # Add risk percentage
  doc <- body_add_par(doc, paste("Calculated Risk of Developing Diabetes: ", round(risk_percentage, 2), "%", sep = ""), style = "heading 2")
  
  # Add conclusion
  doc <- body_add_par(doc, "Conclusion:", style = "heading 2")
  doc <- body_add_par(doc, "This report summarizes the calculated risk of developing diabetes based on the provided input data. Please consult with a healthcare professional for further advice.", style = "Normal")
  
  # Save the document
  output_file <- "Diabetes_Risk_Report.docx"
  print(doc, target = output_file)
  
  return(output_file)
}