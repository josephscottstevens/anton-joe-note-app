module Main exposing (Model, Msg, init, subscriptions, update, view)

import Browser exposing (application)
import Html exposing (..)
import Html.Attributes exposing (..)
import Http



-- The Purpose
-- To Teach the complexity path
-- Start from a simple function
-- Upgrade to currying
-- Upgrade to currying + partial application
--   (This is the language of a teacher)
-- Challenge:
-- Translate to the language of the student
-- add some "you will learn"
-- add some, heres the challenge?


simpleGreet : String -> String
simpleGreet str =
    "Hello " ++ str


curriedGreet : String -> String
curriedGreet =
    \t -> "Hello " ++ t



-- How can rename the function in a meaningful way
-- How can I demonstrate this, in a creative way


customFunction : String -> (String -> String) -> String



-- How could we make this build on previous concepts, in a more intuitive way?


customFunction str myFunction =
    myFunction str



-- Lessons learned
-- mutating code while teaching, is not effective
-- What would be a better example than String.reverse? (what could we expand on?)
-- What are the goals? Why did that come last?
-- What are the specific reasons you would use currying or piping? (aka, why?)
-- Functions deserve better names, they will aid in learning.
-- re-listen to teaching elm to beginners


view : Model -> Html Msg
view model =
    div []
        [ text "model"
        , div [ style "color" "red" ] [ text model.myFavoriteString ]
        , text (simpleGreet "Bob")
        , text (curriedGreet "Bob")

        -- How could upgrade to this concept, in a nicer meaningful way?
        , text (customFunction "Some Text" String.reverse)
        , text (customFunction "Some Text" curriedGreet)
        , text (customFunction "Some Text" simpleGreet)
        ]


myOtherFunction : String -> String
myOtherFunction str =
    if String.contains "apples" str then
        "He likes nothing!"

    else
        str


greet : String -> (String -> String) -> String
greet myString myFunction =
    myFunction myString



-- learning is kind of like
--             __
--         __
--     __
-- __
-- design a learning path, that starts small -- low friction


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    { myFavoriteString : String
    }


emptyModel : Model
emptyModel =
    { myFavoriteString = ""
    }


type Msg
    = Msg1
    | GotText (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg1 ->
            ( model, Cmd.none )

        GotText result ->
            case result of
                Ok str ->
                    ( { model | myFavoriteString = str }, Cmd.none )

                Err err ->
                    ( { model | myFavoriteString = Debug.toString err }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : () -> ( Model, Cmd Msg )
init flags =
    ( emptyModel
    , Http.get
        { url = "https://s3.amazonaws.com/joe-bucket-round-1/data.json"
        , expect = Http.expectString GotText
        }
    )
