# Diabetes Risk Calculator

## Overview
The Diabetes Risk Calculator is a Shiny application designed to estimate the percentage likelihood of developing diabetes based on various health and demographic factors. The application utilizes a logistic regression model trained on relevant data to provide users with personalized risk assessments.

## Features
- User-friendly interface for inputting health metrics and demographic information.
- Calculation of diabetes risk percentage based on user inputs.
- Visualization of risk factors and their impact on diabetes likelihood.
- Option to generate reports summarizing the risk assessment.

## Input Variables
Users are required to input the following variables:
- **BMI Change Percentage (Centered)**: The percentage change in Body Mass Index (BMI) centered around the mean.
- **Age (Continuous)**: The age of the user in years.
- **Gender**: The gender of the user (e.g., Male, Female).
- **Baseline A1C**: The baseline A1C level, a measure of blood sugar levels.
- **Baseline BMI**: The baseline Body Mass Index (BMI) of the user.
- **Chronic Kidney Disease (CKD)**: A binary indicator of whether the user has CKD.
- **Cardiovascular Disease (CVD)**: A binary indicator of whether the user has CVD.
- **Smoking Status**: A binary indicator of whether the user is a smoker.
- **Hypertension**: A binary indicator of whether the user has hypertension.
- **Hyperlipidemia**: A binary indicator of whether the user has hyperlipidemia.
- **Comorbidity Count**: The number of comorbid conditions the user has.

## Installation
To run the application, ensure you have R and the required packages installed. You can install the necessary packages using the `install_dependencies.R` script.

```r
# Run this in R to install required packages
source("install_dependencies.R")
```

## Running the Application
Follow these steps to run the Diabetes Risk Calculator:

1. Make sure all dependencies are installed by running the installation script first.
2. Open the project in RStudio.
3. Navigate to the app directory:
   - Load `app/global.R` first
   - Then load `app/server.R` and `app/ui.R`
4. Click the "Run App" button in RStudio or run:
   ```r
   shiny::runApp("app")
   ```
5. Alternatively, you can run the application directly with:
   ```r
   source("deploy.R")
   ```
6. Once the app is running:
   - Enter your health metrics and demographic information in the left panel
   - Click the "Calculate Risk" button
   - View your calculated diabetes risk percentage in the right panel

## Contribution
Contributions to improve the application are welcome. Please submit a pull request or open an issue for discussion.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.