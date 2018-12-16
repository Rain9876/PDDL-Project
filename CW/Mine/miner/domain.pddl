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


(:durative-action miner_dig_mine
	:parameters
  (?m - mine ?mi - miner)
	:duration(= ?duration 10)
	:condition
   (and (at start (has_mineral ?m))
        (over all (is_hand_dug ?m))
        (over all (in_mine ?mi ?m))
        (at start (> (energy ?mi)0))
        (at end (>= (energy ?mi)0))
        (at start(> (mine_capacity ?m) 0))
        (at start (rest ?mi))
        )

	:effect
   (and (at start (decrease (mine_capacity ?m) (digSpeed ?mi)))
        (at start (decrease (energy ?mi) 2))
        (at start (not(rest ?mi)))
        (at end (rest ?mi))
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


  (:durative-action eat
   :parameters
     (?mi - miner ?m - mine)
   :duration (= ?duration 2)
   :condition
     (and (at start (>= (energy ?mi) 0))
          (at start (< (energy ?mi) 10))
          (over all (rest ?mi))
          (over all (in_mine ?mi ?m))
          )
   :effect
     (at end (increase(energy ?mi ) 2))
  )


)
