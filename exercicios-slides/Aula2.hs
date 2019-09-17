-- Fibonacci using Haskell by Flavia Nunes
module Aula2 where
    fib :: Integer -> Integer
    fib 0 = 0
    fib 1 = 1
    fib n = fib(n-1) + fib(n-2)