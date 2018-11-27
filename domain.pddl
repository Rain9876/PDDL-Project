(define (domain safe_evacuation)
(:requirements :strips :typing :numeric-fluents :durative-actions :conditional-effects)
(:types
    location locatable - object
    target vehicle - locatable
    people casualty relief_supplies - target
    ambulance truck shuttle - vehicle
    hospital shelter - location
)


(:predicates

  (route ?l1 - location ?l2 - location)

  (at ?loc - object ?l - location)

  (on ?t - target ?v - vehicle )

  (no_supplies ?s - shelter ?l - location)

  (arriveAt ?p - people ?s - shelter)

  (stay ?c - casualty ?h - hospital)

)

(:functions

  (distance ?l1 - location ?l2 - location)

  (capacity ?v - vehicle)

  (casualtyInAmbulance ?a - ambulance)

  (timeLimits ?l1 ?l2 - location)

  (groupPeopleLeft ?p - people)

  (seatsLeft ?sh - shuttle)

  (scatteredPeopleInShuttle ?sh - shuttle)

  (speed ?v - vehicle)
)


; action for relief_supplies to be loaded
; truck load multi goods

(:durative-action Load
  :parameters
  (?truck - truck ?r - relief_supplies ?loc - location)
  :duration(= ?duration 10)
  :condition
   (and (over all (at ?truck ?loc))
        (at start (at ?r ?loc))
        )
  :effect
   (and (at end (on ?r ?truck))
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
   (and (at end (at ?r ?shelter))
        (at start (not (no_supplies ?shelter ?loc)))
        (at end (not(on ?r ?truck)))
        )
)


; action for ambulance, truck, shuttle to move

(:durative-action Rescue
  :parameters
  (?vehicle - vehicle ?from - location ?to - location)
  :duration(=?duration (/(distance ?from ?to)(speed ?vehicle)))
  :condition
   (and (at start (at ?vehicle ?from))
        (over all (route ?from ?to))
        (over all (<=(/(distance ?from ?to)(speed ?vehicle))(timeLimits ?from ?to)))
        )
  :effect
   (and (at end(at ?vehicle ?to))
        (at start(not(at ?vehicle ?from)))
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
        (over all (<= (casualtyInAmbulance ?ambu)(capacity ?ambu)))
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


; action for people arrive at shelter
; shuttle is not full, all the group of people can get on

(:durative-action Get_On_Shuttle1
:parameters
(?people - people ?loc - location ?shuttle - shuttle)
:duration(=?duration (groupPeopleLeft ?people))
:condition
 (and (over all(at ?shuttle ?loc))
      (at start(at ?people ?loc))
      (over all (<=(groupPeopleLeft ?people)(seatsLeft ?shuttle)))     ; people left in the group can fit in the shuttle
      )
:effect
 (and (at start (decrease(seatsLeft ?shuttle)(groupPeopleLeft ?people)))    ;decrease seats left
      (at start (not(at ?people ?loc)))
      (at end (on ?people ?shuttle))
      )
)


; action for people arrive at shelter
; shuttle is full, not all the group of people can get on

(:durative-action Get_On_Shuttle2
:parameters
(?people - people ?loc - location ?shuttle - shuttle)
:duration(=?duration (seatsLeft ?shuttle))
:condition
 (and (over all(at ?shuttle ?loc))
      (over all(at ?people ?loc))                                     ; group people left
      ;(over all (>(groupPeopleLeft ?people)0))
      (at start(>(groupPeopleLeft ?people)(seatsLeft ?shuttle)))
      )
:effect
 (and (at start(decrease(groupPeopleLeft ?people)(seatsLeft ?shuttle)))
      (at start(increase(scatteredPeopleInShuttle)(seatsLeft ?shuttle)))
      (at end (assign(seatsLeft ?shuttle)0))                          ; no seats left
      )
)


; action for people arrive at shelter

(:durative-action Scattered_People_MoveToShetler
:parameters
(?loc - location ?shuttle - shuttle ?shelter - shelter)
:duration(=?duration (scatteredPeopleInShuttle ?shuttle))
:condition
 (and (over all(at ?shelter ?loc))
      (over all(at ?shuttle ?loc))
      (at start(>(scatteredPeopleInShuttle ?shuttle)0))               ; scattered people in the shuttle
      )
:effect
 (and (at start (increase(seatsLeft ?shuttle)(scatteredPeopleInShuttle ?shuttle)))
      (at end (assign(scatteredPeopleInShuttle ?shuttle) 0))
      )
)


; action for Group people arrive at shelter

(:durative-action Group_People_MoveToShetler
:parameters(?people - people ?loc - location ?shuttle - shuttle ?shelter - shelter)
:duration(=?duration (groupPeopleLeft ?people))
:condition
 (and (over all(at ?shelter ?loc))
      (over all(at ?shuttle ?loc))
      (at start(on ?people ?shuttle))                           ; This group people in the shuttle
      (over all(=(scatteredPeopleInShuttle ?shuttle)0))         ; no scatter people in the shuttle
      )
:effect
 (and (at start(not(on ?people ?shuttle)))
      (at end(increase(seatsLeft ?shuttle)(groupPeopleLeft ?people)))
      (at end(arriveAt ?people ?shelter))
      )
)

)
