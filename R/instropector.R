
introspector_UI <- function(id) {
  ns <- shiny::NS(id)

  header <- shiny::tagList(
    shiny::h2("Introspector")
  )

  footer <- shiny::tagList(
    shiny::actionButton(
      ns("browse_button"),
      label = "browse"
    ),
    shiny::actionButton(
      ns("update_session"),
      label = "update_session object"
    )
  )

  session_output <- shiny::tagAppendAttributes(
    shiny::verbatimTextOutput(ns("session_object")),
    style = "width: 100%;height: 200px;overflow: scroll;")

  input_output <- shiny::tagAppendAttributes(
    shiny::verbatimTextOutput(ns("input_object")),
    style = "width: 100%;height: 200px;overflow: scroll;")

  shiny::tagList(
    shiny::fixedPanel(
      header,
        shiny::tabsetPanel(
          shiny::tabPanel(
            title = "Input",
            input_output
          ),
          shiny::tabPanel(
            title = "Session",
            session_output
          ),
          id = ns("tabPanel"),
          type = "pills"
        ),
      footer,
        bottom = 10,
        left = 10,
        draggable = T
    ),
    shiny::tags$script(
      paste0(
        "document.getElementById('",
        ns("browse_button"),
        "').parentElement.parentElement.style.display = 'block';"
      )
    )
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
      input_list <- input_list[sort(names(input_list))]
      paste(names(input_list), ":", input_list, collapse = "\n")
    })

    output$session_object <- shiny::renderText({
      paste(capture.output(shiny:::find_ancestor_session(session)), collapse = "\n")
    })
  }
  shiny::moduleServer(id, module)
}


