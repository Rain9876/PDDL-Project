(define (problem mineProb)
(:domain mine)
(:objects
  miners1 miners2 - miners
	excavator1 excavator2 - excavator
  mineA mineB mineC mineD mineE mineF mineG mineH mineI mineJ mineK mineL - mine
	tramcar1 tramcar2 tramcar3 - tramcar)

(:init
  (miners_in_mine miners1 mineA)
  (miners_hungry miners1)
  (=(energy miners1)10)

  (miners_in_mine miners2 mineC)
  (miners_hungry miners2)
  (=(energy miners2)10)

  (excavator_in_mine excavator1 mineB)
  (=(fuel_level excavator1)10)
  (excavator_lack_fuel excavator1)

  (excavator_in_mine excavator2 mineC)
  (=(fuel_level excavator2)10)
  (excavator_lack_fuel excavator2)

  (=(available_capacity tramcar1)5)
  (=(available_capacity tramcar2)5)
  (=(available_capacity tramcar3)5)

  (has_mineral mineA)(is_hand_dug mineA)
  (has_mineral mineB)(is_machine_dug mineB)
  (has_mineral mineC)(is_hand_dug mineC)(is_machine_dug mineC)
  (has_mineral mineD)(is_hand_dug mineD)(is_machine_dug mineD)
  (has_mineral mineE)(is_machine_dug mineE)
  (has_mineral mineF)(is_machine_dug mineF)
  (has_mineral mineG)(is_hand_dug mineG)
  (has_mineral mineH)(is_hand_dug mineH)(is_machine_dug mineH)
  (has_mineral mineI)(is_machine_dug mineI)
  (has_mineral mineJ)(is_hand_dug mineJ)
  (has_mineral mineK)(is_hand_dug mineK)(is_machine_dug mineK)
  (has_mineral mineL)(is_hand_dug mineL)

)


(:goal
   (and (has_no_mineral mineA)
        (has_no_mineral mineB)
        (has_no_mineral mineC)
        (has_no_mineral mineD)
        (has_no_mineral mineE)
        (has_no_mineral mineF)
        (has_no_mineral mineG)
        (has_no_mineral mineH)
        (has_no_mineral mineI)
        (has_no_mineral mineJ)
        (has_no_mineral mineK)
        (has_no_mineral mineL)
        )
 )

)
