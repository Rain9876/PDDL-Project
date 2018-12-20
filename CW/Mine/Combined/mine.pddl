(define (domain mine)
(:requirements :strips :typing :numeric-fluents :durative-actions :conditional-effects)
(:types
        miner excavator - digger
        mine
        )

(:predicates

        (has_mineral ?m - mine)

        (has_no_mineral ?m - mine)

        (is_machine_dug ?m - mine)

        (is_hand_dug ?m - mine)

        (in_mine ?d - digger ?m - mine)

        (miner_hungry ?mi - miner)

        (excavator_lack_fuel ?e - excavator)

        (route ?m1 ?m2 - mine)

        (rest ?d - digger)

        )

(:functions

        (speed ?d - digger)

        (digSpeed ?d - digger)

        (distance ?m1 ?m2 - mine)

	      (fuel_level ?e - excavator)

        (energy ?mi - miner)

        (mine_capacity ?m - mine)

        )

  ; Durative action for a miner to dig the mineral in the mine

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



  ; Durative action for machine to excavate the mineral in the mine

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

  ; Action for moving the miners and excavators

  (:durative-action move_mine
   	:parameters
     (?digger - digger ?from -mine ?to - mine)
   	:duration(= ?duration (/(distance ?from ?to)(speed ?digger)))
   	:condition
      (and (over all (route ?from ?to))
           (at start (in_mine ?digger ?from))
           )
   	:effect
      (and (at end (in_mine ?digger ?to))
           (at start (not(in_mine ?digger ?from)))
           )
  )

  ; action to illustrate the mine has been excavated

  (:action mime_empty
  :parameters (?m - mine)
  :precondition
   (<=(mine_capacity ?m) 0)
  :effect
   (and (has_no_mineral ?m)
        (not(has_mineral ?m))
        )
  )


  ; action for mine to replenish their strength

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


  ; action to fuel the excavator

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
        (at end (increase(fuel_level ?e )10))
  )


)
