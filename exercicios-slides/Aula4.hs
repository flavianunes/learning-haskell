module Aula4 where
    -- funções recursivas
    {- 
        Definir o tipo da função
        Enumere os casos de forma a cobrir todas as possibilidades.
        Defina o(s) caso(s) base.
        Defina o(s) caso(s) recursivos. Defina como obter o resultado a partir do valor das chamadas recusivas.
    -}
    length' :: [a] -> Int
    length' [] = 0
    length' (_ : xs) = 1 + length' xs

    replicate' :: Int -> a -> [a]
    replicate' 0 _ = []
    replicate' n x =
        [x | _ <- [1..n]]

    sumList :: [Int] -> Int
    sumList [] = 0
    sumList (x:xs) = x + sumList xs

    reverse' :: [a] -> [a]
    reverse' [] = []
    reverse' (x:xs) = reverse' xs ++ [x]

    -- de cima é mto custoso, implementando usando acumuladores
    rev :: [a] -> [a]
    rev xs = rev' xs []
        where   
            rev' [] acc = acc
            rev' (z : zs) acc = rev' zs (z : acc)

    minList :: [Int] -> Int
    minList [] = 0
    minList [x] = x
    minList (x:xs) = minList' x (minList xs)
        where
            minList' a b
                | a > b = b
                | a < b = a
                | a == b = a

    insere :: Int -> [Int] -> [Int]
    insere x [] = [x]
    insere x (y:ys) 
        | x <= y = [x] ++ [y] ++ ys
        | otherwise = y :  insere x ys

    take' :: Int -> [a] -> [a]
    take' _ [] = []
    take' n (x:xs) 
        | n == 1 = [x]
        | n > 1 = [x] ++ take' (n-1) xs

    drop' :: Int -> [a] -> [a]
    drop' _ [] = []
    drop' n (x:xs)
        | n == 1 = xs
        | n > 1 = drop' (n-1) xs

    indice :: Int -> [Int] -> Int
    indice _ [] = -1
    indice y (x:xs) = indice' y (x:xs) 0
        where
            indice' y (x:xs) pos
                | y == x = pos
                | otherwise = indice' y xs (pos+1)

    removeTodosLC :: Int -> [Int] -> [Int]
    removeTodosLC y xs = [x | x <- xs, x /= y]

    removeTodosR :: Int -> [Int] -> [Int]
    removeTodosR y (x:xs) = remove' y (x:xs) []
        where
            remove' y [] acc = acc
            remove' y (x:xs) acc 
                | y == x = remove' y xs acc
                | otherwise = remove' y xs (acc ++ [x])

    countPositivos :: [Int] -> Int
    countPositivos (x:xs) = count' (x:xs) 0
        where
            count' [] acc = acc
            count' (x:xs) acc 
                | x >= 0 = count' xs acc+1
                | otherwise = count' xs acc