{- 
    criptografia de cesar
    Algoritmo simples para criptografia de textos
    Consiste em deslocar caracteres em n posições.
    Exemplo: encode 2 "abc" == "cde".
    
-}

char2Int :: Char -> Int
char2Int c = ord c - ord 'a'

int2Char :: Int -> Char
int2Char n = chr (ord 'a' + n)

-- criptografando um char
shift :: Int -> Char -> Char
shift n c
  | isLower c = int2Char ((char2Int c + n) `mod` 26)
  | otherwise = c

--criptografando/descriptografando string
encode :: Int -> String -> String
encode n s = map (shift n) s

decode :: Int -> String -> String
decode n s = encode (- n) s

--criptografando 