
%lexicon
determiner --> [the]  | [a].
noun       --> [cat]  | [dog] | [fish] | [lion] |[seaswell] | [bird] .
verb       --> [eats] | [sees].
adjective  --> [big]  | [small] | [angry].
adjectives --> adjective.
adjectives --> adjective, adjective.


sentence	-->	noun_phrase , verb_phrase.	
noun_phrase	-->	determiner  ,adjectives, noun.	
verb_phrase	-->	verb        , noun_phrase.	
