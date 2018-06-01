foo :: [Int]
foo = [1,2,3,4,5]

bar :: Int -> Int
bar n = n - 5

subEachFromTen :: [Int] -> [Int]
subEachFromTen = map (10 -)




sumAll :: Num a => [a] -> a
sumAll (x:xs) = x + sumAll xs
sumAll [] = 0

timesTwo :: Int -> Int
timesTwo n = n * 2

listTimesTwo :: [Int] -> [Int]
listTimesTwo x = map timesTwo x

showMsg :: Int -> String
showMsg x = if x < 10 then "Less than ten" else "Greater than ten"

showLen :: [a] -> String
showLen x = (show (theLen) ) ++ (if theLen == 1 then " item" else " items")
   where
   theLen = length x
   
   
--Types for variables
type Mass = Double
type Pos = (Double, Double, Double)  --x, y, z
type Obj = (Mass, Pos)               --interchangeable with (Double, (Double, Double, Double))

--List of functions needed
{-
Takes a list of objects.
Returns a list of (sum of mass times other object mass over distance for all objects)
Order is preserved.
-}

--Here we pass the objects in as two parameters to the helper function so we can iterate twice
--This does not copy the list of objects.
calcMassesOverDists :: [Obj] -> [Double]
clacMassesOverDists objs = calcHelper objs objs

--82ry9674

--This is a function that computes a distance between to Pos values, used in caklcMMoD
distXYZ :: Pos -> Pos -> Double
distXYZ (x1, y1, z1) (x2, y2, z2) = sqrt (xd * xd + yd * yd + zd * zd)
   where
   (xd, yd, zd) = (x1 - x2, y1 - y2, z1 - z2)  --Three assignments at once using a tuple
   
--This iterates over the list of objects and calculates the sum for each.
--It uses pattern matching to recurse and terminate.
calcHelper :: [Obj] -> [Obj] -> [Double]
calcHelper (obj:objs) objList = (sum (calcMMoD obj objList)) : calcHelper objs objList
calcHelper [] _ = []

--This calculates the list of mass times mass over distance for a single object.
--It uses pattern matching to recurse and terminate and a where clause to keep the code clear.
calcMMoD :: Obj -> [Obj] -> [Double]
calcMMoD obj@(m1, pos1) ((m2, pos2):rest) = safeValue : calcMMoD obj rest
   where
   dist = distXYZ pos1 pos2
   safeValue = if pos1 == pos2 then 0 else m1 * m2 / dist
calcMMoD _ [] = []

