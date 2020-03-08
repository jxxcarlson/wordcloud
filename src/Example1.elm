module Example1 exposing (main)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Wordle exposing (word)


main =
    svg
        [ version "1.1"
        , x "0"
        , y "0"
        , viewBox "0 0 400 400"
        ]
        [ word 20 40 0 0.5 "Hello!" "#800"
        , word 30 30 90 1.0 "Wow!" "#60F"
        ]
