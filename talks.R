
#  ------------------------------------------------------------------------
#
# Title : Talks
#    By : Victor
#  Date : 2019-07-15
#
#  ------------------------------------------------------------------------




# Packages ----------------------------------------------------------------

library(shufflecards)
library(htmltools)



# Talks -------------------------------------------------------------------

talks <- yaml::read_yaml(file = "talks.yml")



# Fun ---------------------------------------------------------------------

make_card <- function(params, card_width = "300px", card_height = "400px", image_height = "200px") {
  shuffle_card(
    width = card_width,
    height = card_height, 
    border = TRUE,
    when = params$when,
    name = params$name,
    thumbnail(
      href = paste0("./", params$file, ".pdf"),
      title = params$title,
      media = tags$img(
        src = file.path("imgs/", paste0(params$file, ".png"))
      ),
      content = tagList(
        tags$ul(
          tags$li("Where:", params$where),
          tags$li("Date:", params$when)
        ),
        tags$br(), tags$br(),
        tags$div(
          style = "text-align: center; position: absolute; bottom: 10px; left: 5px; right: 5px;",
          tags$a(
            type = "button", class = "btn btn-default",
            "Go to slides", style = "width: 100%;",
            href = paste0("./", params$file, ".pdf")
          )
        )
      ),
      height = "100%"
    )
  )
}



# Cards -------------------------------------------------------------------

cards <- lapply(X = talks$talks, FUN = make_card)





# fill card ---------------------------------------------------------------


# applications[["fill_card"]] <- shuffle_card(
#   width = cards_width, height = cards_height,
#   # name = "zzz", datepublish = -1,
#   `exclude-sort` = TRUE,
#   tags$p("")
# )


