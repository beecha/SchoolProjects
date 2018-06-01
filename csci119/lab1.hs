{-# OPTIONS_GHC -fdefer-type-errors #-}
--
-- lab1.hs
-- CSci 119, Lab 1
-- The main purpose of this lab is to implement the set operations that we will
-- need later.

import Data.List

distinct :: Ord a => [a] -> [a]
distinct = dedup . sort
    where
        dedup [] = []
        dedup [x] = [x]
        dedup (x1:x2:xs) | x1 == x2   = dedup (x2:xs)
                         | otherwise   = x1 : dedup (x2:xs)

-------------------------------------------------------------------------------
-- Set predicates
-- Although some of these are built-in, I'll make you rewrite them from scratch,
-- as an exercise.

-- empty l
-- Returns true if l is the empty set, false otherwise
empty :: [a] -> Bool
empty l = length l == 0

-- proper l
-- Returns true if l is a proper set (does not contain any duplicates), false 
-- otherwise. If you want to think of this logically, it's something like
--     forall a in l: not exists a in (tail l)
-- You may find this function useful in testing your other functions.
proper :: Ord a => [a] -> Bool
proper l = distinct l == sort l

-- subset as bs
-- Return true if as is a subset of bs. You can use the definition given in
-- lecture, if you like, or try to come up with something better. Remember
-- that the logical definition of subset is
--     forall a in as: a in bs
subset :: Eq a => [a] -> [a] -> Bool
subset as bs = all (`elem` bs) as --All of as is an element of bs

-------------------------------------------------------------------------------
-- Set operations
-- We'll only be implementing the operations we need for later, hence the 
-- lack of intersection, difference, etc.

sigma = ['a', 'b']

-- zero
-- zero gives the empty set.
zero :: [String]
zero = [] --Epsilon

-- one
-- one gives the set containing only the empty string
one :: [String]
one = [""]

-- sym c
-- Gives the set consisting of the single symbol c.
sym :: Char -> [String]
sym c = [[c]]

-- uni
-- Gives the setwise union of as and bs.
-- Assumes that as and bs are proper sets.
-- Ensures that (as `uni` bs) is a proper set, the union of as and bs
uni :: Ord a => [a] -> [a] -> [a]
uni as [] = as
uni [] bs = bs
uni (a:as) (b:bs)
   | a < b     = a : uni as (b:bs)
   | a == b    = a : uni as bs
   | otherwise = b : uni (a:as) bs

-- cat 
-- Gives the setwise string concatenation of as and bs
-- Assumes that as and bs are proper sets of strings.
-- Ensures that (as `cat` bs) is a proper set, and that 
--      forall ab in (as `cat` bs): exists a in as, b in bs: ab = a ++ b
cat :: [String] -> [String] -> [String]
cat as [] = as
cat [] bs = bs
cat (a:as) (b:bs) = a : b : cat as bs

-- starn
-- Gives the *bounded* Kleene star of as. Because the true Kleene star is
-- infinite, we must place an upper-bound on how many self concatenations to
-- perform. Thus, 
--      starn 4 as
-- should give
--      as^0 `uni` as^1 `uni` as^2 `uni` as^3 `uni` as^4
-- You may find it helpful to write a helper function 
--      selfcat as n 
-- which gives
--      as^n
-- for use in your definition.
-- Assumes as is a proper set of strings, n >= 0.
-- Ensures that (starn n as) is a proper set.
-- Starn 3 ["Hello","World","!"] will return ["HelloWorld!"]
-- Every recursive step will grab the head of the tail
selfcat :: [String] -> Int-> [String]
selfcat "" _ = [""]
selfcat _ 0 = [""]
selfcat (a:as) n = a ++ (selfcat as (n-1) )

starn :: Int -> [String] -> [String]
starn 0 as = []
starn 1 as = head as
starn n as = undefined


-------------------------------------------------------------------------------
-- Examples
-- Construct, using the routines you wrote above, the following languages
-- (using U for union and . for concatenation; bound * to 10):
-- 
--   The language of strings of as and bs:
--      L1 = ({a} U {b})*     
--
--   The lang. of 0-or-more as, followed by 0-or-more bs:
--      L2 = {a}* . {b}*      
--
--   The lang. of strings over {a,b} that have an odd number of b's:
--      L3 = ({a}* . {b} . {a}*) . ({a}* . {b} . {a}* . {b} . {a}*)* 

--Take 10
l1 :: [String]
l1 = undefined

l2 :: [String]
l2 = undefined

l3 :: [String]
l3 = undefined

-- How many strings are in each language (assuming * is bounded to 5)? (fill in)
-- 
-- |L1| = 
-- |L2| = 
-- (optional) |L3| =  