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

; action for relief_supplies to be loaded


(:durative-action Load
  :parameters
  (?truck - truck ?r - relief_supplies ?loc - location)
  :duration(= ?duration 10)
  :condition
   (and (over all (at ?truck ?loc))
        (at start (at ?r ?loc))
        (at start (> (capacity ?truck)0))
        )
  :effect
   (and (at end (on ?r ?truck))
        (at start (decrease (capacity ?truck)1))
        (at start (not(at ?r ?loc)))
        )
)


; action for relief_supplies to be unloaded

(:durative-action Unload
  :parameters
  (?truck - truck ?r - relief_supplies ?shelter - shelter ?loc - location)
  :duration(=?duration 10)
  :condition
   (and (over all (at ?truck ?loc))
        (over all (at ?shelter ?loc))
        (at start (on ?r ?truck))
        (at start (no_supplies ?shelter ?loc))
        )
  :effect
   (and (at end (drop ?r ?shelter))
        (at end (increase (capacity ?truck)1))
        (at start (not (no_supplies ?shelter ?loc)))
        (at end (not(on ?r ?truck)))
        )
)


; action for one casualty to be picked up

(:durative-action Get_on_Ambu
  :parameters
  (?ambu - ambulance ?casualty - casualty ?loc - location)
  :duration (=?duration 5)
  :condition
   (and (over all(at ?ambu ?loc))
        (at start(at ?casualty ?loc))
        (at start (< (casualtyInAmbulance ?ambu)(capacity ?ambu)))
        )
  :effect
   (and (at start(increase (casualtyInAmbulance ?ambu) 1))
        (at start(not (at ?casualty ?loc)))
        (at end (on ?casualty ?ambu))
        )
)


; action for one casualty to be dropped

(:durative-action Get_off_Ambu
  :parameters
  (?ambu - ambulance ?casualty - casualty ?hospital - hospital ?loc -location)
  :duration (=?duration 5)
  :condition
   (and (over all (at ?ambu ?loc))
        (at start (on ?casualty ?ambu))
        (over all (at ?hospital ?loc))
        (at start (> (casualtyInAmbulance ?ambu) 0))
        )
  :effect
   (and (at start (decrease (casualtyInAmbulance ?ambu) 1))
        (at end (not(on ?casualty ?ambu)))
        (at end (stay ?casualty ?hospital))
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
(?loc - location ?shuttle - shuttle ?shelter - shelter)
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
:parameters(?people - people ?loc - location ?shuttle - shuttle ?shelter - shelter)
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
