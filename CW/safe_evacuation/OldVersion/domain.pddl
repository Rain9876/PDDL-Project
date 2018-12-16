(define (domain safe_evacuation)
(:requirements :strips :typing :numeric-fluents :durative-actions :conditional-effects)
(:types
    location place locatable - object
    target vehicle - locatable
    people casualty relief_supplies - target
    ambulance truck shuttle - vehicle
    hospital shelter - place
)

(:predicates
  (route ?l1 - location ?l2 - location)
  (locate ?pl - place ?l - location)
  (at ?loc - locatable ?l - location)
  (on ?t - target ?v - vehicle )
  (notHas_supplies ?s - shelter ?l - location)
  (ArriveAt ?p - people ?s - shelter)
  (stay ?c - casualty ?h - hospital)
  (drop ?r - relief_supplies ?s - shelter)
  (Not_empty ?sh - shuttle)
  (empty ?sh - shuttle)
)

(:functions
  (distance ?l1 - location ?l2 - location)
  (capacity ?v - vehicle)
  (casualty_in_ambulance ?a - ambulance)
  (timeLimits ?l1 - location ?l2 - location)
  (Contains ?p - people)
  (seat ?sh - shuttle)
  (speed ?v - vehicle)
)


; action for relief_supplies to be loaded

(:durative-action Load
  :parameters (?t - truck ?r - relief_supplies ?l - location)
  :duration(= ?duration 10)
  :condition
   (and (at start (at ?t ?l))
        (at start(at ?r ?l))
        )
  :effect
   (and (at end (on ?r ?t))
        (at start (not(at ?r ?l)))
        )
)


; action for relief_supplies to be unloaded

(:durative-action Unload
  :parameters(?t - truck ?r - relief_supplies ?s - shelter ?l - location)
  :duration(=?duration 10)
  :condition
   (and (at start (at ?t ?l))
        (over all (locate ?s ?l))
        (at start (on ?r ?t))
        (at start (notHas_supplies ?s ?l))
  )
  :effect
   (and (at end (drop ?r ?s))
        (at start (not (notHas_supplies ?s ?l)))
        (at end (not(on ?r ?t)))
        )
)


; action for ambulance to move

(:durative-action Rescue
  :parameters(?v - vehicle ?from - location ?to - location)
  :duration(=?duration (/(distance ?from ?to)(speed ?v)))
  :condition
   (and (at start(at ?v ?from))
        (over all (route ?from ?to))
        )
  :effect
   (and (at end(at ?v ?to))
        (at start(not(at ?v ?from)))
        )
)

; action for casualty to be picked up

(:durative-action Get_on
  :parameters(?a - ambulance ?c - casualty ?l - location)
  :duration (=?duration 5)
  :condition
   (and (over all(at ?a ?l))
        (at start(at ?c ?l))
        (at start(<(casualty_in_ambulance ?a)(capacity ?a)))
        )
  :effect
   (and (at start(increase (casualty_in_ambulance ?a) 1))
        (at start(not (at ?c ?l)))
        (at end(on ?c ?a))
        )
)


; action for casualty to be dropped

(:durative-action Get_off
  :parameters(?a - ambulance ?c - casualty ?h - hospital ?l -location)
  :duration (=?duration 5)
  :condition(and (over all(at ?a ?l))
  (at start(on ?c ?a))
  (over all (locate ?h ?l))
  (at start(> (casualty_in_ambulance ?a) 0))
  )
  :effect(and (at start(decrease (casualty_in_ambulance ?a) 1))
  (at end(not(on ?c ?a)))
  (at end (stay ?c ?h))
  )
)


; action for people arrive at shelter

(:durative-action TakeOnShuttle1
:parameters(?p - people ?l - location ?sh - shuttle)
:duration(=?duration (Contains ?p))
:condition(and (at start(at ?p ?l))
(over all(at ?sh ?l))
(at start(>(Contains ?p)0))
(at start(>(seat ?sh)0))
(at start(<=(seat ?sh)(capacity ?sh)))
(at start(<=(Contains ?p)(seat ?sh)))
)
:effect(and (at start(decrease(seat ?sh)(Contains ?p)))
(at start (not(at ?p ?l)))
(at end (on ?p ?sh))
(at end (not(empty ?sh)))
(at end (Not_empty ?sh))
(at end(assign(Contains ?p)0))
)
)


; action for people arrive at shelter

(:durative-action TakeOnShuttle2
:parameters(?p - people ?l - location ?sh - shuttle)
:duration(=?duration (seat ?sh))
:condition(and (over all(at ?p ?l))
(over all (>(Contains ?p)0))
(over all(at ?sh ?l))
(at start(>(seat ?sh)0))
(at start(<=(seat ?sh)(capacity ?sh)))
(at start(>(Contains ?p)(seat ?sh)))
)
:effect(and (at start(decrease(Contains ?p)(seat ?sh)))
(at start (assign(seat ?sh)0))
(at end (not(empty ?sh)))
(at end (Not_empty ?sh))
)
)


; action for people arrive at shelter

(:durative-action PeopleMoveToShetler
:parameters(?l - location ?sh - shuttle ?s - shelter)
:duration(=?duration (-(capacity ?sh)(seat ?sh)))
:condition(and
(over all(locate ?s ?l))
(over all(at ?sh ?l))
(at start(Not_empty ?sh))
)
:effect(and (at end(empty ?sh))
(at end(assign(seat ?sh)(capacity ?sh)))
(at end(not(Not_empty ?sh)))
)
)


; action for people arrive at shelter

(:durative-action GroupMoveToShetler
:parameters(?p - people ?l - location ?sh - shuttle ?s - shelter)
:duration(=?duration 1)
:condition(and
(over all(locate ?s ?l))
(over all(at ?sh ?l))
(at start(on ?p ?sh))
(over all(empty ?sh))
)
:effect(and (at start(not(on ?p ?sh)))
(at end(ArriveAt ?p ?s))
)
)
)
