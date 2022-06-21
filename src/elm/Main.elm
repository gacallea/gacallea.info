module Main exposing (Model, Msg(..), main)

import Accessibility.Aria as Aria
import Browser
import FontAwesome as Icon exposing (Icon, WithoutId)
import FontAwesome.Brands as Icon
import FontAwesome.Solid as Icon
import FontAwesome.Styles as Icon
import Html
    exposing
        ( Html
        , a
        , button
        , div
        , h1
        , img
        , main_
        , text
        )
import Html.Attributes as Attr
import Html.Events exposing (onClick)
import VitePluginHelper



-- CONSTANTS


pinne : String
pinne =
    VitePluginHelper.asset "../img/gacallea.jpg"


mysocials : List ( String, Icon WithoutId )
mysocials =
    [ ( "https://twitter.com/thecallea", Icon.twitter )
    , ( "https://www.linkedin.com/in/gacallea", Icon.linkedin )
    , ( "https://github.com/gacallea", Icon.github )
    , ( "https://gitlab.com/gacallea", Icon.gitlab )
    , ( "https://exercism.org/profiles/gacallea", Icon.code )
    , ( "https://codepen.io/gacallea", Icon.codepen )
    , ( "https://gentlewashrecords.com", Icon.recordVinyl )
    , ( "https://anerandros.info", Icon.playCircle )
    , ( "https://igghibu.xyz", Icon.images )
    ]



-- MESSAGES


type Msg
    = Increment
    | Decrement



-- MODEL


type alias Model =
    { count : Int
    }



-- INIT


initialModel : ( Model, Cmd Msg )
initialModel =
    ( { count = 0
      }
    , Cmd.none
    )



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> initialModel
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- VIEW


view : Model -> Html Msg
view model =
    main_
        [ Aria.label "main content"
        , Attr.class "flex flex-col justify-center items-center w-full h-full font-sans text-center text-neutral-content bg-info bg-opacity-50"
        ]
        [ Icon.css
        , hero model
        ]


hero : Model -> Html Msg
hero model =
    div
        [ Attr.class "hero min-h-screen bg-[url('../img/WaterLand.jpg')]"
        ]
        [ div
            [ Attr.class "hero-overlay"
            ]
            []
        , div
            [ Attr.class "hero-content min-h-fit "
            ]
            [ div
                [ Attr.class "max-w-md"
                ]
                [ img
                    [ Aria.label "Elm Logo"
                    , Attr.src pinne
                    , Attr.class "w-80 mx-auto mb-4 bg-neutral-content border-2 border-neutral-content bg-opacity-75 border-opacity-75"
                    ]
                    []
                , h1
                    [ Attr.class "mb-2 text-5xl font-bold"
                    ]
                    [ text "work in progress :)" ]
                , counter model
                , socials
                ]
            ]
        ]


socials : Html Msg
socials =
    div [ Attr.class "text-2xl" ] <|
        List.map
            (\soc ->
                a
                    [ Attr.href (Tuple.first soc)
                    , Attr.target "_blank"
                    , Attr.rel "noopener noreferrer"
                    , Attr.class "p-2"
                    ]
                    [ Icon.view (Tuple.second soc) ]
            )
            mysocials


counter : Model -> Html Msg
counter model =
    div
        [ Aria.label "Counter"
        , Attr.class "text-center mt-4 mb-5"
        ]
        [ button
            [ Aria.label "Decrease Counter"
            , Attr.class "btn btn-sm btn-outline m-2 text-neutral-content hover:bg-neutral-content hover:text-neutral"
            , onClick Decrement
            ]
            [ text "-" ]
        , text <| "Count is: " ++ String.fromInt model.count
        , button
            [ Aria.label "Increase Counter"
            , Attr.class "btn btn-sm btn-outline m-2 text-neutral-content hover:bg-neutral-content hover:text-neutral"
            , onClick Increment
            ]
            [ text "+" ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }
            , Cmd.none
            )

        Decrement ->
            ( { model | count = model.count - 1 }
            , Cmd.none
            )
