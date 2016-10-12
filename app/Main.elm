import Html exposing (Html, button, div, text)
import Html.App as App

main : Program Never
main = App.beginnerProgram { model = 0, view = view, update = update }

update : a -> a
update a = a

view : a -> Html b
view model =
    text "hello world"
