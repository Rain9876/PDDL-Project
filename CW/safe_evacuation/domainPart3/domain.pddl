(define (domain safe_evacuation)
(:requirements :strips :typing :numeric-fluents :durative-actions :conditional-effects)
(:types
    location locatable - object
    target vehicle place - locatable
    people casualty relief_supplies - target
    ambulance truck shuttle - vehicle
    hospital shelter - place
)



(:predicates

  (route ?l1 - location ?l2 - location)

  (at ?loc - locatable ?l - location)

  (on ?t - target ?v - vehicle )

  (no_supplies ?s - shelter ?l - location)

  (arriveAt ?p - people ?s - shelter)

  (stay ?c - casualty ?h - hospital)

  (drop ?r - relief_supplies ?s - shelter)

  (empty ?sh - shuttle)

)


(:functions

  (distance ?l1 - location ?l2 - location)

  (capacity ?v - vehicle)

  (casualtyInAmbulance ?a - ambulance)

  (peopleLeft ?p - people)

  (seatsLeft ?sh - shuttle)

  (IndividualPeopleInShuttle ?sh - shuttle)

  (speed ?v - vehicle)
)




; action for ambulance, truck, shuttle to move

(:durative-action Rescue
  :parameters
  (?vehicle - vehicle ?from - location ?to - location)
  :duration(= ?duration (/(distance ?from ?to)(speed ?vehicle)))
  :condition
   (and (at start (at ?vehicle ?from))
        (over all (route ?from ?to))
        )
  :effect
   (and (at end(at ?vehicle ?to))
        (at start(not(at ?vehicle ?from)))
        )
)




; shuttle is not full, all the group of people can get on

(:durative-action Get_On_Shuttle_way1
:parameters
(?people - people ?loc - location ?shuttle - shuttle)
:duration(=?duration (peopleLeft ?people))
:condition
 (and (over all(at ?shuttle ?loc))
      (at start(at ?people ?loc))
      (at start (<=(peopleLeft ?people)(seatsLeft ?shuttle)))     ; people left in the group can fit in the shuttle
      )
:effect
 (and (at start (not(at ?people ?loc)))
      (at start (decrease(seatsLeft ?shuttle)(peopleLeft ?people)))    ;decrease seats left
      (at end (on ?people ?shuttle))
      )
)





; shuttle is full, not all the group of people can get on

(:durative-action Get_On_Shuttle_way2
:parameters
(?people - people ?loc - location ?shuttle - shuttle)
:duration(=?duration (seatsLeft ?shuttle))
:condition
 (and (over all (at ?shuttle ?loc))
      (over all (at ?people ?loc))                                     ; group people left
      (at start (empty ?shuttle))
      (at start(>(peopleLeft ?people)(seatsLeft ?shuttle)))
      )
:effect
 (and (at start(decrease(peopleLeft ?people)(seatsLeft ?shuttle)))
      (at start(assign(IndividualPeopleInShuttle ?shuttle)(seatsLeft ?shuttle)))
      (at start (assign(seatsLeft ?shuttle)0))                          ; no seats left
      (at start (not (empty ?shuttle)))
      )
)





; action for people arrive at shelter

(:durative-action Individual_People_MoveToShetler
:parameters
(?loc - location ?shelter - shelter ?shuttle - shuttle)
:duration(=?duration (IndividualPeopleInShuttle ?shuttle))
:condition
 (and (over all(at ?shelter ?loc))
      (over all(at ?shuttle ?loc))
      (at start(>(IndividualPeopleInShuttle ?shuttle)0))               ; Individual people in the shuttle
      )
:effect
 (and (at start (increase(seatsLeft ?shuttle)(IndividualPeopleInShuttle ?shuttle)))
      (at start (assign(IndividualPeopleInShuttle ?shuttle) 0))
      (at end (empty ?shuttle))
      )
)





; action for Group people arrive at shelter

(:durative-action Group_People_MoveToShetler
:parameters(?people - people ?loc - location ?shelter - shelter ?shuttle - shuttle)
:duration(=?duration (peopleLeft ?people))
:condition
 (and (over all(at ?shelter ?loc))
      (over all(at ?shuttle ?loc))
      (at start(on ?people ?shuttle))                           ; This group people in the shuttle
      (over all(=(IndividualPeopleInShuttle ?shuttle)0))         ; no scatter people in the shuttle
      )
:effect
 (and (at start(not(on ?people ?shuttle)))
      (at end(increase(seatsLeft ?shuttle)(peopleLeft ?people)))
      (at end(arriveAt ?people ?shelter))
      )
)


)
