# Oficina de Elm
<hr />
<h4 class="subtitle">por Roberto Soares & Rogério Chaves</h4>

<img src="images/roberto.jpeg" class="picture" />
<img src="images/rogerio.jpeg" class="picture" />

Note: apresentação

---

## Agenda

* Linguagem
* Arquitetura
* Tipos
* Interoperabilidade
* Escalando

---

## Linguagem
## Elm?

----

## Linguagem Funcional?

Em 1º lugar - Esqueça o que escutou sobre funcional! (e programação)

Note: esqueça: termos difíceis, idéias estranhas, ferramentas ruins

----

## Rápido

![benchmark](images/benchmark.png)

<small>[Fonte](http://elm-lang.org/blog/blazing-fast-html-round-two)</small>

Note: esqueça: termos difíceis, idéias estranhas, ferramentas ruins

----

```elm
import Html exposing (Html, button, div, text)
import Html.App as App
import Html.Events exposing (onClick)

main =
  App.beginnerProgram { model = 0, view = view, update = update }

type Msg = Increment | Decrement

update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]
```
<!-- .element: class="stretch" -->

