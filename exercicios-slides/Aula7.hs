module Aula7 where 
    import Data.Char (chr, ord, isLower, odd)

    -- funções retornam funções (flip = invesão de parametros)
    flip :: (a -> b -> c) -> (b -> a -> c)
    flip f = \ y x -> f x y
    
    -- currying: Funções de 2 argumentos são, na verdade, funções de um argumento que retornam funções de um argumento.

    -- apllyAll
    applyAll :: [a -> a] -> a -> a
    applyAll [] x = x
    applyAll (f:fs) x = applyAll fs (f x)

    -- composição
   -- (.) :: (b -> c) -> (a -> b) -> a -> c
    -- g . f = \ x -> g (f x)

    filterNot :: (a -> Bool) -> [a] -> [a]
    filterNot p = filter (not . p)

    applyAll' :: [a -> a] -> a -> a
    applyAll' [] x = x
    applyAll' (f : fs) = applyAll' fs . f

    
