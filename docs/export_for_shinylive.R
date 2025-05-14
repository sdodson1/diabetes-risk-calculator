# Install required packages if they're not already installed
if (!requireNamespace("shinylive", quietly = TRUE)) {
  install.packages("shinylive")
}
if (!requireNamespace("httpuv", quietly = TRUE)) {
  install.packages("httpuv")
}

# Load libraries
library(shinylive)
library(httpuv)

# Export the app for shinylive
shinylive::export(appdir = ".", destdir = "docs")

# Run a local server to preview the app
cat("Starting local preview server at http://localhost:8008\n")
cat("Press the stop button in RStudio or Ctrl+C to stop the server\n")
httpuv::runStaticServer("docs/", port = 8008)
