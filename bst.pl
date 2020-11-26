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
preorder(bst(Root,Left,Right), Pretraverse):-
    preorder(Left,LeftNodes), preorder(Right, RightNode),
    append([Root|LeftNodes], RightNode, Pretraverse).


%------------------------------------------------------------------------------
inorder(bst([],[],[]), []).
inorder(bst(Root,Left,Right), Intraverse):-
    inorder(Left,LeftNodes),inorder(Right,RightNodes),
    append(LeftNodes,[Root|RightNodes],Intraverse).
%------------------------------------------------------------------------------
postorder(bst([],[],[]), []). 
postorder(bst(Root,Left,Right), Postraverse):-
    postorder(Left,LeftNodes), postorder(Right, RightNodes),
    append(LeftNodes, RightNodes,NoRoot), append(NoRoot, [Root], Postraverse).

%----------------------------------------------------------------------------
search(bst(Root,Left,Right),X):-
    X = Root,!;
    X =< Root,
    search(Left, X),!;
    X > Root,
    search(Right,X).
