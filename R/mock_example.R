run_example <- function() {
  shiny::runApp(
    system.file(
      "demo_app/app.R",
      package = "shinyintrospector",
      mustWork = T
    )
  )
}
