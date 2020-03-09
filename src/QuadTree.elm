module QuadTree exposing (QuadTree(..), boxIsFull, qb1, qt1, qt2, qt3, subdivide)


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


subdivide : (Data ( Float, Float ) -> Bool) -> QuadTree (Data ( Float, Float )) -> QuadTree (Data ( Float, Float ))
subdivide f qt =
    case qt of
        Leaf leaf ->
            case boxIsFull leaf of
                False ->
                    Leaf leaf

                True ->
                    let
                        x =
                            leaf.bb.x

                        y =
                            leaf.bb.y

                        w2 =
                            leaf.bb.w / 2

                        h2 =
                            leaf.bb.h / 2

                        children =
                            [ { bb = BoundingBox x y w2 h2, content = leaf.content }
                            , { bb = BoundingBox x (y + h2) w2 h2, content = leaf.content }
                            , { bb = BoundingBox (x + w2) (y + h2) w2 h2, content = leaf.content }
                            , { bb = BoundingBox (x + w2) y w2 h2, content = leaf.content }
                            ]

                        continue : Data ( Float, Float ) -> QuadTree (Data ( Float, Float ))
                        continue ({ bb, content } as datum) =
                            case boxIsFull datum of
                                True ->
                                    Leaf datum

                                False ->
                                    Leaf { bb = bb, content = Empty }
                    in
                    Node (List.map continue children)

        Node children ->
            Node (List.map (subdivide f) children)


qb1 =
    Leaf { bb = BoundingBox 0 0 256 256, content = Filled ( 4, 4 ) }


pointInBox : ( Float, Float ) -> BoundingBox -> Bool
pointInBox ( px, py ) { x, y, w, h } =
    x <= px && px <= x + w && y <= py && py <= y + h


boxIsFull : Data ( Float, Float ) -> Bool
boxIsFull { bb, content } =
    case content of
        Empty ->
            False

        Filled point ->
            pointInBox point bb
