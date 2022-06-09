module Main exposing (Model, Question, QuestionOption, init, main)

import Browser
import Html exposing (Html, button, div, h2, li, text, ul)



-- import Html.Attributes exposing (title)
-- import Html.Events exposing (onClick)
-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- MODEL


type alias QuestionOption =
    { id : String, text : String }


type alias Question =
    { id : String, title : String, options : List QuestionOption }


type alias Model =
    { questions : List Question }


init : Model
init =
    { questions =
        [ { id = "q1", title = "Fråga 1", options = [ { id = "q1a", text = "Alternativ A" }, { id = "q1b", text = "Alternativ B" }, { id = "q1c", text = "Alternativ C" } ] }
        , { id = "q2", title = "Fråga 2", options = [ { id = "q2a", text = "Alternativ A" }, { id = "q2b", text = "Alternativ B" }, { id = "q2c", text = "Alternativ C" } ] }
        ]
    }



-- UPDATE


type Msg
    = Vote


update : Msg -> Model -> Model
update msg model =
    case msg of
        Vote ->
            model



-- VIEW


renderQuestionOption : QuestionOption -> Html msg
renderQuestionOption questionOption =
    li [] [ button [] [ text questionOption.text ] ]


renderQuestion : Question -> Html msg
renderQuestion question =
    div [] [ h2 [] [ text question.title ], ul [] (List.map renderQuestionOption question.options) ]


renderQuestions : List Question -> List (Html msg)
renderQuestions questions =
    List.map renderQuestion questions


view : Model -> Html Msg
view model =
    div [] (renderQuestions model.questions)
