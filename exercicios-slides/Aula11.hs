module Aula11 where

    --PONTO
    data Point = Point Float Float

    -- calculando a norma de um ponto
    norm :: Point -> Float
    norm (Point x y) = sqrt (x^2 + y^2)

    --calculando distancia
    distance :: Point -> Point -> Float
    distance (Point x y) (Point w z) = sqrt(a + b)
        where
            a = (x - w)^2
            b = (y - z)^2

    --FORMAS
    data Shape = Circle Point Float | Rectangle Point Float Float  
    --calculando area
    area :: Shape -> Float
    area (Rectangle p w h) = w * h
    area (Circle p r) = 2 * r^2

    -- LISTAS E ARVORES
    data IntList = Empty
             | Ins Int IntList

    data IntTree = Leaf
             | Node Int IntTree IntTree

    -- busca sequencial na lista
    elemList :: Int -> IntList -> Bool
    elemList _ Empty = False
    elemList n (Ins m xs) = n == m || elemList n xs

    -- TIPOS POLIMÓRFICOS
    data TRee a = TLeaf
                | Tnote a (Tree a) (Tree b)

    -- TIPO MAYBE
    data Maybe a = Just a | Nothing
    --The Maybe type encapsulates an optional value. A value of type Maybe a either contains a value of type a (represented as Just a), or it is empty (represented as Nothing). Using Maybe is a good way to deal with errors or exceptional cases without resorting to drastic measures such as error.

    -- SAFEHEAD
    head :: [a] -> a
    head [] = error "Prelude.head: empty list"
    head (x : _) = x

    safeHead :: [a] -> Maybe a
    safeHead [] = Nothing
    safeHead (x : _) = Just x