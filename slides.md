# Oficina de Elm
<hr />
<h4 class="subtitle">por Roberto Soares & Rogério Chaves</h4>

<img src="images/roberto.jpeg" class="picture" />
<img src="images/rogerio.jpeg" class="picture" />

Note: apresentação

---

## Tópicos abordados

* Linguagem
* Arquitetura
* Tipos
* Erros
* Escalando

----

## Tópicos não abordados

* Interoperabilidade
* Testes
* CSS
* ...

---

## Elm?

----

## Linguagem Funcional

Esqueça o que escutou sobre funcional!

Note: esqueça: termos difíceis, idéias estranhas, ferramentas ruins

----

## Compila para JavaScript

Foco: Front-end

----

## Compilador como Assistente

Melhores mensagens de erro!

```sh
The branches of this `if` produce different types of values.

3|>  if n < 0 then
4|>  "erro!"
5|>  else
6|>  2

The `then` branch has type:

    String

But the `else` branch is:

    number

Hint: These need to match so that no matter which branch we take,
we always get back the same type of value.
```
<!-- .element: class="stretch" -->

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

Note: exemplo de código

---

## Mão na massa!

```sh
elm-repl
```

```elm
> "Hello World"
"Hello World" : String
```

```elm
> :exit
```

----

## Valores

```elm
> "hello" ++ "world"
"helloworld" : String
```

```
> (2 + 3) * 4
20 : number -- Int or Float depending on usage

> 9 / 2
4.5 : Float
```

```
> 'A'
'A' : Char
```

```
> True || False
True : Bool
```

----

## Listas

```elm
> names = [ "Alice", "Bob", "Chuck" ]
["Alice","Bob","Chuck"] : List String
```

```elm
> [1, "Mensagem"]
ERRORS!!!
```

```elm
> [True, False]
[True,False] : List Bool
```

----

## Tuplas

```elm
> (True, "yay!")
(True,"yay!") : ( Bool, String )
```

```elm
> (1,True,'a',[])
(1,True,'a',[]) : ( number, Bool, Char, List a )
```

----

## Records

```elm
> bill = { name = "Gates", age = 57 }
{ name = "Gates", age = 57 } : { age : number, name : String }
```

```elm
> bill.name
"Gates" : String

> .name bill
"Gates" : String
```

---

## Nossa primeira aplicação

---

## Entradas de usuário: Botão

```elm
type Msg = Increment | Decrement

view : Model -> Html Msg
view model =
    button [ onClick Increment ] [ text "+" ]
```

----

## Entradas de usuário: Input

```elm
type Msg = Increment | Decrement | Change String

view : Model -> Html Msg
view model =
    input [ value (toString model), onInput Change ] []
```

---

¡dale!
