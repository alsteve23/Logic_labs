%Building a Simple Exoert System

%FOOD RECOMMENDATION SYSTEM
salty(encebollado).
salty(hornado).
salty(pizza).
salty(hamburger).

sweety(cake).
sweety(brownie).
sweety(ice_cream).
sweety(chocolate).

national_food(encebollado).
national_food(hornado).
national_food(yahuarlocro).
national_food(michelada).
american_food(pizza).
american_food(hamburger).
american_food(pasta).

expensive(brownie).
expensive(hornado).
expensive(pasta).
expensive(yahuarlocro).

drink(milkshake).
drink(michelada).
drink(mojito).
drink(wine).

portionable(pizza).
portionable(brownie).
portionable(cake).


%Defining rules

is_national(X):- national_food(X).
is_cheap(X):- \+ expensive(X).
is_dessert(X) :- sweety(X).
to_share(X) :- portionable(X).
is_interational(X) :- american_food(X).
main_dish(X) :- salty(X).
is_drink(X) :- drink(X).


%Interactive Questions

ask(Question,	Answer)	:-	
write(Question),	write('	(yes/no):	'),	nl,	
read(Answer).

%Inference Engine
recommend_food(Food) :-
    ask('Do you want something salty?', Salty),
    (Salty == yes ->
        ask('Do you prefer national food?', Nat),
        (Nat == yes ->
            ask('Do you want something cheap?', Cheap),
            (Cheap == yes -> Food = encebollado ; Food = hornado)
        ;
            ask('Do you want something to share?', Share),
            (Share == yes -> Food = pizza ; Food = pasta))
    ;
        ask('Do you want dessert?', Dessert),
        (Dessert == yes ->
            ask('Do you want something cheap?', CheapDessert),
            (CheapDessert == yes -> Food = cake ; Food = brownie)
        ;
            ask('Do you want a drink?', DrinkQ),
            (DrinkQ == yes ->
                ask('Do you want alcohol?', Alc),
                (Alc == yes -> Food = wine ; Food = milkshake)
            ;
                Food = ice_cream))
    ),
    write('My recommendation is: '), write(Food), nl.

%Ambiguity Food
possible_foods(List) :-
    findall(F, (salty(F); sweety(F); drink(F)), RawList),
    sort(RawList, List).
