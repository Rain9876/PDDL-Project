(define (problem Natural_disaster1)
(:domain safe_evacuation)
(:objects
    L3 L5 L6 L7 L8 L9 L10 L12 L14 - location
    group1 group2 - people
    casulty1 casulty2 casulty3 casulty4 casulty5 - casualty
    r1 r2 - relief_supplies
    ambu1 ambu2 - ambulance
    truck1 truck2 truck3 - truck
    shuttle1 shuttle2 - shuttle
    hospital1 hospital2 - hospital
    shelter1 shelter2 - shelter
)

(:init
(route L3 L6) (route L6 L3)
(route L6 L5) (route L5 L6)
(route L5 L8) (route L8 L5)
(route L9 L8) (route L8 L9)
(route L6 L7) (route L7 L6)
(route L9 L7) (route L7 L9)
(route L7 L10) (route L10 L7)
(route L9 L10) (route L10 L9)
(route L10 L12) (route L12 L10)
(route L7 L12) (route L12 L7)
(route L12 L14) (route L14 L12)


(=(distance L3 L6) 300) (=(distance L6 L3) 300)
(=(distance L6 L5) 500) (=(distance L5 L6) 500)
(=(distance L5 L8) 800) (=(distance L8 L5) 800)
(=(distance L9 L8) 1000) (=(distance L8 L9) 1000)
(=(distance L6 L7) 700) (=(distance L7 L6) 700)
(=(distance L9 L7) 500) (=(distance L7 L9) 500)
(=(distance L7 L10) 1100) (=(distance L10 L7) 1100)
(=(distance L9 L10) 800) (=(distance L10 L9) 800)
(=(distance L10 L12) 900) (=(distance L12 L10) 900)
(=(distance L7 L12) 1300) (=(distance L12 L7) 1300)
(=(distance L12 L14) 600) (=(distance L14 L12) 600)


; domain part1 for truck
(at truck1 L9)
(at truck2 L5)

(=(capacity truck1) 1)
(=(capacity truck2) 1)

(=(speed truck1) 20)
(=(speed truck2) 20)

(at shelter1 L5)
(at shelter2 L8)

(at r1 L14)
(at r2 L14)

(no_supplies shelter1 L5)
(no_supplies shelter2 L8)


; domain part2 for ambulance
(at casulty1 l3)
(at casulty2 l10)
(at casulty3 l3)
(at casulty4 l7)
(at casulty5 l10)

(at ambu1 l9)
(at ambu2 l12)
(=(speed ambu1) 25)
(=(speed ambu2) 25)
(=(casualtyInAmbulance ambu1)0)
(=(casualtyInAmbulance ambu2)0)
(=(capacity ambu1) 2)
(=(capacity ambu2) 2)

(at hospital1 l12)
(at hospital2 l9)



; domain part3 for shuttle
(at group1 L3)
(=(peopleLeft group1)50)

(at group2 L10)
(=(peopleLeft group2)22)


(at shuttle1 L14)
(=(speed shuttle1) 20)
(empty shuttle1)
(=(IndividualPeopleInShuttle shuttle1)0)
(=(seatsLeft shuttle1)20)

(at shuttle2 L14)
(=(speed shuttle2) 20)
(empty shuttle2)
(=(IndividualPeopleInShuttle shuttle2)0)
(=(seatsLeft shuttle2)20)

)


(:goal
  (and
    (arriveAt group1 shelter1)
    (arriveAt group2 shelter2)

    (empty shuttle1)
    (empty shuttle2)

    (stay casulty1 hospital1)
    (stay casulty2 hospital1)
    (stay casulty3 hospital1)
    (stay casulty4 hospital2)
    (stay casulty5 hospital2)

    (drop r1 shelter1)
    (drop r2 shelter2)
  )
)

)
