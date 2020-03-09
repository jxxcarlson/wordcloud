module Wordle exposing (render, sort, tdata, tdata2, word)

import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)


tdata : List ( String, Float )
tdata =
    [ ( "Rose", 0.3 ), ( "Lily", 0.9 ), ( "Violet", 0.5 ) ]


tdata2 =
    [ ( "Rose", 1.0 ), ( "Lily", 1.0 ), ( "Violet", 1.0 ) ]


{-| Sort list of (str, p) by decreasing value of p
-}
sort : List ( String, Float ) -> List ( String, Float )
sort data =
    List.sortBy (\( _, p ) -> -p) data


type State state a
    = Done a
    | Loop state


loop : State state a -> (state -> State state a) -> a
loop st f =
    case st of
        Done x ->
            x

        Loop st_ ->
            loop (f st_) f


render : Float -> Float -> Float -> List ( String, Float ) -> Svg msg
render x_ y_ scale data =
    let
        data_ =
            sort data

        renderWord : Int -> String -> Float -> Svg msg
        renderWord i w p =
            let
                x =
                    20

                y =
                    20 + (20.0 * toFloat i)

                color =
                    if modBy 2 i == 0 then
                        "#A00"

                    else
                        "#00A"
            in
            word x y 0 (scale * p) w color
    in
    List.indexedMap (\i ( w, p ) -> renderWord i w p) data_
        |> g [ x (String.fromFloat x_), y (String.fromFloat y_) ]


word : Float -> Float -> Float -> Float -> String -> String -> Svg msg
word x_ y_ angle scale str textColor =
    let
        sc =
            "scale(" ++ String.fromFloat scale ++ ", " ++ String.fromFloat scale ++ ")"

        rot =
            --"rotate(" ++ String.fromFloat angle ++ " " ++ String.fromFloat x_ ++ " " ++ String.fromFloat y_ ++ ")"
            "rotate(" ++ String.fromFloat angle ++ " 0 0)"

        tra =
            "translate(" ++ String.fromFloat x_ ++ ", " ++ String.fromFloat y_ ++ ")"

        h =
            11

        hh =
            h

        w =
            12 * (String.length str |> toFloat)
    in
    [ rect [ transform sc, x "0", y "0", fillOpacity "20%", width (String.fromFloat w), height (String.fromFloat h), fill "#99F" ] []
    , text_ [ transform sc, fill textColor, x "0", y (String.fromFloat h) ] [ text str ]
    ]
        |> g [ transform tra ]



--
--box : Float -> Float -> Float -> Float -> String -> String -> String -> Svg msg
--box x_ y_ w h str color textColor =
--    let
--        xx =
--            x_ + 5
--
--        yy =
--            y_ + h / 2 + 4
--    in
--    g [ transform "scale 0.25 0.25" ]
--        [ rect
--            [ fill color
--            , x (String.fromFloat x_)
--            , y (String.fromFloat y_)
--            , width (String.fromFloat w)
--            , height (String.fromFloat h)
--            ]
--            []
--        , text_ [ fill textColor, x (String.fromFloat xx), y (String.fromFloat yy) ] [ text str ]
--        ]
--
