(define (problem Natural_disaster4)
(:domain safe_evacuation)
(:objects L3 L4 L5 L6 L7 L8 L9 L10 L12 L13 L14 L15 - location
  group1 group2 group3 group4 group5 - people
  casualty1 casualty2 casualty3 casualty4 casualty5 - casualty
  r1 r2 r3 - relief_supplies
  ambu1 ambu2 - ambulance
  truck1 truck2 truck3 - truck
  shuttle1 shuttle2 shuttle3 - shuttle
  hospital1 hospital2 - hospital
  shelter1 shelter2 shelter3 - shelter
)

(:init
(route L3 L4) (route L4 L3)
(route L4 L5) (route L5 L4)
(route L3 L6) (route L6 L3)
(route L6 L5) (route L5 L6)
(route L6 L13) (route L13 L6)
(route L5 L8) (route L8 L5)
(route L9 L8) (route L8 L9)
(route L6 L7) (route L7 L6)
(route L9 L7) (route L7 L9)
(route L7 L10) (route L10 L7)
(route L9 L10) (route L10 L9)
(route L10 L12) (route L12 L10)
(route L7 L12) (route L12 L7)
(route L13 L12) (route L12 L13)
(route L12 L14) (route L14 L12)
(route L12 L15) (route L15 L12)
(route L15 L14) (route L14 L15)
(route L15 L13) (route L13 L15)

(=(distance L3 L4) 1400) (=(distance L4 L3) 1400)
(=(distance L4 L5) 1200) (=(distance L5 L4) 1200)
(=(distance L3 L6) 300) (=(distance L6 L3) 300)
(=(distance L6 L5) 500) (=(distance L5 L6) 500)
(=(distance L6 L13) 1600) (=(distance L13 L6) 1600)
(=(distance L5 L8) 800) (=(distance L8 L5) 800)
(=(distance L9 L8) 1000) (=(distance L8 L9) 1000)
(=(distance L6 L7) 700) (=(distance L7 L6) 700)
(=(distance L9 L7) 500) (=(distance L7 L9) 500)
(=(distance L7 L10) 1100) (=(distance L10 L7) 1100)
(=(distance L9 L10) 800) (=(distance L10 L9) 800)
(=(distance L10 L12) 900) (=(distance L12 L10) 900)
(=(distance L7 L12) 1300) (=(distance L12 L7) 1300)
(=(distance L13 L12) 2100) (=(distance L12 L13) 2100)
(=(distance L12 L14) 600) (=(distance L14 L12) 600)
(=(distance L12 L15) 2800) (=(distance L15 L12) 2800)
(=(distance L15 L14) 2600) (=(distance L14 L15) 2600)
(=(distance L15 L13) 3300) (=(distance L13 L15) 3300)



(at casualty1 L3)
(at casualty2 L10)
(at casualty3 L3)
(at casualty4 L7)
(at casualty5 L10)

(at ambu1 L9)
(=(speed ambu1) 25)
(=(casualtyInAmbulance ambu1)0)
(=(capacity ambu1) 2)

(at ambu2 L12)
(=(speed ambu2) 25)
(=(casualtyInAmbulance ambu2)0)
(=(capacity ambu2) 2)

(at hospital1 L12)
(at hospital2 L9)



(at truck1 L5)
(=(capacity truck1) 1)
(=(speed truck1) 20)

(at truck2 L8)
(=(capacity truck2) 1)
(=(speed truck2) 20)

(at truck3 L14)
(=(capacity truck3) 1)
(=(speed truck3) 20)

(at shelter1 L5)
(at shelter2 L8)
(at shelter3 L14)

(at r1 L14)
(at r2 L14)
(at r3 L14)
(no_supplies shelter1 L5)
(no_supplies shelter2 L8)
(no_supplies shelter3 L14)


(at group1 L3)
(=(peopleLeft group1)40)
(at group2 L10)
(=(peopleLeft group2)12)
(at group3 L4)
(=(peopleLeft group3)15)
(at group4 L13)
(=(peopleLeft group4)10)
(at group5 L15)
(=(peopleLeft group5)20)

(at shuttle1 L14)
(at shuttle2 L14)
(at shuttle3 L14)

(=(speed shuttle1) 20)
(=(speed shuttle2) 20)
(=(speed shuttle3) 20)

(=(IndividualPeopleInShuttle shuttle1)0)
(=(IndividualPeopleInShuttle shuttle2)0)
(=(IndividualPeopleInShuttle shuttle3)0)

(=(seatsLeft shuttle1)20)
(=(seatsLeft shuttle2)20)
(=(seatsLeft shuttle3)20)

(empty shuttle1)
(empty shuttle2)
(empty shuttle3)



)
(:goal(and

      (arriveAt group1 shelter1)
      (arriveAt group2 shelter2)
      (arriveAt group3 shelter3)
      (arriveAt group4 shelter1)
      (arriveAt group5 shelter2)

      (empty shuttle1)
      (empty shuttle2)
      (empty shuttle3)

      (stay casualty1 hospital1)
      (stay casualty2 hospital1)
      (stay casualty3 hospital1)
      (stay casualty4 hospital2)
      (stay casualty5 hospital2)

      (drop r1 shelter1)
      (drop r2 shelter2)
      (drop r3 shelter3)

      )

)

(:metric minimize(total-time))

)
