(define (problem mineProb2)
(:domain mine)
(:objects
  miner1 miner2 miner3 - miner
	excavator1 excavator2 - excavator
  mine_A mine_B mine_C mine_D mine_E mine_F mine_G - mine
  )

(:init
  (in_mine miner1 mine_A)
  (=(speed miner1) 5)
  (=(digSpeed miner1) 2)
  (=(energy miner1)10)
  (rest miner1)

  (in_mine miner2 mine_C)
  (=(speed miner2) 5)
  (=(digSpeed miner2) 2)
  (=(energy miner2)10)
  (rest miner2)

  (in_mine miner3 mine_E)
  (=(speed miner3) 5)
  (=(digSpeed miner3) 2)
  (=(energy miner1)10)
  (rest miner3)


  (in_mine excavator1 mine_B)
  (=(speed excavator1) 2)
  (=(digSpeed excavator1)5)
  (=(fuel_level excavator1)20)
  (rest excavator1)

  (in_mine excavator2 mine_D)
  (=(speed excavator2) 2)
  (=(digSpeed excavator2)5)
  (=(fuel_level excavator2)20)
  (rest excavator2)


  (route mine_A mine_B)  (route mine_B mine_A)
  (route mine_A mine_G)  (route mine_D mine_A)
  (route mine_B mine_C)  (route mine_C mine_B)
  (route mine_D mine_C)  (route mine_C mine_D)
  (route mine_D mine_E)  (route mine_E mine_D)
  (route mine_G mine_E)  (route mine_E mine_G)
  (route mine_G mine_F)  (route mine_F mine_G)



  (=(distance mine_A mine_B) 50)
  (=(distance mine_A mine_G) 100)
  (=(distance mine_B mine_C) 80)
  (=(distance mine_D mine_C) 50)
  (=(distance mine_D mine_E) 100)
  (=(distance mine_G mine_E) 80)
  (=(distance mine_G mine_F) 50)

  (=(distance mine_B mine_A) 50)
  (=(distance mine_G mine_A) 100)
  (=(distance mine_C mine_B) 80)
  (=(distance mine_C mine_D) 50)
  (=(distance mine_E mine_D) 100)
  (=(distance mine_E mine_G) 80)
  (=(distance mine_F mine_G) 50)



  (has_mineral mine_A)(is_hand_dug mine_A)
  (has_mineral mine_B)(is_machine_dug mine_B)
  (has_mineral mine_C)(is_hand_dug mine_C)(is_machine_dug mine_C)
  (has_mineral mine_D)(is_hand_dug mine_D)(is_machine_dug mine_D)
  (has_mineral mine_E)(is_machine_dug mine_E)
  (has_mineral mine_F)(is_machine_dug mine_F)
  (has_mineral mine_G)(is_hand_dug mine_G)


  (=(mine_capacity mine_A) 10)
  (=(mine_capacity mine_B) 10)
  (=(mine_capacity mine_C) 10)
  (=(mine_capacity mine_D) 10)
  (=(mine_capacity mine_E) 10)
  (=(mine_capacity mine_F) 10)
  (=(mine_capacity mine_G) 10)

)


  (:goal
   (and
        (has_no_mineral mine_A)
        (has_no_mineral mine_B)
        (has_no_mineral mine_C)
        (has_no_mineral mine_D)
        (has_no_mineral mine_E)
        (has_no_mineral mine_F)
        (has_no_mineral mine_G)
   )
  )

)
