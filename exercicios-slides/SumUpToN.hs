module SumUpToN where
    sumUpToN ::Integer -> Integer
    sumUpToN 0 = 0
    sumUpToN 1 = 1
    sumUpToN n = n + sumUpToN(n-1)