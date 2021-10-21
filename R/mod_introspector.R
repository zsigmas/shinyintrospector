mod_instrospector <- function(module_id) {
  list(
    ui = introspector_UI,
    server = function(afmm){
      introspector_server(module_id)
    },
    module_id = module_id
  )
}
