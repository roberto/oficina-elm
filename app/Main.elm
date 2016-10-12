module Main exposing (..)

import Html exposing (Html, button, h2, div, img, text)
import Html.App as App
import Html.Events exposing (onClick)
import Html.Attributes exposing (src)


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


type alias Model =
    { name : String
    , image : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "MissingNo" "http://bit.ly/missingno-sprite", Cmd.none )


type Msg
    = GetPokemon


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetPokemon ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick GetPokemon ] [ text "Get more Pokémons!" ]
        , h2 [] [ text model.name ]
        , img [ src model.image ] []
        ]
