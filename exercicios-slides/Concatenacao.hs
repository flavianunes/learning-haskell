module Concatenacao where
--    (.++.) :: [a] -> [a] -> [a]
--    [] ++ ys = ys
--    (x : xs) ++ ys = x:(xs++ys)

    -- usando foldr
    (.++.) :: [a] -> [a] -> [a]
    xs.++.ys = 
        foldr step base xs
        where 
            base = ys
            step x ac = x:ac