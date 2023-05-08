%
fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, F) :-
  N > 1,
  N1 is N - 1,
  N2 is N - 2,
  fibonacci(N1, F1),
  fibonacci(N2, F2),
  F is F1 + F2.

% is a number in a list?
member(X,[X|_]).
member(X,[_|T]):- member(X, T).

% size of list
size([],0).
size([_|T], N):- size(T,N1), N is N1 + 1.

% sum of list
sum_list([], 0).
sum_list([H|T], N):- sum_list(T,N1), N is N1 + H.

% search in list
search(X,[X|_]).
search(X,[_|Y]):- search(X, Y).

% is sorted?
is_sorted([]). % ures lista az
is_sorted([_]). % egyelemu is
is_sorted([X, Y | T]):- X =< Y, is_sorted([Y | T]).

% append two lists
append([], L2, L2).
append([H|T], L2, [H|L3]):- append(T, L2, L3).
%
torol_elso([],[]).
torol_elso([_|T],T).
%
beszur_ide(L,X,0,[X|L]).
beszur_ide([H|T],X,I,[H|U]):-
    I>0,
    J is I-1,
    beszur_ide(T,X,J,U).
%
is_prime(2).
is_prime(3).
is_prime(N) :-
  N > 3,
  N mod 2 =\= 0,
  \+ has_factor(N, 3).

has_factor(N, F) :-
  N mod F =:= 0.
has_factor(N, F) :-
  F * F < N,
  F2 is F + 2,
  has_factor(N, F2).
%
prime_factors(1, []).

prime_factors(N, [F|Fs]) :-
  N > 1,
  smallest_factor(N, F),
  N1 is N // F,
  prime_factors(N1, Fs).

smallest_factor(N, F) :-
  smallest_factor(N, 2, F).

smallest_factor(N, F, F) :-
  F * F > N, !.
smallest_factor(N, F, F) :-
  N mod F =:= 0, !.
smallest_factor(N, F, R) :-
  F1 is F + 1,
  smallest_factor(N, F1, R).
%
%B 2.Determine the number of elements in a list divisible by 3.
div_by_3([], 0).
div_by_3([X | L], N) :-
    div_by_3(L, N1),
    ((X mod 3) =:= 0 -> 
    N is N1 + 1;
    N is N1
    ).

%A lekérdezés	
%div_by_3([1,2,3,4,5,6,7,8,9,10,11,12], N).



%B 3.Find the largest square number in a list.
largest_square_number([], 0).
largest_square_number([X | L], N) :-
    M is floor(sqrt(X)),
    largest_square_number(L, N1),
    ((M*M =:= X )-> 
      ( X > N1-> 
        N is X;
        N is N1
      )
    ;   N is N1
    ).

%A lekérdezés	
%largest_square_number([2,3,4,5,6,7,8,9,16,25,31],N).

% B 4.Find the greatest common divisor of the list elements (2,4,16,8) > 2

gcd(0, X, X):- X > 0, !.
gcd(X, Y, Z):- X >= Y, X1 is X-Y, gcd(X1,Y,Z).
gcd(X, Y, Z):- X < Y, X1 is Y-X, gcd(X1,X,Z).

devision([X,Y],gcd(X,Y)).
devision([X|L],R):-
    devision(L,R1),
    R is gcd(X,R1).

%A lekérdezés
% devision([2,4,16,8],R)


% B 5.Find a subsequence of a list the sum of which are square numbers. 
% subsequence: not necessarily consecutive list elements, but their order is the same as that in the list


sum_list([],0).
sum_list([N|L],R):-
    sum_list(L,R2),
    R is N+R2.

subsequence(_,[]).   
subsequence([X|L2],[X|L1]) :- subsequence(L2,L1).
subsequence([_|L2],[X|L1]) :- subsequence(L2,[X|L1]).

run_in_list([],[]).
run_in_list([T|L],R):-
    run_in_list(L,R1),
    sum_list(T,S),
    M is floor(sqrt(S)),
    ( S =:= M*M-> 
        append([T],R1,R);
        R = R1
      ).

solve(L,R):-
    findall(LR, subsequence(L,LR), X),
    run_in_list(X,R).
	
%A lekérdezés


%B 6.Given term like this f(g(a,b), f(a,g(a,b) ) a,b: arguments , Exchange every a in the term to b.

exchange([a],Term):-
    Term = b.
exchange([b],Term):-
    Term = a.
    
exchange([H|T],Term):-
    nth0(0,T,T1),
    nth0(1,T,T2),
	T1 =.. List1,
    T2 =.. List2,
    exchange(List1,Term2),
    exchange(List2,Term3),
    Term =.. [H,Term2,Term3].

%A lekérdezések
%f(g(a,b), f(a,g(a,b) )) =.. List,
%exchange(List,Term).

%B 8.Find the levels of a tree that contains cube numbers.

btree(N):- integer(N); N=nil.
btree((N,L,R)):- integer(N), btree(L), btree( R).

cube_number(X) :-
   nth_integer_root_and_remainder(3, X, Root, 0),
   M is floor(Root),
   (M*M*M =:= X ).
 
search((N,L,R),List_out, Level):-
    
    Level_1 is Level +1,
    (   integer(L)->
    		( cube_number(L) ->
            	List2 = [Level_1];
    			List2 = []
    		);
    		search(L,List2,Level_1)
	),
    (   integer(R)->
    		( cube_number(R) ->
    			List3 = [Level_1];
    			List3 = []
    		);
    		search(R,List3,Level_1)
	),
    ( cube_number(N) ->  
    	append(List2,List3,List4),
    	append([Level],List4,List);
    	append(List2,List3,List)
    ),
    sort(List,List_out). 

%A lekérdezések
%btree((0,(1,3,4),(2,5,6 ))).
%search((2,2,8),List,0).
%search((0,(1,3,4),(2,5,6 )),List,0).
%search((8,(5,3,4),(4,5,6 )),List,0).
%search((7,(8,3,4),(4,27,6 )),List,0).
%search((3,(27,(8,7,9),(36,16,64)),(4,8,6 )),List,0).

%%
gcd(X,0,X).
gcd(X,Y,Z):-
    R is mod(X,Y),
    gcd(Y,R,Z).
