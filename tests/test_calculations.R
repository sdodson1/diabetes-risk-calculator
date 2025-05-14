library(testthat)
source("../R/calculate_risk.R")

test_that("Risk calculation is accurate", {
  # Test case 1: Example input values
  input_values <- list(
    bmi_change_pct_centered = 5,
    age_continuous = 45,
    gender = "Male",
    baseline_a1c = 6.0,
    baseline_bmi = 28,
    ckd = 0,
    cvd = 0,
    smoking = 1,
    hypertension = 1,
    hyperlipidemia = 0,
    comorbidity_count = 2
  )
  
  expected_risk <- 0.25  # Replace with the expected risk based on the model
  
  calculated_risk <- calculate_risk(input_values)
  
  expect_equal(calculated_risk, expected_risk, tolerance = 0.01)
})

test_that("Risk calculation handles edge cases", {
  # Test case 2: Minimum input values
  input_values_min <- list(
    bmi_change_pct_centered = 0,
    age_continuous = 18,
    gender = "Female",
    baseline_a1c = 5.0,
    baseline_bmi = 18.5,
    ckd = 0,
    cvd = 0,
    smoking = 0,
    hypertension = 0,
    hyperlipidemia = 0,
    comorbidity_count = 0
  )
  
  calculated_risk_min <- calculate_risk(input_values_min)
  
  expect_true(calculated_risk_min >= 0 && calculated_risk_min <= 1)
  
  # Test case 3: Maximum input values
  input_values_max <- list(
    bmi_change_pct_centered = 20,
    age_continuous = 80,
    gender = "Male",
    baseline_a1c = 10.0,
    baseline_bmi = 40,
    ckd = 1,
    cvd = 1,
    smoking = 1,
    hypertension = 1,
    hyperlipidemia = 1,
    comorbidity_count = 5
  )
  
  calculated_risk_max <- calculate_risk(input_values_max)
  
  expect_true(calculated_risk_max >= 0 && calculated_risk_max <= 1)
})