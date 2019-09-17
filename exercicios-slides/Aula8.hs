module Aula8 where
    import Data.Char (ord, chr)

    -- usando foldr -- que recebe: função, caso base, valor
    sum' :: [Int] -> Int
    sum' x = foldr (+) 0 x

    concat' :: [[Char]] -> [Char]
    concat' s = foldr (++) [] s

    and' :: [Bool] -> Bool
    and' x = foldr (&&) True x

    --implementar lenght usando foldr
    length' :: [a] -> Int
    length' [] = 0
    length' (_ : xs) = 1 + length xs

    lenghtf :: [a] -> Int
    lenghtf xs = foldr (\ _ ac -> 1 + ac) 0 xs

    --map com foldr
    map' :: (a -> b) -> [a] -> [b]
    map' f = foldr step []
        where
            step x ac = f x : ac 


    --serialização
    zip :: [a] -> [b] -> [(a,b)]
    zip [] _ = []
    zip _ [] = []
    zip (x : xs) (y : ys) = (x,y) : zip xs ys