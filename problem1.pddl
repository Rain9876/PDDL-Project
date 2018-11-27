(define (problem Natural_disaster1)
(:domain safe_evacuation)
(:objects
    l3 l5 l6 l7 l8 l9 l10 l12 l14 - location
    group1 group2 - people
    casulty1 casulty2 casulty3 casulty4 casulty5 - casualty
    r1 r2 r3 - relief_supplies
    ambu1 ambu2 - ambulance
    truck1 truck2 truck3 - truck
    shuttle1 shuttle2 shuttle3 - shuttle
    hospital - hospital
    shelter - shelter
)

(:init
(route l3 l6) (route l6 l3)
(route l6 l5) (route l5 l6)
(route l5 l8) (route l8 l5)
(route l9 l8) (route l8 l9)
(route l6 l7) (route l7 l6)
(route l9 l7) (route l7 l9)
(route l7 l10) (route l10 l7)
(route l9 l10) (route l10 l9)
(route l10 l12) (route l12 l10)
(route l7 l12) (route l12 l7)
(route l12 l14) (route l14 l12)


(=(distance l3 l6) 300) (=(distance l6 l3) 300)
(=(distance l6 l5) 500) (=(distance l5 l6) 500)
(=(distance l5 l8) 800) (=(distance l8 l5) 800)
(=(distance l9 l8) 1000) (=(distance l8 l9) 1000)
(=(distance l6 l7) 700) (=(distance l7 l6) 700)
(=(distance l9 l7) 500) (=(distance l7 l9) 500)
(=(distance l7 l10) 1100) (=(distance l10 l7) 1100)
(=(distance l9 l10) 800) (=(distance l10 l9) 800)
(=(distance l10 l12) 900) (=(distance l12 l10) 900)
(=(distance l7 l12) 1300) (=(distance l12 l7) 1300)
(=(distance l12 l14) 600) (=(distance l14 l12) 600)

(=(timeLimits l3 l6) 200) (=(timeLimits l6 l3) 200)
(=(timeLimits l6 l5) 200) (=(timeLimits l5 l6) 200)
(=(timeLimits l5 l8) 200) (=(timeLimits l8 l5) 200)
(=(timeLimits l6 l7) 200) (=(timeLimits l7 l6) 200)
(=(timeLimits l9 l7) 200) (=(timeLimits l7 l9) 200)
(=(timeLimits l7 l10) 200) (=(timeLimits l10 l7) 200)
(=(timeLimits l9 l10) 200) (=(timeLimits l10 l9) 200)
(=(timeLimits l10 l12) 200) (=(timeLimits l12 l10) 200)
(=(timeLimits l7 l12) 200) (=(timeLimits l12 l7) 200)
(=(timeLimits l12 l14) 200) (=(timeLimits l14 l12) 200)

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

(at hospital l12)
(at hospital l9)

(at truck1 l8)
(at truck2 l5)
(at truck3 l14)
(=(speed truck1) 20)
(=(speed truck2) 20)
(=(speed truck3) 20)

(at shelter l5)
(at shelter l8)
(at shelter l14)

(at r1 l14)
(at r2 l14)
(at r3 l14)

(no_supplies shelter l5)
(no_supplies shelter l8)
(no_supplies shelter l14)


(at group1 l3)
(=(groupPeopleLeft group1)40)
(at group2 l10)
(=(groupPeopleLeft group2)12)

(at shuttle1 l14)
(at shuttle2 l14)
(at shuttle3 l14)
(=(speed shuttle1) 20)
(=(speed shuttle2) 20)
(=(speed shuttle3) 20)
(=(scatteredPeopleInShuttle shuttle1)0)
(=(scatteredPeopleInShuttle shuttle2)0)
(=(scatteredPeopleInShuttle shuttle2)0)
(=(capacity shuttle1)20)
(=(capacity shuttle2)20)
(=(capacity shuttle3)20)
(=(seatsLeft shuttle1)20)
(=(seatsLeft shuttle2)20)
(=(seatsLeft shuttle3)20)

)

(:goal
  (and
    (arriveAt group1 shelter)
    (arriveAt group2 shelter)

    (stay casulty1 hospital)
    (stay casulty2 hospital)
    (stay casulty3 hospital)
    (stay casulty4 hospital)
    (stay casulty5 hospital)

    (at r1 shelter)
    (at r2 shelter)
    (at r3 shelter)
  )
)

)
