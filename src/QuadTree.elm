module QuadTree exposing (QuadTree(..), qb1, qt1, qt2, qt3, subdivide)


type QuadTree a
    = Leaf a
    | Node (List (QuadTree a))


qt1 =
    Leaf "One"


qt2 =
    Node [ Leaf "NW", Leaf "NE", Leaf "SW", Leaf "SE" ]


qt3 =
    Node [ qt2, Leaf "NE", Leaf "SW", Leaf "SE" ]


type alias BoundingBox =
    { x : Float
    , y : Float
    , w : Float
    , h : Float
    }


type Content a
    = Empty
    | Filled a


type alias Data a =
    { bb : BoundingBox, content : Content a }


subdivide : (Data a -> Bool) -> QuadTree (Data a) -> QuadTree (Data a)
subdivide f qt =
    case qt of
        Leaf { bb, content } ->
            let
                x =
                    bb.x

                y =
                    bb.y

                w2 =
                    bb.w / 2

                h2 =
                    bb.h / 2
            in
            Node
                [ Leaf { bb = BoundingBox x y w2 h2, content = Empty }
                , Leaf { bb = BoundingBox x (y + h2) w2 h2, content = Empty }
                , Leaf { bb = BoundingBox (x + w2) (y + h2) w2 h2, content = Empty }
                , Leaf { bb = BoundingBox (x + w2) y w2 h2, content = Empty }
                ]

        Node children ->
            Node (List.map (subdivide f) children)


qb1 =
    Leaf { bb = BoundingBox 0 0 256 256, content = Empty }
