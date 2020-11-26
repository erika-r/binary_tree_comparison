%root, left tree, right tree
bst([],[],[]) :- bst([],[],[]).
bst(X,Y,Z) :-
    X, Y = bst(Y,_,_),Z=bst(Z,_,_).

makeTree([],bst([],[],[]),Y):- Y = bst([],[],[]).
makeTree([X],BT,Y):- insert(X,BT,Y).
makeTree([X|XS],BT,Y):- makeTree([X],BT,Z),makeTree(XS,Z,Y). 

insert(X,bst([],[],[]),bst(X,bst([],[],[]),bst([],[],[]))).
insert(X,bst(Root,Left,Right),NewTree):-
   X=<Root,
   insert(X,Left,LeftNodes),
   NewTree=bst(Root,LeftNodes,Right);
   insert(X,Right,NewRight),
   NewTree=bst(Root,Left,NewRight).

%----------------------------------------------------------------------------
preorder(bst([],[],[]), []).
preorder(bst(X,[],[]), [X]). 
preorder(bst(Root,Left,Right), Pretraverse):-
    preorder(Left,LeftNodes), preorder(Right, RightNodes),
    append([Root|LeftNodes], RightNodes, Pretraverse).

%test case
%preorder(bst(3,bst(2,bst(1,[],[]),bst([],[],[])),bst(4,[],[])),Y).

%------------------------------------------------------------------------------
inorder(bst([],[],[]), []).
inorder(bst(X,[],[]), [X]).
inorder(bst(Root,Left,Right), Intraverse):-
    inorder(Left,LeftNodes), inorder(Right, RightNodes),
    append(LeftNodes,[Root|RightNodes],Intraverse).
%------------------------------------------------------------------------------
postorder(bst([],[],[]), []).
postorder(bst(X,[],[]), [X]). 
postorder(bst(Root,Left,Right), Posttraverse):-
    postorder(Left,LeftNodes), postorder(Right, RightNodes),
    append(LeftNodes, RightNodes,NoRoot), append(NoRoot, [Root], Posttraverse).

%----------------------------------------------------------------------------
search(bst([],[],[]), []).
search(bst(X,[],[]), X).
search(bst(Root,Left,Right),X):-
    X = Root,!;
    X =< Root,
    search(Left, X),!;
    X > Root,
    search(Right,X).

%----------------------------------------------------------------------------
/* test are made to make testing easier and clearer.
    enter a list of numbers to create a tree*/

test_insert(List,Number,Result):-
    makeTree(List,bst([],[],[]),Tree),
    insert(Number,Tree,Result).

test_preorder(List,Result):- 
    makeTree(List,bst([],[],[]),Tree),
    preorder(Tree,Result).

test_inorder(List,Result):- 
    makeTree(List,bst([],[],[]),Tree),
    inorder(Tree,Result).

test_postorder(List,Result):- 
    makeTree(List,bst([],[],[]),Tree),
    postorder(Tree,Result).

test_search(List,Number):- 
    makeTree(List,bst([],[],[]),Tree),
    search(Tree,Number).