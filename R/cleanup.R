# Function to do what _site.yml does not
# - Keep time stamps of lecture files
# - exclude: [lectures/*.pptx]

cleanup <- function() {
  lect_pdf <- list.files("lectures", pattern="\\.pdf", full.names=TRUE)
  lect_ppt <- list.files("lectures", pattern="\\.pptx")
  site_lect_dir <- "_site/lectures/"
  file.copy(lect_pdf, site_lect_dir, copy.date = TRUE, overwrite = TRUE)
  site_lect_ppt <- list.files(site_lect_dir, pattern="\\.pptx", full.names=TRUE)
  file.remove(site_lect_ppt)
}
