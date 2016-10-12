module Main exposing (..)

import Html exposing (Html, button, h2, div, img, text)
import Html.App as App
import Html.Events exposing (onClick)
import Html.Attributes exposing (src)
import Task
import Json.Decode as Json
import Http
import Random


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
    = GetRandomPokemon
    | FetchPokemon Int
    | FetchSucceed String
    | FetchFail Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetRandomPokemon ->
            ( model, Random.generate FetchPokemon (Random.int 1 721) )

        FetchPokemon id ->
            ( { model
                | name = "Loading..."
                , image = "http://www.pokestadium.com/assets/img/sprites/" ++ (toString id) ++ ".png"
              }
            , getPokemon id
            )

        FetchSucceed name ->
            ( { model
                | name = name
              }
            , Cmd.none
            )

        FetchFail image ->
            init


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick GetRandomPokemon ] [ text "Get more Pokémons!" ]
        , h2 [] [ text model.name ]
        , img [ src model.image ] []
        ]


getPokemon : Int -> Cmd Msg
getPokemon pokemonId =
    let
        url =
            "http://pokeapi.co/api/v2/pokemon/" ++ (toString pokemonId) ++ "/"
    in
        Task.perform FetchFail FetchSucceed (Http.get decodePokemonName url)


decodePokemonName : Json.Decoder String
decodePokemonName =
    Json.at [ "name" ] Json.string
