(define (domain mine)
(:requirements :strips :typing :numeric-fluents :durative-actions :conditional-effects)
(:types miners
        excavator
        mine
        tramcar)

(:predicates

        (has_mineral ?m - mine)

        (has_no_mineral ?m - mine)

        (is_machine_dug ?m - mine)

        (is_hand_dug ?m - mine)

        (miners_in_mine ?mi - miners ?m - mine)

        (excavator_in_mine ?e - excavator ?m - mine)

        (miners_hungry ?mi - miners)

        (excavator_lack_fuel ?e - excavator)

        )

(:functions

	      (fuel_level ?e - excavator)

        (available_capacity ?t - tramcar)

        (energy ?mi - miners)

        )

(:durative-action miners_dig_mine
	:parameters
  (?m - mine ?mi - miners ?t - tramcar)
	:duration(= ?duration 8)
	:condition
  (and (at start ( miners_hungry ?mi))
		   (over all (has_mineral ?m))
       (over all (is_hand_dug ?m))
       (over all (miners_in_mine ?mi ?m))
       (over all (> (energy ?mi) 2 ))
       (over all (> (available_capacity ?t) 0))
       )
	:effect
   (and (at start (not (miners_hungry ?mi) ) )
	      (at end (not (has_mineral ?m)))
        (at end (has_no_mineral ?m) )
        (at end (decrease (energy ?mi) 2 ))
        (at end (miners_hungry ?mi))
        (at end (decrease (available_capacity ?t) 1 ))
        )
  )

(:durative-action machine_dig_mine
	:parameters
  (?m - mine ?e - excavator ?t - tramcar)
	:duration (= ?duration 4)
	:condition
   (and (at start (excavator_lack_fuel ?e))
		    (over all (has_mineral ?m))
        (over all (is_machine_dug ?m))
        (over all (excavator_in_mine ?e ?m))
        (over all (>(fuel_level ?e)0))
        (over all (>(available_capacity ?t)0))
        )
	:effect
   (and (at start (not (excavator_lack_fuel ?e)))
		    (at end (not (has_mineral ?m)))
        (at end (has_no_mineral ?m))
        (at end (decrease (fuel_level ?e)2))
        (at end (excavator_lack_fuel ?e))
        (at end (decrease (available_capacity ?t) 1 ))
        )
  )

(:durative-action miners_move_mine
	:parameters
  (?mi - miners ?from ?to - mine)
	:duration(= ?duration 2)
	:condition
   (and (over all (miners_in_mine ?mi ?from))
        (over all (miners_hungry ?mi))
        )
	:effect
   (and (at start (miners_hungry ?mi))
		    (at end (miners_in_mine ?mi ?to))
        (at end (not(miners_in_mine ?mi ?from)))
        (at end (miners_hungry ?mi))
        )
  )

(:durative-action machine_move_mine
	:parameters
  (?e - excavator ?from ?to - mine)
	:duration(= ?duration 2)
	:condition
   (and (over all (excavator_in_mine ?e ?from))
        (over all (excavator_lack_fuel ?e))
        )
	:effect
   (and (at start (excavator_lack_fuel ?e))
		    (at end (excavator_in_mine ?e ?to))
        (at end (not (excavator_in_mine ?e ?from)))
        (at end (excavator_lack_fuel ?e))
        )
 )

(:durative-action transport
	:parameters
  (?t - tramcar)
	:duration (= ?duration 5)
	:condition
   (and (at start (>= (available_capacity ?t) 0) )
        (at end (<= (available_capacity ?t) 10 ))
        )
	:effect
   (increase (available_capacity ?t)(* #t 2))
)


(:durative-action eat
	:parameters
   (?mi - miners)
	:duration (= ?duration 1)
	:condition
   (and (at start(miners_hungry ?mi))
        (over all(< (energy ?mi) 3))
        )
	:effect
   (and (at end (not (miners_hungry ?mi)))
		    (at end (increase(energy ?mi )10))
        (at end (miners_hungry ?mi))
        )
)

(:durative-action refuel_excavator
	:parameters
   (?e - excavator)
	:duration(= ?duration 1)
	:condition
   (and (over all (excavator_lack_fuel ?e))
        (over all ( < (fuel_level ?e)1))
        )
	:effect
   (and (at start (not (excavator_lack_fuel ?e)))
	    	(at end (increase(fuel_level ?e)10))
        (at end (excavator_lack_fuel ?e))
        )
 )

)
