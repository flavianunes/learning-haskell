module Reverse where
    reverse' :: [a] -> [a]
    reverse' = foldl step []
        where
            step ac x = x : ac

    reverse2 :: [a] -> [a]
    reverse2 = foldl(flip(:)) []