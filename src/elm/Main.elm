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
import VitePluginHelper exposing (asset)



-- TYPES


type alias Social =
    { name : String
    , url : String
    , icon : Icon WithoutId
    }



-- CONSTANTS


pinne : String
pinne =
    asset "../img/gacallea.jpg"


mysocials : List Social
mysocials =
    [ { name = "Twitter", url = "https://twitter.com/thecallea", icon = Icon.twitter }
    , { name = "LinkedIn", url = "https://www.linkedin.com/in/gacallea", icon = Icon.linkedin }
    , { name = "Github", url = "https://github.com/gacallea", icon = Icon.github }
    , { name = "Gitlab", url = "https://gitlab.com/gacallea", icon = Icon.gitlab }
    , { name = "Exercism", url = "https://exercism.org/profiles/gacallea", icon = Icon.code }
    , { name = "Codepen", url = "https://codepen.io/gacallea", icon = Icon.codepen }
    , { name = "Gentle Wash Records", url = "https://gentlewashrecords.com", icon = Icon.recordVinyl }
    , { name = "Aner Andros", url = "https://anerandros.info", icon = Icon.playCircle }
    , { name = "Igghibu Zwandir", url = "https://igghibu.xyz", icon = Icon.images }
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
        , Attr.class "flex flex-col justify-center items-center w-full h-full font-sans text-center text-neutral-content"
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
                [ Attr.class "max-w-lg"
                ]
                [ img
                    [ Aria.label "Andrea"
                    , Attr.src pinne
                    , Attr.class "w-80 mx-auto mb-4 border-2 border-neutral-content border-opacity-75"
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
    div [] <|
        List.map
            (\soc ->
                a
                    [ Attr.href soc.url
                    , Attr.target "_blank"
                    , Attr.rel "noopener noreferrer"
                    , Attr.class "btn btn-outline btn-circle m-[0.12rem] text-xl"
                    , Attr.alt soc.name
                    , Attr.title soc.name
                    , Aria.label soc.name
                    ]
                    [ Icon.view soc.icon ]
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
