module Aula3 where
    max3 :: Int -> Int -> Int -> Int
-- exemplos com guarda
    max3 a b c 
        | a > b && a > c = a
        | b > a && b> c = b
        | otherwise = c 

-- exemplos com casamento de padrão
    ou :: Bool -> Bool -> Bool
    True `ou` _ = True
    False `ou` b = b

    xor  :: Bool -> Bool -> Bool
    True `xor` True = True
    False `xor` False = True
    _ `xor` _ = False

-- exemplos com tuplas
    third :: (a, b, c) -> c
    third (_, _, z) = z

    roots :: Float -> Float -> Float -> (Float, Float)
    roots a b c 
        = (x1, x2)
        where
            delta = b^4 - 4 * a * c
            x1 = ((-b) + sqrt delta) / 2 * a
            x2 = ((-b) - sqrt delta) / 2 * a

    norm :: (Float, Float) -> (Float, Float)
    norm (x, y) 
        = (a, b)
        where
            v = sqrt(x^2 +y^2)
            a = x/v
            b = y/v

-- exemplos com listas
-- list comprehensions

    factors :: Int -> [Int]
    factors n = [x | x <- [1..n], n `mod` x == 0]

    perfect :: Int -> Bool
    perfect n =
        n == sum [i | i <- init [1..n], n `mod` i == 0]

    primes :: Int -> [Int]
    primes n = [i | i <- [1..n], factors i == [1, i]]

    quicksort :: [Int] -> [Int]
    quicksort [] = []
    quicksort (x : xs) =
        smaller ++ [x] ++ greater
        where
            smaller = quicksort [y | y <- xs, y <= x]
            greater = quicksort [z | z <- xs, z > x]
