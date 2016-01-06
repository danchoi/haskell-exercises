{-# LANGUAGE OverloadedStrings, RecordWildCards, ScopedTypeVariables, TransformListComp #-} 


module Main where
import GHC.Exts

main = do
    let xs = [("a", 1, "c", "d")
             ,("a", 1, "c1", "d1")
             ,("b", 0, "c3", "d3")
             ,("b", 1, "c4", "dr")]
    let xs' = [ (the a, the b,x) |
                  x@(a,b,c,d) <- xs
                , then group by (a,b) using groupWith
                ]
    mapM_ print xs'
      


-- ("a",1,[("a",1,"c","d"),("a",1,"c1","d1")])
-- ("b",0,[("b",0,"c3","d3")])
-- ("b",1,[("b",1,"c4","dr")])
-- 
