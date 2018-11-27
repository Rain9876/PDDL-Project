(define (domain driverlog-simple)
(:requirements :strips :typing :numeric-fluents :durative-actions :conditional-effects)
(:types
    place locatable - object
    vehicle driver truck item - locatable
    nonlandvehicle truck - vehicle
    plane ship - nonlandvehicle
)
(:predicates
    (at ?item - locatable ?loc - place)
    (in ?item - locatable ?t - vehicle)

    (link ?x ?y - place)
    (flightroute ?x ?y - place)
    (sailroute ?x ?y - place)
)

(:functions
  (drivetime ?x ?y - place)
  (sailtime ?x ?y - place)
  (walktime ?x ?y - place)
  (flighttime ?x ?y - place)
)


(:durative-action LOAD-TRUCK
  :parameters
    (?item - item ?truck - truck ?loc - place ?driver - driver)
  :duration (= ?duration 10)
  :condition
    (and (over all (at ?truck ?loc))
         (at start (at ?item ?loc))
         (over all(at ?driver ?loc))
    )
  :effect
   (and (at start (not (at ?item ?loc)))
        (at end (in ?item ?truck))
   )
)

(:durative-action UNLOAD-TRUCK
  :parameters
   (?item - item ?truck - truck ?loc - place ?driver - driver)
  :duration (= ?duration 10)
  :condition
   (and (over all (at ?truck ?loc))
        (at start (in ?item ?truck))
        (over all (at ?driver ?loc))
   )
  :effect
   (and (at start (not (in ?item ?truck)))
        (at end (at ?item ?loc))
   )
)

(:durative-action LOAD
  :parameters
   (?item - item ?vehicle - nonlandvehicle ?loc - place)
  :duration (= ?duration 10)
  :condition
   (and (over all (at ?vehicle ?loc))
        (at start (at ?item ?loc))
   )
  :effect
   (and (at start (not (at ?item ?loc)))
        (at end (in ?item ?vehicle))
   )
)

(:durative-action UNLOAD
  :parameters
   (?item - item ?vehicle - nonlandvehicle ?loc - place)
  :duration (= ?duration 10)
  :condition
   (and (over all (at ?vehicle ?loc))
        (at start (in ?item ?vehicle))
   )
  :effect
   (and (at start (not (in ?item ?vehicle)))
        (at end (at ?item ?loc))
   )
)


(:action BOARD-TRUCK
  :parameters
   (?driver - driver ?truck - truck ?loc - place)
  :precondition
   (and (at ?truck ?loc)
        (at ?driver ?loc)
   )
  :effect
   (and (not (at ?driver ?loc))
        (in ?driver ?truck)
   )
)

(:action GET-OUT
  :parameters
   (?driver - driver ?truck - truck ?loc - place)
  :precondition
   (and (at ?truck ?loc)
        (in ?driver ?truck)
   )
  :effect
   (and (not (in ?driver ?truck))
        (at ?driver ?loc)
   )
)

(:durative-action DRIVE-TRUCK
  :parameters
   (?truck - truck ?loc-from - place ?loc-to - place ?driver - driver)
  :duration (= ?duration (drivetime ?loc-from ?loc-to))
  :condition
   (and (at start (at ?truck ?loc-from))
        (over all (in ?driver ?truck))
        (over all (link ?loc-from ?loc-to))
   )
  :effect
   (and (at start (not (at ?truck ?loc-from)))
        (at end (at ?truck ?loc-to))
   )
)

(:durative-action WALK
  :parameters
   (?driver - driver  ?loc-from - place  ?loc-to - place)
  :duration (= ?duration (walktime ?loc-from ?loc-to))
  :condition
   (and (at start (at ?driver ?loc-from))
        (over all (link ?loc-from ?loc-to))
   )
  :effect
   (and (at start (not (at ?driver ?loc-from)))
        (at end (at ?driver ?loc-to))
   )
)

(:durative-action FLY
  :parameters
   (?plane - plane ?loc-from ?loc-to - place)
  :duration (= ?duration (flighttime ?loc-from ?loc-to))
  :condition
   (and (at start (at ?plane ?loc-from))
        (over all (flightroute ?loc-from ?loc-to)))
  :effect
   (and (at start (not (at ?plane ?loc-from)))
        (at end (at ?plane ?loc-to)))
)

(:durative-action SAIL
  :parameters
   (?ship - ship ?loc-from ?loc-to - place)
  :duration (= ?duration (sailtime ?loc-from ?loc-to))
  :condition
   (and (at start (at ?ship ?loc-from))
        (over all (sailroute ?loc-from ?loc-to)))
  :effect
   (and (at start (not (at ?ship ?loc-from)))
        (at end (at ?ship ?loc-to)))
)


)
