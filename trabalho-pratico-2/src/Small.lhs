Trabalho Prático 2 - Programação Funcional.
==================

Setup inicial
-------------

\begin{code}
module Small where

import Data.List
import Data.Maybe
\end{code}

Introdução
----------

Máquinas virtuais são um mecanismo amplamente utilizado
por compiladores para execução de código. Em especial,
destaca-se a Java Virtual Machine, utilizada para
execução de programas da linguagem Java.

O objetivo deste trabalho é a implementação de um interpretador
para uma máquina virtual simples, que chamaremos de _Small_.
As próximas seções apresentam a sintaxe e a semântica de
programas Small.

Sintaxe e semântica de programas Small
--------------------------

Para execução de programas, a máquina virtual small utiliza uma pilha,
uma memória e um contador de instruções. O estado da máquina pode ser
representado pelo seguinte tipo de dados.

\begin{code}
newtype Name
  = Name String
    deriving (Eq, Ord, Show)

data VMState
  = VMState {
      pc     :: Int
    , stack  :: [Int]
    , memory :: [(Name, Int)]
    } deriving (Eq, Ord, Show)
\end{code}

O tipo Name representa nomes de variáveis e o tipo VMState a configuração
atual da máquina. Os campos do tipo VMState possuem o seguinte significado:

* pc: Representa o contador de instruções, isto é, a próxima instrução a
ser executada pela máquina.
* stack: Representa a pilha de valores utilizados durante a execução de operações.
* memory: Armazena os valores associados a variáveis presentes no programa.

Programas small consistem de uma lista de instruções. A máquina pode executar
somente 9 tipos de instruções, a saber:

* push(n): insere n no topo da pilha.
* var(x): insere o valor da variável x (contida na memória) no topo da pilha.
* set(x): atribui a variável x o valor do topo da pilha.
* add: soma os valores do topo da pilha e empilha o resultado.
* sub: subtrai os valores do topo da pilha e empilha o resultado.
* jump(n): desvio incondicional.
* jumpeq(n): desvia, se os 2 valores do topo da pilha são iguais.
* jumpneq(n): desvia, se os 2 valores do topo da pilha são diferentes.

Implementação de small
----------------------

Representamos instruções small pelo tipo `Instr` a seguir: 

\begin{code}
data Instr
  = IPush Int
  | IVar Name
  | ISet Name
  | IAdd
  | ISub
  | IJump Int
  | IJumpNeq Int
  | IJumpEq Int
  | IHalt
  deriving (Eq, Ord, Show)
\end{code}


1 - A instrução push(n) insere o valor inteiro n no topo da pilha presente
no tipo de dados `VMState`. Para implementar a semântica dessa instrução,
implemente a função:

\begin{code}
push :: Int -> VMState -> VMState
push n state = state { stack = stack state ++ [n]}
\end{code}

que altera o estado atual da máquina empilhando o inteiro fornecido como
primeiro parâmetro.


2 - A instrução var(x) armazena o valor associado a variável x no topo da
pilha de execução. Implemente essa funcionalidade na função:

\begin{code}
lookMemory :: Name -> VMState -> VMState
lookMemory nome state = 
  if length(filter ((==nome) . fst) (memory state)) > 0
    then state { stack = (snd(head (filter ((==nome) . fst) (memory state))):stack state)}
    else state { stack = 0 : stack state}

\end{code}

Note que essa função deve retornar o estado da máquina alterado após a
modificação da pilha de execução contendo, em seu topo, o valor associado
a variável x.

3 - A instrução set(x) atribui à variável x o valor atualmente contido no
topo da pilha de execução. Implemente essa funcionalidade na função:

\begin{code}
setMemory :: Name -> VMState -> VMState
setMemory nome state = 
  if length(stack state) > 0
    then state { memory = ((nome, head(stack state)) : memory state) }
    else state { memory = ((nome, 0) : memory state)}
\end{code}

4 - As operações add e sub utilizam os dois elementos do topo da pilha
e armazenam o resultado da operação na própria pilha. Ao invés de implementarmos
duas operações para a execução dessas instruções, vamos utilizar uma função
de ordem superior que recebe como parâmetro a operação a ser aplicada sobre
os elementos do topo da pilha. Implemente a função:

\begin{code}
stackOp :: (Int -> Int -> Int) -> VMState -> VMState
stackOp op state
  = state { stack = ( op x y : tail(tail(stack state)))}
  where
    x = head (stack state)
    y = head(tail(stack state))
\end{code}

que aplica a operação fornecida como primeiro parâmetro aos dois primeiros
elementos da pilha e re-insere o resultado retornando o estado da máquina
alterado.

5 - Após a execução de cada instrução, o contador de programa deve ser
incrementado. Além disso, a máquina small possui instruções de desvio, cujo
principal objetivo é alterar o contador de programa para alterar o fluxo
de execução do código. Pode-se alterar o contador de programa adicionando
um valor inteiro a este. Implemente a função:

\begin{code}
addPC :: Int -> VMState -> VMState
addPC x state = state { pc = x} 
\end{code}

que adiciona ao valor atual do contador de instrução a constante inteira
fornecida como primeiro parâmetro.

6 - Desvios condicionais devem ser implementados analisando os primeiros
dois elementos da pilha (caso esses existam). Novamente, vamos nos valer
de funções de ordem superior para tratamento dos dois tipos de desvio.
Implemente a função:

qnd n tiver duas coisas no topo da pilha é p aumentar o pc em 1

\begin{code}
condJump :: (Int -> Int -> Bool) -> Int -> VMState -> VMState
condJump cond n state = 
    case (stack state) of 
    (x : y : _) -> if cond x y then state { pc = pc state + n} else state { pc = pc state + 1}
    _ -> state { pc = pc state + 1}

\end{code}

que a partir de um teste (igualdade ou desigualdade), um deslocamento e
um estado atual, retorna o novo estado da máquina contendo o contador
de instrução devidamente alterado (usando o deslocamento caso o teste
seja verdadeiro ou incrementado, caso contrário).

7 - De posse de todas as implementações anteriores, a definição da
execução de uma instrução da máquina pode ser implementada pela seguinte
função:
\begin{code}
vmStep :: Instr -> VMState -> VMState
vmStep (IPush x) state = push x state
vmStep (IVar x) state = lookMemory x state
vmStep (ISet x) state = setMemory x state
vmStep (IAdd) state = stackOp (+) state
vmStep (ISub) state = stackOp (-) state
vmStep (IJump x) state = addPC x state
vmStep (IJumpEq x) state = condJump (==) x state
vmStep (IJumpNeq x) state = condJump (/=) x state
vmStep (IHalt) state = state

\end{code}
que a partir de uma instrução a ser executada e do estado atual da máquina
produz o um novo estado resultante.  

8 - Uma etapa importante da máquina é a busca da próxima
execução a ser executada. Implemente a função
\begin{code}
nextInstr :: [Instr] -> VMState -> Maybe Instr
nextInstr i state = pos (pc state) i
  where
    pos _ [] = Nothing
    pos 0 (x : _) = if x == IHalt then Nothing
                      else Just x
    pos n (_ : xs) = pos n xs
\end{code}

que a partir de um programa e o estado atual da máquina, retorna
a instrução apontada pelo contador de instruções. Caso o contador
indique uma posição inválida ou a instrução atual seja `halt`, o
valor `Nothing` deve ser retornado.

9 - Utilizando a função `nextInstr`, podemos implementar o interpretador
da máquina small utilizando a seguinte função:
\begin{code}
exec :: [Instr] -> VMState -> VMState
exec = undefined
\end{code}
que deve obter a próxima instrução a ser executada e continuar a execução
do programa sobre o estado da máquina alterado pela última instrução. A
função deve parar apenas quando a função `nextInstr` retornar `Nothing`,
quando o estado final da máquina é retornado como resultado.


Testando seu código
-------------------

O presente trabalho possui uma bateria de testes automatizados para
as 8 primeiras funções. Para execução de todos os testes basta
executar o comando

~~~~
make
~~~~

na pasta raiz do projeto. Observe que todos os testes irão falhar pois
nenhuma das funções possui implementação. Assim que você fornecer implementações
para as funções acima, poderá usar os testes para verificar se sua implementação
está correta.
