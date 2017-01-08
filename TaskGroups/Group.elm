module TaskGroups.Group exposing (..)

import Html exposing (Html, div, span, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)

-- MODEL
type alias Group = { tasks : List Task, text : String }
type alias Task = String
type alias Model = Group

initialModel : List Task -> Model
initialModel tasks = { tasks = tasks
                               , text = "task 3" }


-- MSG
type Msg = Remove Task

-- VIEW
view : Model -> Html Msg
view model = div [ class "group" ]
       ( List.map taskView model.tasks )
taskView : Task -> Html Msg
taskView task = div []
    [ div [ class "task" ]
        [ span [] [ text task ]
        , button [ onClick (Remove task) ] [ text "remove" ]
        ]
    ]

-- UPDATE
update : Msg -> Model -> Model
update msg model =
    case msg of
        Remove task -> { model | tasks = List.filter ((/=)task) model.tasks }