(define (domain mine)
(:requirements :strips :typing :numeric-fluents :durative-actions :conditional-effects)
(:types
        digger tramcar - movable
        miner excavator - digger
        mine
        )

(:predicates

        (has_mineral ?m - mine)

        (has_no_mineral ?m - mine)

        (is_machine_dug ?m - mine)

        (is_hand_dug ?m - mine)

        (in_mine ?movable - movable ?m - mine)

        (miner_hungry ?mi - miner)

        (excavator_lack_fuel ?e - excavator)

        (route ?m1 ?m2 - mine)

        (rest ?d - movable)

        )

(:functions

        (speed ?m - movable)

        (digSpeed ?d - digger)

        (distance ?m1 ?m2 - mine)

	      (fuel_level ?e - excavator)

        (available_capacity ?t - tramcar)

        (energy ?mi - miner)

        (mine_capacity ?m - mine)

        )



 (:durative-action machine_dig_mine
 	:parameters
   (?m - mine ?e - excavator)
 	:duration (= ?duration 5)
 	:condition
    (and (at start (has_mineral ?m))
         (over all (is_machine_dug ?m))
         (over all (in_mine ?e ?m))
         (at start (> (fuel_level ?e)0))
         (at end (>= (fuel_level ?e) 0))
         (at start (> (mine_capacity ?m) 0))
         (at start (rest ?e))
         )
 	:effect
    (and (at start (decrease (mine_capacity ?m)(digSpeed ?e)))
         (at start (decrease (fuel_level ?e) 5))
         (at start (not(rest ?e)))
         (at end (rest ?e))
         )
   )


  (:durative-action move_mine
   	:parameters
     (?movable - movable ?from -mine ?to - mine)
   	:duration(= ?duration (/(distance ?from ?to)(speed ?movable)))
   	:condition
      (and (over all (route ?from ?to))
           (at start (in_mine ?movable ?from))
           )
   	:effect
      (and
   		    (at end (in_mine ?movable ?to))
           (at start (not(in_mine ?movable ?from)))
          )
     )


(:action mime_empty
  :parameters (?m - mine)
  :precondition
   (<=(mine_capacity ?m) 0)
  :effect
   (and (has_no_mineral ?m)
        (not(has_mineral ?m))
        )
 )

  (:durative-action refuel_excavator
  	:parameters
     (?e - excavator ?m - mine)
  	:duration(= ?duration 10)
  	:condition
     (and (at start (>=(fuel_level ?e) 0))
          (at start (< (fuel_level ?e) 20))
          (over all (rest ?e))
          (over all (in_mine ?e ?m))
          )
  	:effect
      (at end (increase(fuel_level ?e )10)
   )
  )


)
