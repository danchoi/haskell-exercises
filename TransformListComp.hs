{-# LANGUAGE OverloadedStrings, RecordWildCards, ScopedTypeVariables, TransformListComp #-} 


module Main where
import GHC.Exts

main = do
    let xs = [("a", 1, 3, ("c", "d"))
             ,("a", 1, 3, ("c1", "d1"))
             ,("a", 0, 5, ("c2", "d2"))
             ,("b", 0, 6, ("c3", "d3"))
             ]
    let xs' = [ (the a, the b, c, d) |
                  x@(a,b,c,d) <- xs
                , then group by (a,b) using groupWith
                ]
    mapM_ print xs'
    putStrLn "Second:"

    let xs'' = [(the a, b, concat c, d) | (a,b,c, d)  <- xs', then group by a using groupWith]
    mapM_ print xs''

              
      

-- groupWith :: Ord b => (a -> b) -> [a] -> [[a]]


{-
-- runghc TransformListComp.hs
-- ("a",0,[("c2","d2")])
-- ("a",1,[("c","d"),("c1","d1")])
-- ("b",0,[("c3","d3")])
-- 


-- Second:
-- ("a",[0,1],[[("c2","d2")],[("c","d"),("c1","d1")]])
-- ("b",[0],[[("c3","d3")]])
-- 
-- can zip these results together


Second:
("a",[0,1],[5,3,3],[[("c2","d2")],[("c","d"),("c1","d1")]])
("b",[0],[6],[[("c3","d3")]])


-}
