module Aula6 where
    import Data.Char (chr, ord, isLower)

{-  doubleList :: [Int] -> [Int]
    doubleList [] = []
    doubleList (x:xs) = 2*x : doubleList xs

    notList :: [Bool] -> [Bool]
    notList [] = []
    notList (x:xs) = not x : notList xs
-}
    --refatorando

    map' :: (a -> b) -> [a] -> [b] 
    map' _ [] = []
    map' f (x:xs) =  f x : map' f xs

    doubleList :: [Int] -> [Int]
    doubleList xs = map' f xs
        where
            f x = 2 * x

    notList :: [Bool] -> [Bool]
    notList xs = map' not xs

    mapLC :: (a -> b) -> [a] -> [b]
    mapLC f xs = [y | x <- xs, let y = f x]

    evenList :: [Int] -> [Bool]
    evenList [] = []
    evenList xs = [y | x <- xs, let y = even x]

{-    lowers :: String -> String
    lowers [] = []
    lowers (x:xs) 
        | isLower x = x: lowers xs
        | otherwise = lowers xs

    evens :: [Int] -> [Int]
    evens [] = []
    evens (x:xs)
        | even x = x : evens xs
        | otherwise = evens xs
-}

--refatorando

    filter' :: (a->Bool) -> [a] -> [a]
    filter' _ [] = []
    filter' f (x:xs)
        | f x  = x: filter' f xs
        | otherwise = filter' f xs

    filterLC :: (a->Bool) -> [a] -> [a]
    filterLC _ [] = []
    filterLC f xs = [x | x <- xs, f x == True]

    lowers :: String -> String
    lowers xs = filter' isLower xs

    evens :: [Int] -> [Int]
    evens xs = filter' even xs

    intervalo :: (Int, Int) -> [Int] -> [Int]
    intervalo (a,b) xs = filter' f xs
        where
            f x = x > a && x < b

    intervaloR :: (Int, Int) -> [Int] -> [Int]
    intervaloR (a, b) xs = intervalo' (a, b) xs []
        where
            intervalo' (a, b) [] acc = acc
            intervalo' (a, b) (x:xs) acc 
                | x > a && x < b = intervalo' (a, b) xs (acc ++ [x])
                | otherwise = intervalo' (a,b) xs acc


    --usando função anonima \ arguments -> code
    doubleListA :: [Int] -> [Int]
    doubleListA [] = []
    doubleList xs = map (\x -> 2*x) xs

    {- 
    criptografia de cesar
    Algoritmo simples para criptografia de textos
    Consiste em deslocar caracteres em n posições.
    Exemplo: encode 2 "abc" == "cde".
    
-}

    char2Int :: Char -> Int
    char2Int c = ord c - ord 'a'

    int2Char :: Int -> Char
    int2Char n = chr (ord 'a' + n)

    -- criptografando um char
    shift :: Int -> Char -> Char
    shift n c
    | isLower c = int2Char ((char2Int c + n) `mod` 26)
    | otherwise = c

    --criptografando/descriptografando string
    encode :: Int -> String -> String
    encode n s = map (shift n) s

    decode :: Int -> String -> String
    decode n s = encode (- n) s

    --criptografando 