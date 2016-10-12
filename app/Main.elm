module Main exposing (..)

import Html exposing (Html, button, h2, div, img, text)
import Html.App as App
import Html.Events exposing (onClick)
import Html.Attributes exposing (src)
import Task
import Json.Decode as Json
import Http
import Random
import Time exposing (Time, second)
import Date exposing (Date, fromTime)


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every second Tick


type alias Model =
    { pokemon : Pokemon
    , date : Date
    }


type alias Pokemon =
    { name : String
    , image : String
    }


init : ( Model, Cmd Msg )
init =
    ( { pokemon =
            { name = "MissingNo"
            , image = "http://bit.ly/missingno-sprite"
            }
      , date = fromTime 0
      }
    , Cmd.none
    )


type Msg
    = GetRandomPokemon
    | FetchPokemon Int
    | FetchSucceed String
    | FetchFail Http.Error
    | Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetRandomPokemon ->
            ( model, Random.generate FetchPokemon (Random.int 1 721) )

        FetchPokemon id ->
            ( { model
                | pokemon =
                    { name = "Loading..."
                    , image = "http://www.pokestadium.com/assets/img/sprites/" ++ (toString id) ++ ".png"
                    }
              }
            , getPokemon id
            )

        FetchSucceed name ->
            ( { model
                | pokemon =
                    { name = name
                    , image = model.pokemon.image
                    }
              }
            , Cmd.none
            )

        FetchFail image ->
            init

        Tick time ->
            ( { model | date = fromTime time }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick GetRandomPokemon ] [ text "Get more Pokémons!" ]
        , model.date
            |> toString
            |> text
        , pokemonView model.pokemon
        ]


pokemonView : Pokemon -> Html Msg
pokemonView pokemon =
    div []
        [ h2 [] [ text pokemon.name ]
        , img [ src pokemon.image ] []
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
