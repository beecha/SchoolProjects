{-# OPTIONS_GHC -fdefer-type-errors #-}
--
-- reparse.hs
-- Parser for regular expressions (experiment).
--
import Data.Char (isAlpha)

data RE 
    = Empty                          -- Empty set
    | Letter Char                    -- Single symbol (letter)
    | Cat RE RE                      -- Concatenation
    | Union RE RE                    -- Union
    | Star RE                        -- Kleene star

instance Show RE where

  showsPrec _ Empty       = showString "0"
  showsPrec _ (Letter c)  = showString [c]
  showsPrec d (Cat r1 r2) = showParen (d > up_prec) $
                              showsPrec (up_prec+1) r1 .
                              showsPrec (up_prec+1) r2
    where
      up_prec = 5

  showsPrec d (Union r1 r2) = showParen (d > up_prec) $
                                showsPrec (up_prec+1) r1 .
                                showString "+" .
                                showsPrec (up_prec+1) r2
    where
      up_prec = 3

  showsPrec d (Star r)    = showsPrec 10 r . showString "*"


{- An (ambiguous) grammar for RE:
   
   <RE> ::= <RE><RE>
   <RE> ::= <RE> '*'
   <RE> ::= <RE> '+' <RE>
   <RE> ::= '(' <RE> ')'
   <RE> ::= SYMBOL
   <RE> ::= '1'
   <RE> ::= '0'

   An ambiguous grammar doesn't do us much good, so we'll encode the precedence
   (* has highest precedence, followed by concatenation, followed by +) in the
   grammar:

   <Plus> ::= <Cat> ('+' <Plus>)*
   <Cat>  ::= <Star> <Cat>*
   <Star> ::= <Unit> '*'*
   <Unit> ::= '(' <Plus> ')' 
            | SYMBOL
            | '1'
            | '0'

   Note that in this definition, both <Plus> and <Cat> will be *right* 
   associative; this doesn't matter in this case, since both are associative
   operators, but it's something you should bear in mind when constructing
   grammars with left-associative operators.

   The parser below implements a functional PEG parser. For large inputs the
   performance will be exponential, but this hopefully won't be a problem for
   the REs we'll be accepting.
-}
type ParseResult = Maybe (String,RE)
type Rule = String -> ParseResult

reparse :: String -> RE
reparse s = let Just ("",result) = plus $ filter (/=' ') s in result
  where

    -- <Plus> ::= <Cat> ('+' <Plus>)*
    plus :: Rule
    plus ss = case cat ss of
                Just (ss',re) -> build Union $ (Just (ss',re)) : rept2 plus '+' ss'
                Nothing       -> Nothing

    -- <Cat> ::= <Star> <Cat>*
    cat :: Rule
    cat ss = case star ss of
              Just (ss',re) -> build Cat $ (Just (ss',re)) : rept cat ss'
              Nothing       -> Nothing

    -- <Star> ::= <Unit> '*'*
    star :: Rule
    star ss = case unit ss of
                Just ('*':ss', re) -> Just (consume '*' ss', Star re)
                Just (ss,re)       -> Just (ss,re)
                Nothing            -> Nothing

    -- <Unit> ::= '(' <Plus> ')' | SYMBOL | '1' | '0'
    unit :: Rule
    unit = alt [paren, symbol, epsilon, zero]

    epsilon :: Rule
    epsilon ('1':ss) = Just (ss, Star Empty)
    epsilon _        = Nothing 

    zero :: Rule
    zero ('0':ss) = Just (ss, Empty)
    zero _        = Nothing

    symbol :: Rule
    symbol (s:ss) | isAlpha s    = Just (ss, Letter s)
    symbol _ = Nothing

    paren :: Rule
    paren ('(':ss) = case plus ss of
                        Just (')':ss',re) -> Just (ss',re)
                        _                 -> Nothing
    paren _ = Nothing

    -------------------------------------
    -- Helper functions implementing the
    -- internals of a PEG parser.
    alt :: [Rule] -> Rule
    alt [] _ = Nothing
    alt (r:rs) s = case r s of
                     Just result -> Just result -- Return first successful match
                     Nothing -> alt rs s        -- Failed; try next alternative

    -- Eat up all the c's at the beginning of the string s
    consume :: Char -> String -> String
    consume _ "" = ""
    consume c s@(c':cs) | c == c'   = consume c cs
                        | otherwise = s

    -- Recognize zero or more Rules
    rept :: Rule -> String -> [ParseResult]
    rept r s = case r s of
                Just (ss,re) -> (Just (ss,re)) : rept r ss
                Nothing      -> []

    -- A variant of rept that recognizes ('c' <r>)* and constructs the list
    -- of results by discarding all the c's.
    rept2 :: Rule -> Char -> String -> [ParseResult]
    rept2 r c (c':s) | c == c'   = case r s of
                                    Just (ss,re) -> Just (ss,re) : rept2 r c ss
                                    Nothing      -> []
    rept2 _ _ _ = []

    -- Converts a list of ParseResults (as returned by rept) into a single
    -- parse result, by applying the RE constructor cons right-associatively.
    build :: (RE -> RE -> RE) -> [ParseResult] -> ParseResult
    build _    []    = Nothing
    build _    [res] = res
    build cons ((Just (ss,re)):rs) = let (Just (ss',re')) = build cons rs
                                     in
                                       Just (ss', cons re re')

    

