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
)

(:functions

  (distance ?l1 - location ?l2 - location)

  (capacity ?v - vehicle)

  (casualtyInAmbulance ?a - ambulance)

  (timeLimits ?l1 ?l2 - location)

  (peopleLeft ?p - people)

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


; action for ambulance, truck, shuttle to move

(:durative-action Rescue
  :parameters
  (?vehicle - vehicle ?from - location ?to - location)
  :duration(=?duration (/(distance ?from ?to)(speed ?vehicle)))
  :condition
   (and (at start (at ?vehicle ?from))
        (over all (route ?from ?to))
        )
  :effect
   (and (at end (at ?vehicle ?to))
        (at start (not(at ?vehicle ?from)))
        )
)



)
