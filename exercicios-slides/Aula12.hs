module Aula12 where 
    {-# LANGUAGE InstanceSigs #-}

    data Point = Point Int Int

    --CLASSES DE TIPOS
    {-
    Nome inicia com letra maiúscula.
    Define uma variável de tipo que representa o tipo a ser sobrecarregado.
    Cada classe define um ou mais funções que devem ser implementadas por suas instâncias.
    -}

    class Eq2 a where
        (==) :: a -> a -> Bool
        (/=) :: a -> a -> Bool

    instance Eq2 Bool where
        True == True = True
        False == False = True
        _ == _ = False


    instance Eq2 Point where
        (Point x y ) == (Point x' y') =
            x == x' && y == y'
        x /= y = not (x == y)

    -- INSTANCIAS RECURSIVAS
    instance Eq2 a => Eq2 [a] where
        [] == [] = True
        (x : xs) == (y : ys)
           = x == y && xs == ys
        _ == _ = False
     
        xs /= ys = not (xs == ys)

    -- SUPERCLASSES
    class Eq a => Ord a where --ord é subclasse de eq
        (<), (>), (>=), (<=) :: a -> a -> Bool
        max, min :: a -> a -> a

        -- => em tipo : restringe um tipo polimórfico. tipo a deve ser uma instncia de Eq
        -- => em classe : todo tipo instancia de ord deve possuir uma instancia de Eq 
        -- => em instancia: para usar eq sobre listas, deemos possuir eq sobre elementos 
        --instance Eq a => Eq [a] where

    -- PODE FAZER DEFINIÇÃO DEFAULT
    class Eq a where
        (==) :: a -> a -> Bool
        (/=) :: a -> a -> Bool
     
        x /= y = not (x == y)
        x == y = not (x /= y)