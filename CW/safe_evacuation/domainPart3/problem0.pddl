(define (problem Natural_disaster1)
(:domain safe_evacuation)
(:objects
    L3 L5 L6 L7  - location
    group1 - people
    shuttle1 shuttle2 - shuttle
    shelter1  - shelter
)

(:init
(route L3 L6) (route L6 L3)
(route L6 L5) (route L5 L6)
(route L6 L7) (route L7 L6)

(=(distance L3 L6) 300) (=(distance L6 L3) 300)
(=(distance L6 L5) 500) (=(distance L5 L6) 500)
(=(distance L6 L7) 700) (=(distance L7 L6) 700)


(at group1 L5)
(=(peopleLeft group1)90)


(at shelter1 L3)


(at shuttle1 L7)
(=(speed shuttle1) 20)
(empty shuttle1)
(=(IndividualPeopleInShuttle shuttle1)0)
(=(seatsLeft shuttle1)20)
(=(capacity shuttle1)20)


(at shuttle2 L7)
(=(speed shuttle2) 20)
(empty shuttle2)
(=(IndividualPeopleInShuttle shuttle2)0)
(=(seatsLeft shuttle2)20)
(=(capacity shuttle2)20)

)

(:goal
  (and
    (arriveAt group1 shelter1)
    (empty shuttle1)
    (empty shuttle2)

  )
)

)
