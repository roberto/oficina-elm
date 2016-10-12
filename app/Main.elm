import Html exposing (Html, button, div, text)
import Html.App as App

main = App.beginnerProgram { model = 0, view = view, update = update }

update a = a

view model =
    text "hello world"
