module Main exposing (..)

import Html exposing (Html, button, div, text, input)
import Html.App as App
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (value)
import String


main : Program Never
main =
    App.beginnerProgram { model = 0, view = view, update = update }


type Msg
    = Increment
    | Decrement
    | Change String


type alias Model =
    Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Change strValue ->
            case (String.toInt strValue) of
                Ok value ->
                    value

                Err _ ->
                    model


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        , div []
            [ text "Mudar para:"
            , input [ value (toString model), onInput Change ] []
            ]
        ]
