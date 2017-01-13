module TaskGroups exposing (..)

import Html exposing (Html, program, div, node, button, text, a, span)
import Html.Events exposing (onClick)
import TaskGroups.Group
import Html.Attributes exposing (href, rel, type_, class)

-- MODEL
type alias TaskGroupModel = TaskGroups.Group.Model
type alias Model = List TaskGroupModel

init : (Model, Cmd Msg)
init = ([ TaskGroups.Group.initialModel ["a", "b"]
        , TaskGroups.Group.initialModel ["c", "b"]
        ]
        , Cmd.none
       )

-- MESSAGES
type alias TaskGroupMsg = TaskGroups.Group.Msg
type Msg = NewGroup |
    TaskGroupMsg TaskGroupModel TaskGroupMsg


-- VIEW
view : Model ->  Html Msg
view model = div []
    [ stylesheet "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"
    , stylesheet "style.css"
    , stylesheet "https://fonts.googleapis.com/css?family=Open+Sans|Roboto"
    , div [ class "container" ]
        [ div [ class "row" ]
            [ div [ class "col-sm-offset-4 col-sm-4" ]
                ( List.map (\group -> Html.map (TaskGroupMsg group) (TaskGroups.Group.view group)) model )
            ]
        , div [ class "row" ]
            [ div [ class "col-sm-offset-4 col-sm-4 text-center" ]
                [ button [ class "btn btn-primary", onClick NewGroup ] [ text "create group" ] ]
            ]
        ]
    , div [ class "footer color-invert" ]
        [ div []
            [ a [ href "https://www.github.com/jakubrauch/elm-bootstrap-taskgroups" ] [ span [] [ text "https://github.com/jakubrauch/elm-bootstrap-example" ] ] ]
        ]
    ]

stylesheet : String -> Html Msg
stylesheet link =
    node "link" [ (href link), (rel "stylesheet"), (type_ "text/css") ] []

-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TaskGroupMsg group msg ->
            ((List.map (\g -> if g == group then (TaskGroups.Group.update msg g) else g) model), Cmd.none )
        NewGroup ->
            (TaskGroups.Group.group :: model, Cmd.none)

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

-- MAIN
{- program
  : { init : (model, Cmd msg)
    , update : msg -> model -> (model, Cmd msg)
    , subscriptions : model -> Sub msg
    , view : model -> Html msg
    }
  -> Program Never model msg -}
main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }