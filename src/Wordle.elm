module Wordle exposing (render, sort, tdata, tdata2)

import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Word exposing (Word)


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
                    20 + (30.0 * toFloat i)

                color =
                    [ 0.8, 0, 0, 1 ]
            in
            Word.render (Word w x y (scale * p) 0 color)
    in
    List.indexedMap (\i ( w, p ) -> renderWord i w p) data_
        |> g [ x (String.fromFloat x_), y (String.fromFloat y_) ]
