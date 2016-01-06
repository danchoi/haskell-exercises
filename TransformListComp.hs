{-# LANGUAGE OverloadedStrings, RecordWildCards, ScopedTypeVariables, TransformListComp #-} 


module Main where
import GHC.Exts

main = do
    let xs = [("a", 1, "c", "d")
             ,("a", 1, "c1", "d1")
             ,("b", 0, "c3", "d3")
             ,("b", 1, "c4", "dr")]
    let xs' = [ (the a, the b, c, d) |
                  x@(a,b,c,d) <- xs
                , then group by (a,b) using groupWith
                ]
    mapM_ print xs'
      

-- groupWith :: Ord b => (a -> b) -> [a] -> [[a]]


-- ("a",1,["c","c1"],["d","d1"])
-- ("b",0,["c3"],["d3"])
-- ("b",1,["c4"],["dr"])
-- 
-- 
