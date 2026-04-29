library(projthis)
library(rmarkdown)
library(rprojroot)

# -------------------------------------------------------------------------
# Create projthis workflow and files
# -------------------------------------------------------------------------

# Create new workflow folder structure
#proj_use_workflow("workflow")

# Create new Rmd file
#proj_workflow_use_rmd("01_overview", path_proj = "workflow")

# -------------------------------------------------------------------------
# Helper for rendering Rmd files
# -------------------------------------------------------------------------

# Define the global project path (automatically resolves to project root)
proj_path <- rprojroot::find_root(rprojroot::has_file("README.md"))

# Helper function
render_file <- function(folder, subfolder = NULL, file, output_format = "all") {
  # Build the path (handles with or without subfolder)
  file_path <- if (is.null(subfolder)) {
    paste0(file.path(proj_path, folder, file), ".Rmd")
  } else {
    paste0(file.path(proj_path, folder, subfolder, file), ".Rmd")
  }
  
  if (!file.exists(file_path)) stop("File not found: ", file_path)
  
  message("\n--- Rendering: ", file_path, " ---\n")
  rmarkdown::render(file_path, output_format = output_format)
}

# ------------------------------------------------------------------------------
# Knit Rmd files
# ------------------------------------------------------------------------------

render_file("workflow", NULL, "00_build_dataset")
render_file("workflow", NULL, "01_overview")
