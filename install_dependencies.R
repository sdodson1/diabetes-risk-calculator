# install_dependencies.R
if (!requireNamespace("shiny", quietly = TRUE)) {
  install.packages("shiny")
}

if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}

if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}

if (!requireNamespace("broom", quietly = TRUE)) {
  install.packages("broom")
}

if (!requireNamespace("flextable", quietly = TRUE)) {
  install.packages("flextable")
}

if (!requireNamespace("officer", quietly = TRUE)) {
  install.packages("officer")
}

if (!requireNamespace("pROC", quietly = TRUE)) {
  install.packages("pROC")
}

if (!requireNamespace("data.table", quietly = TRUE)) {
  install.packages("data.table")
}

if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv")
}