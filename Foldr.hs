module Foldr where
    foldr :: (a -> b -> b) ->b -> [a] -> b
    foldr _ v [] = v
    foldr f v (x:xs) = f x (foldr f v xs)