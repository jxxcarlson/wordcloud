module Wordle exposing (word)

import Svg exposing (..)
import Svg.Attributes exposing (..)


word : Float -> Float -> Float -> Float -> String -> String -> Svg msg
word x_ y_ angle scale str textColor =
    let
        sc =
            "scale(" ++ String.fromFloat scale ++ ", " ++ String.fromFloat scale ++ ")"

        rot =
            "rotate(" ++ String.fromFloat angle ++ " " ++ String.fromFloat x_ ++ " " ++ String.fromFloat y_ ++ ")"

        tr =
            sc ++ " " ++ rot
    in
    text_ [ transform tr, fill textColor, x (String.fromFloat x_), y (String.fromFloat y_) ] [ text str ]



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
