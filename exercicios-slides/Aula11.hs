module Aula11 where
    --distancia entre dois pontos
    data Point = Point Float Float

    distance :: Point -> Point -> Float
    distance (Point x1 y1) (Point x2 y2) = sqrt ((x1-x2)^2 + (y1-y2)^2)

    data Shape = Rect Point Float Float
                | Cirle Point Float
                | Triangle Point Point Point

    area :: Shape -> Float
    area (Rect p w h) = w * r
    area (Circle p r) =  2 * r^2