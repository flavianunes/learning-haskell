-- uma função para combinar a cabeça com o resultado da chamada recursiva sobre a cauda
-- folds recebem a função q vai combinar, o valor do caso base e a lista
module Foldr where
    foldr :: (a -> b -> b) ->b -> [a] -> b
    foldr _ v [] = v
    foldr f v (x:xs) = f x (foldr f v xs)