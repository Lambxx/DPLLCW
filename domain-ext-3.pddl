( define (domain mailBot-world)
  (:requirements :adl :fluents)

  (:types cell bot scanner package belt switch priority)

  (:predicates
    (Connected ?x - cell ?y - cell)
    (BeltOn ?x - belt)
    (Scanned ?x - package)
    (HoldingObj ?x - bot ?y - object)
    (On ?x - object ?y - cell)
    (Scanner ?x - object)
    (Package ?x - package)
    (Delivered ?x - package)
    (beltCell ?x - cell)
    (Holding ?bot - bot)
    (HoldingHeavy ?bot - bot)
    (rechargeCell ?x - cell)
    (HeavyPackage ?x - package)
    (DifferentBot ?x - bot ?y - bot)
    (firstClass ?x - package)
    (special ?x - package)
        )

    (:functions
      (battery-amount ?mailbot - bot)
      (firstClassRemaining ?first - priority)
      (specialRemaining ?special - priority)
      )
      (:action Deliver
        :parameters(?package - package ?cell - cell ?belt - belt ?mailBot - bot  ?first - priority ?special - priority)
        :precondition(and
          (not (firstClass ?package))
          (not (special ?package))
          (< (firstClassRemaining ?first) 1)
          (< (specialRemaining ?special) 1)
          (BeltOn ?belt)
          (On ?package ?cell)
          (beltCell ?cell)
          (scanned ?package)
            (> (battery-amount ?mailBot) 0) )
       :effect (and
            (Delivered ?package)
            ))

            (:action DeliverFirst
              :parameters(?package - package ?cell - cell ?belt - belt ?mailBot - bot  ?first - priority  ?special - priority)
              :precondition(and
                (< (specialRemaining ?special) 1)
                (BeltOn ?belt)
                (On ?package ?cell)
                (beltCell ?cell)
                (scanned ?package)
                (firstClass ?package)
                  (> (battery-amount ?mailBot) 0)
                  (not (Delivered ?package) )
                  )
              :effect (and
                  (Delivered ?package)
                  (decrease (firstClassRemaining ?first) 1)
                  ))

                  (:action Deliverspecial
                    :parameters(?package - package ?cell - cell ?belt - belt ?mailBot - bot    ?special - priority)
                    :precondition(and

                      (BeltOn ?belt)
                      (On ?package ?cell)
                      (beltCell ?cell)
                      (scanned ?package)
                      (special ?package)
                       (> (battery-amount ?mailBot) 0)
                       (not (Delivered ?package))
                       )
                    :effect (and
                        (Delivered ?package)
                        (decrease (specialRemaining ?special) 1)
                        ))
s
        (:action Recharge
          :parameters(?mailBot - bot ?x - cell)
          :precondition(and
            (On ?mailBot ?x)
            (rechargeCell ?x)
            )
        :effect (assign (battery-amount ?mailbot) 15))


        (:action turnOn
        :parameters (?bot - bot ?cell - cell ?switch - switch ?belt - belt)
        :precondition (and
        (On ?bot ?cell)
        (On ?switch ?cell)
          (> (battery-amount ?bot) 0)
        )
        :effect (BeltOn ?belt))



      (:action PickupScanner
        :parameters (?mailBot - bot ?x - scanner ?y - cell)
        :precondition (and
          (On ?mailBot ?y)
          (On ?x ?y)
          (not (Holding ?mailBot))
            (not (HoldingHeavy ?mailBot))
            (> (battery-amount ?mailBot) 0)
          )
        :effect (and
        (HoldingObj ?mailBot ?x)
        (not (On ?x ?y))
        (Holding ?mailBot)
      )
        )

        (:action Scan
          :parameters (?bot - bot ?object - package ?cell - cell ?scanner - scanner)
          :precondition (and
            (On ?bot ?cell)
            (On ?object ?cell)
            (HoldingObj ?bot ?scanner)
              (> (battery-amount ?bot) 0)
          )

          :effect (Scanned ?object)
          )

          (:action PickupHeavyPackage
            :parameters (?mailBot - bot ?deliveryBot - bot ?x - package ?y - cell)
            :precondition (and
                (DifferentBot ?mailBot ?deliveryBot)

              (On ?mailBot ?y)
              (On ?x ?y)

              (not (HoldingHeavy ?mailBot))
                (not (Holding ?mailBot))
              (> (battery-amount ?mailBot) 0)

                (On ?deliveryBot ?y)
                (On ?x ?y)
                (not (HoldingHeavy ?deliveryBot))
                  (not (Holding ?deliveryBot))
                  (> (battery-amount ?deliveryBot) 0)
              )
            :effect (and
            (HoldingObj ?mailBot ?x)
            (not (On ?x ?y))
            (HoldingHeavy ?mailBot)

            (HoldingObj ?deliveryBot ?x)
            (HoldingHeavy ?deliveryBot)
          )
            )


              (:action PutDownScanner
              :parameters (?mailBot - bot ?x - scanner ?y - cell)
              :precondition (and
                (On ?mailBot ?y)
                (HoldingObj ?mailbot ?x)
                  (> (battery-amount ?mailBot) 0)
                )
              :effect (and
                (not(HoldingObj ?mailBot ?x))
                (On ?x ?y)
                (not (Holding ?mailBot))
                )
                )


                  (:action PutDownPackageHeavy
                  :parameters (?mailBot - bot ?deliveryBot - bot ?x - package ?y - cell)
                  :precondition (and
                      (DifferentBot ?mailBot ?deliveryBot)

                    (On ?mailBot ?y)
                    (HoldingObj ?mailbot ?x)
                    (> (battery-amount ?mailBot) 0)

                    (On ?deliveryBot ?y)
                    (HoldingObj ?deliveryBot ?x)
                    (> (battery-amount ?deliveryBot) 0)
                    )
                  :effect (and
                    (not(HoldingObj ?mailBot ?x))
                    (On ?x ?y)
                    (not (HoldingHeavy ?mailBot))

                    (not(HoldingObj ?deliveryBot ?x))
                    (On ?x ?y)
                    (not (HoldingHeavy ?deliveryBot))


                    )
                    )

                    (:action PutDownPackageHeavyBelt
                    :parameters (?mailBot - bot ?deliveryBot - bot ?x - package ?y - cell ?z - cell)
                    :precondition (and
                        (DifferentBot ?mailBot ?deliveryBot)
                        (beltCell ?z)
                        (Connected ?y ?z)
                      (On ?mailBot ?y)
                      (HoldingObj ?mailbot ?x)
                      (> (battery-amount ?mailBot) 0)

                      (On ?deliveryBot ?y)
                      (HoldingObj ?deliveryBot ?x)
                      (> (battery-amount ?deliveryBot) 0)
                      )
                    :effect (and
                      (not(HoldingObj ?mailBot ?x))
                      (not (HoldingHeavy ?mailBot))

                      (not(HoldingObj ?deliveryBot ?x))
                      (On ?x ?z)
                      (not (HoldingHeavy ?deliveryBot))


                      )
                      )
  (:action Move
      :parameters (?mailBot - bot ?x - cell ?y - cell)
      :precondition (and
        (On ?mailBot ?x)
        (Connected ?x ?y)
        (not (Holding ?mailBot))
        (not (HoldingHeavy ?mailBot))
        (>= (battery-amount ?mailBot) 1)
          (not (beltCell ?y))
        )
      :effect (and
        (On ?mailBot ?y)
        (not (On ?mailBot ?x))
        (decrease (battery-amount ?mailBot) 1)
  )
)
  (:action MoveHolding
      :parameters (?mailBot - bot ?x - cell ?y - cell)
      :precondition (and
        (On ?mailBot ?x)
        (Connected ?x ?y)
        (Holding ?mailBot)
          (not (beltCell ?y))
        (not (HoldingHeavy ?mailBot))
        (>= (battery-amount ?mailBot) 2)
        )
      :effect (and
        (On ?mailBot ?y)
        (not (On ?mailBot ?x))
        (decrease (battery-amount ?mailBot) 2)
        )
  )

  (:action MoveHoldingHeavy
      :parameters (?mailBot - bot ?x - cell ?y - cell ?deliveryBot - bot)
      :precondition (and
        (DifferentBot ?mailBot ?deliveryBot)
          (not (beltCell ?y))
        (On ?mailBot ?x)
        (Connected ?x ?y)
        (HoldingHeavy ?mailBot)
        (>= (battery-amount ?mailBot) 2)

        (On ?deliveryBot ?x)
        (Connected ?x ?y)
        (HoldingHeavy ?deliveryBot)
        (>= (battery-amount ?deliveryBot) 2)

        )
      :effect (and
        (On ?mailBot ?y)
        (not (On ?mailBot ?x))
        (decrease (battery-amount ?mailBot) 2)

        (On ?deliveryBot ?y)
        (not (On ?deliveryBot ?x))
        (decrease (battery-amount ?deliveryBot) 2)
        )
  )

  (:action turnOff
  :parameters (?bot - bot ?cell - cell ?switch - switch ?belt - belt)
  :precondition (and
  (On ?bot ?cell)
  (On ?switch ?cell)
    (> (battery-amount ?bot) 0)
  )
  :effect (and
    (not (BeltOn ?belt))
    )
    )
    (:action PutDownPackage
    :parameters (?mailBot - bot ?x - package ?y - cell)
    :precondition (and
      (On ?mailBot ?y)
      (HoldingObj ?mailbot ?x)
        (> (battery-amount ?mailBot) 0)
        (not (HeavyPackage ?x))
      )
    :effect (and
      (not (HoldingObj ?mailBot ?x))
      (On ?x ?y)
      (not (Holding ?mailBot))
      )
      )
      (:action PickupPackage
        :parameters (?mailBot - bot ?x - package ?y - cell)
        :precondition (and
          (On ?mailBot ?y)
          (On ?x ?y)
          (not( Holding ?mailBot))
          (>= (battery-amount ?mailBot) 0)
          (not (HeavyPackage ?x))
          )
        :effect (and
        (HoldingObj ?mailBot ?x)
        (not (On ?x ?y))
        (Holding ?mailBot)
      )
        )
        (:action PutDownPackageBelt
        :parameters (?mailBot - bot  ?x - package ?y - cell ?z - cell)
        :precondition (and

            (beltCell ?z)
            (Connected ?y ?z)
          (On ?mailBot ?y)
          (HoldingObj ?mailbot ?x)
          (not (HoldingHeavy ?mailBot))
          (> (battery-amount ?mailBot) 0)


          )
        :effect (and
          (not(HoldingObj ?mailBot ?x))
          (not (Holding ?mailBot))
          (On ?x ?z)



          )
          )
        )
