(define (problem mineProb1)
(:domain mine)
(:objects
	excavator1  - excavator
  mine_A mine_B mine_C mine_D - mine
  )

(:init

  (in_mine excavator1 mine_B)
  (=(speed excavator1) 2)
  (=(digSpeed excavator1)5)
  (=(fuel_level excavator1)20)
  (rest excavator1)


  (route mine_A mine_B)  (route mine_B mine_A)
  (route mine_A mine_D)  (route mine_D mine_A)
  (route mine_D mine_C)  (route mine_C mine_D)

  (=(distance mine_A mine_B) 50)
  (=(distance mine_A mine_D) 100)
  (=(distance mine_C mine_D) 80)

  (=(distance mine_B mine_A) 50)
  (=(distance mine_D mine_A) 100)
  (=(distance mine_D mine_C) 80)



  (has_mineral mine_B)(is_machine_dug mine_B)
  (has_mineral mine_C)(is_hand_dug mine_C)(is_machine_dug mine_C)
  (has_mineral mine_D)(is_hand_dug mine_D)(is_machine_dug mine_D)

  (=(mine_capacity mine_B) 10)
  (=(mine_capacity mine_C) 10)
  (=(mine_capacity mine_D) 10)




)


  (:goal
   (and
        (has_no_mineral mine_B)
        (has_no_mineral mine_C)
        (has_no_mineral mine_D)

  )
  )

)
