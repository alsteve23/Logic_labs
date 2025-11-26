%lexicon
determiner --> [the] | [a] .
noun(cat) --> [cat]  .  
noun(dog)  --> [dog]  .
noun(fish) --> [fish] . 
noun(lion) --> [lion] .
noun(seaswell) -->[seaswell].
noun(bird) --> [bird] .
verb(eat)  --> [eats].
verb(see)  --> [sees].
adjective  --> [big]  | [small] | [angry].
adjectives --> adjective.
adjectives --> adjective, adjective.


sentence(Sem) --> noun_phrase(Subj), verb_phrase(Subj,Sem).
noun_phrase(Subj) --> determiner, adjectives, noun(Subj).
verb_phrase(Subj,Sem) --> verb(V), noun_phrase(Obj), {Sem=..[V,Subj,Obj]}.

%QUERIES
% phrase(sentence(S), [the,big,angry,cat,eats,the,small,fish]).
% S = eat(cat, fish) .

% phrase(sentence(S), [the,angry,lion,sees,the,small,cat]).
% S = see(lion, cat) .

% phrase(sentence(S), [a,small,seaswell,sees,a,big,fish]).
% S = see(seaswell, fish) .

% phrase(sentence(S),[the,small,lion,eats,a, big, fish]).
% S = eat(lion, fish) .