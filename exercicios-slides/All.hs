module All where
    --usando recursao
    all' :: (a-> Bool) -> [a] -> Bool
    all' _ [] = True
    all' f (x:xs) = f x && all' f xs

    -- usando foldr
    all2 :: (a-> Bool) -> [a] -> Bool
    all2 f = foldr step True
        where
            step x ac = f x && ac