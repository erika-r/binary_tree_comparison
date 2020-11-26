data Tree a = Null | Node a (Tree a) (Tree a)
     deriving (Read,Show)

-- inserts value into tree
insert :: Ord a => a -> Tree a -> Tree a
insert a Null = Node a Null Null    -- basecase
insert a (Node b t1 t2)    --root left right
    | a < b = Node b (insert a t1) t2      -- find place in left tree
    | otherwise = Node b t1 (insert a t2)      -- find place in right tree

-- makes tree from a list
makeTree :: Ord a => [a] -> Tree a
makeTree [] = Null
makeTree (x:xs) = insert x (makeTree xs)

-- searches for number in tree
search :: Ord a => a -> Tree a -> Bool
search a Null = False   --basecase
search b (Node a t1 t2)    --root left right
    | b == a = True
    | b < a = search b t1      -- find item in left tree
    | b > a = search b t2      -- find item in right tree

-- PRINTING FUNCTIONS

-- start from left, then root, then right
inOrder :: Tree a -> [a]
inOrder Null = []
inOrder (Node x t1 t2) = (inOrder t1) ++  [x] ++ (inOrder t2)    

-- start from root, left, then right
preOrder :: Tree a -> [a]
preOrder Null = []
preOrder (Node x t1 t2) = [x] ++ (preOrder t1) ++ (preOrder t2)

-- start from left, right, then root
postOrder :: Tree a -> [a]
postOrder Null = []
postOrder (Node x t1 t2) = (postOrder t1) ++ (postOrder t2) ++ [x]
