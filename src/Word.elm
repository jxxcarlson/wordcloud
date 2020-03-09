module Word exposing (Word, init, render)

import Svg exposing (..)
import Svg.Attributes exposing (..)


type alias Word =
    { text : String
    , x : Float
    , y : Float
    , scale : Float
    , angle : Float
    , color : String
    , opacity : Float
    }


init : String -> Word
init str =
    { text = str
    , x = 0
    , y = 0
    , scale = 1
    , angle = 0
    , color = "#000"
    , opacity = 1
    }


render : Word -> Svg msg
render w =
    let
        sc =
            "scale(" ++ String.fromFloat w.scale ++ ", " ++ String.fromFloat w.scale ++ ")" |> Debug.log "SCALE"

        rot =
            --"rotate(" ++ String.fromFloat angle ++ " " ++ String.fromFloat x_ ++ " " ++ String.fromFloat y_ ++ ")"
            "rotate(" ++ String.fromFloat w.angle ++ " 0 0)"

        tra =
            "translate(" ++ String.fromFloat w.x ++ ", " ++ String.fromFloat w.y ++ ")"

        h =
            11

        hh =
            h

        w_ =
            12 * (String.length w.text |> toFloat)
    in
    [ rect [ transform sc, x "0", y "0", fillOpacity "20%", width (String.fromFloat w_), height (String.fromFloat h), fill "#99F" ] []
    , text_ [ transform sc, fill w.color, x "0", y (String.fromFloat h) ] [ text w.text ]
    ]
        |> g [ transform tra ]
