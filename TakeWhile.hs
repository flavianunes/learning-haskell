module TakeWhile where
    takeWhile' :: (a->Bool) -> [a] -> [a]
    takeWhile' p =
        foldr step []
        where
            step x ac 
                | p x = x:ac
                | otherwise = [] 