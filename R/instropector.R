
introspector_UI <- function(id) {
  ns <- shiny::NS(id)
    shiny::fixedPanel(
      shiny::div(
        shiny::h2("Introspector"),
        shiny::actionButton(
          ns("browse_button"),
          label = "browse"
        ),
        shiny::actionButton(
          ns("update_session"),
          label = "update_session object"
        ),
        shiny::tagAppendAttributes(shiny::verbatimTextOutput(ns("session_object")),
                                        style = "width: 100%;height: 200px;overflow: scroll;"),
        shiny::tagAppendAttributes(shiny::verbatimTextOutput(ns("input_object")),
                                   style = "width: 100%;height: 200px;overflow: scroll;"),
        class = "border border-primary",
        style = "width: 100%;height: 400px;overflow: scroll;"
      ),
      bottom = 10,
      left = 10,
      draggable = T
    )
}

introspector_server <- function(id) {
  module <- function(input, output, session){

    shiny::observeEvent(
      input$browse_button,
      {
        browser()
      }
    )

    output$input_object <- shiny::renderText({
      input$update_session
      root_session <- shiny:::find_ancestor_session(session)
      input_list <- shiny::reactiveValuesToList(root_session$input)
      glue::collapse(glue::glue("{names(input_list)}: {input_list}"), sep = "\n")
    })

    output$session_object <- shiny::renderText({
      paste(capture.output(shiny:::find_ancestor_session(session)), collapse = "\n")
    })
  }
  shiny::moduleServer(id, module)
}


