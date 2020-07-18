module PhotoGroove exposing (main)

import Html exposing (div, h1, img, text, Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Browser
import Array exposing (Array)

type alias Photo =
    { url : String }

type alias Model =
    { photos : List Photo
    , selectedUrl : String
    }

type alias Msg =
    { description : String, data : String }


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [] [ text "PhotoGroove" ]
        , div [ id "thumbnails"]
            (List.map (viewTumbnail model.selectedUrl) model.photos)
        , img
            [ class "large"
            , src (urlPrefix ++ "large/" ++ model.selectedUrl)
            ]
            []
        ]

initialModel : Model
initialModel =
    { photos =
          [ { url = "1.jpeg" }
          , { url = "2.jpeg" }
          , { url = "3.jpeg" }
          ]
    , selectedUrl = "1.jpeg"
    }

urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"

viewTumbnail : String -> Photo -> Html Msg
viewTumbnail selectedUrl thumb =
    img [ src (urlPrefix ++ thumb.url)
        , classList [ ( "selected", selectedUrl == thumb.url ) ]
        , onClick { description = "ClickedPhoto", data = thumb.url}
        ]
        []

photoArray : Array Photo
photoArray =
    Array.fromList initialModel.photos

update msg model =
    if msg.description == "ClickedPhoto" then
        { model | selectedUrl = msg.data}

    else
        model

main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
