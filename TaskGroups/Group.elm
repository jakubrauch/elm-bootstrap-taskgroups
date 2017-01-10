module TaskGroups.Group exposing (..)

import Html exposing (Html, div, span, text, button, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (class)

-- MODEL
type alias Group = { tasks : List Task, text : String }
type alias Task = String
type alias Model = Group

initialModel : List Task -> Model
initialModel tasks = { tasks = tasks
                               , text = "task 3" }

group : Group
group = { tasks = [], text = "" }

-- MSG
type Msg = Remove Task | Add Task | Update Task

-- VIEW
view : Model -> Html Msg
view model = div [ class "group" ]
       (( List.map taskView model.tasks ) ++
       [ div [ class "row" ]
           [ div [ class "col-sm-offset-2 col-sm-8" ]
               [ input [ onInput Update ] []
               , button [ onClick (Add model.text) ] [ text "add" ]
               ]
           ]
       ])
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
        Add task -> { model | tasks = task :: model.tasks }
        Update task -> { model | text = task }