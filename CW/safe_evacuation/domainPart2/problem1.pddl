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
    hospital1 hospital2 - hospital
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

)

(:goal
  (and

    (stay casulty1 hospital1)
    (stay casulty2 hospital1)
    (stay casulty3 hospital1)
    (stay casulty4 hospital2)
    (stay casulty5 hospital2)

  )
)

)
