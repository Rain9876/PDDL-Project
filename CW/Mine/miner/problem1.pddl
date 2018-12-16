(define (problem mineProb1)
(:domain mine)
(:objects
  miner1 miner2 - miner
  mine_A mine_B mine_C mine_D - mine
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



  (route mine_A mine_B)  (route mine_B mine_A)
  (route mine_A mine_D)  (route mine_D mine_A)
  (route mine_D mine_C)  (route mine_C mine_D)

  (=(distance mine_A mine_B) 50)
  (=(distance mine_A mine_D) 100)
  (=(distance mine_C mine_D) 80)

  (=(distance mine_B mine_A) 50)
  (=(distance mine_D mine_A) 100)
  (=(distance mine_D mine_C) 80)



  (has_mineral mine_A)(is_hand_dug mine_A)
  (has_mineral mine_C)(is_hand_dug mine_C)(is_machine_dug mine_C)
  (has_mineral mine_D)(is_hand_dug mine_D)(is_machine_dug mine_D)

  (=(mine_capacity mine_A) 10)
  (=(mine_capacity mine_C) 10)
  (=(mine_capacity mine_D) 10)




)


  (:goal
   (and
        (has_no_mineral mine_A)
        (has_no_mineral mine_C)
        (has_no_mineral mine_D)

  )
  )

)
