module Reverse where
    reverse' :: [a] -> [a]
    reverse' = foldl step []
        where
            step ac x = x : ac