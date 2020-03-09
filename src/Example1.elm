module Example1 exposing (main)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Word exposing (Word)
import Wordle exposing (render, tdata, tdata2)


main =
    let
        f =
            1.0
    in
    svg
        [ version "1.1"
        , x "0"
        , y "0"
        , viewBox "0 0 300 300"
        ]
        [ Word.render (Word "AAAA" 40 40 1.5 0 "#800" 1)
        , Word.render (Word "BBBB" 40 60 1.0 0 "#800" 1)
        , Word.render (Word "CCCC" 40 80 0.5 0 "#800" 1)
        ]



--
--main2 =
--    svg
--        [ version "1.1"
--        , x "0"
--        , y "0"
--        , viewBox "0 0 400 400"
--        ]
--        [ render 30 30 2 tdata
--        ]
--
--
--main1 =
--    svg
--        [ version "1.1"
--        , x "0"
--        , y "0"
--        , viewBox "0 0 400 400"
--        ]
--        [ word 20 40 0 0.5 "Hello!" "#800"
--        , word 30 30 90 1.0 "Wow!" "#60F"
--        ]
