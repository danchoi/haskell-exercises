{-# LANGUAGE OverloadedStrings, RecordWildCards, ScopedTypeVariables, TransformListComp #-} 


module Main where
import GHC.Exts

main = do
    let xs = [("a", 1, ("c", "d"))
             ,("a", 1, ("c1", "d1"))
             ,("a", 0, ("c2", "d2"))
             ,("b", 0, ("c3", "d3"))
             ]
    let xs' = [ (the a, the b, c) |
                  x@(a,b,c) <- xs
                , then group by (a,b) using groupWith
                ]
    mapM_ print xs'
    putStrLn "Second:"
    let xs'' = [(the a, b, c) | (a,b,c)  <- xs', then group by a using groupWith]

    mapM_ print xs''

              
      

-- groupWith :: Ord b => (a -> b) -> [a] -> [[a]]


-- ("a",1,["c","c1"],["d","d1"])
-- ("b",0,["c3"],["d3"])
-- ("b",1,["c4"],["dr"])
-- 
-- 


-- Second:
-- ("a",[0,1],[[("c2","d2")],[("c","d"),("c1","d1")]])
-- ("b",[0],[[("c3","d3")]])
-- 
-- can zip these results together
