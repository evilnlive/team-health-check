module Main exposing (Model, Question, QuestionOption, init, main)

import Browser
import Html exposing (Html, button, div, h2, li, text, ul)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)



-- import Html.Attributes exposing (title)
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


type alias Vote =
    { questionOption : QuestionOption
    }


type alias Session =
    { questions : List Question
    , votes : List Vote
    }


type alias Model =
    Session


init : Model
init =
    { questions =
        [ { id = "q1", title = "Fråga 1", options = [ { id = "q1a", text = "Alternativ A" }, { id = "q1b", text = "Alternativ B" }, { id = "q1c", text = "Alternativ C" } ] }
        , { id = "q2", title = "Fråga 2", options = [ { id = "q2a", text = "Alternativ A" }, { id = "q2b", text = "Alternativ B" }, { id = "q2c", text = "Alternativ C" } ] }
        ]
    , votes = []
    }



-- UPDATE


type Msg
    = VoteOn QuestionOption


update : Msg -> Model -> Model
update msg model =
    case msg of
        VoteOn questionOption ->
            { model | votes = model.votes ++ [ { questionOption = questionOption } ] }



-- VIEW


renderQuestionOption : QuestionOption -> Html Msg
renderQuestionOption questionOption =
    li [] [ button [ onClick (VoteOn questionOption) ] [ text questionOption.text ] ]


renderQuestion : Question -> Html Msg
renderQuestion question =
    div [] [ h2 [] [ text question.title ], ul [] (List.map renderQuestionOption question.options) ]


renderQuestions : List Question -> List (Html Msg)
renderQuestions questions =
    List.map renderQuestion questions


view : Model -> Html Msg
view model =
    div []
        [ div [ class "questions" ] (renderQuestions model.questions)
        , div [ class "votes" ] [ ul [] (List.map (\a -> li [] [ text a.questionOption.text ]) model.votes) ]
        ]
