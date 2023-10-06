( define (domain mailBot-world)
  (:requirements :adl :fluents)

  (:types cell bot scanner package belt switch)

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
    (rechargeCell ?x -cell)
    )

    (:functions
      (battery-amount ?mailbot - bot)
      (battery-capacity)
      )



  (:action Move
      :parameters (?mailBot - bot ?x - cell ?y - cell)
      :precondition (and
        (On ?mailBot ?x)
        (Connected ?x ?y)
        (not (Holding ?mailBot))
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
        (>= (battery-amount ?mailBot) 2)
          (not (beltCell ?y))
        )
      :effect (and
        (On ?mailBot ?y)
        (not (On ?mailBot ?x))
        (decrease (battery-amount ?mailBot) 2)
        )
  )

  (:action Recharge
    :parameters(?mailBot - bot ?x - cell)
    :precondition(and
      (On ?mailBot ?x)
      (rechargeCell ?x)
      )
  :effect (assign (battery-amount ?mailbot) 15))




  (:action PickupPackage
    :parameters (?mailBot - bot ?x - package ?y - cell)
    :precondition (and
      (On ?mailBot ?y)
      (On ?x ?y)
      (not( Holding ?mailBot))
        (> (battery-amount ?mailBot) 0)
      )
    :effect (and
    (HoldingObj ?mailBot ?x)
    (not (On ?x ?y))
    (Holding ?mailBot)
  )
    )
    (:action PickupScanner
      :parameters (?mailBot - bot ?x - scanner ?y - cell)
      :precondition (and
        (On ?mailBot ?y)
        (On ?x ?y)
        (not (Holding ?mailBot))
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


(:action turnOn
:parameters (?bot - bot ?cell - cell ?switch - switch ?belt - belt)
:precondition (and
(On ?bot ?cell)
(On ?switch ?cell)
  (> (battery-amount ?bot) 0)
)
:effect (BeltOn ?belt))

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
  )
:effect (and
  (not(HoldingObj ?mailBot ?x))
  (On ?x ?y)
  (not (Holding ?mailBot))
  )
  )

  (:action PutDownPackageBelt
  :parameters (?mailBot - bot ?x - package ?y - cell ?z - cell)
  :precondition (and
    (On ?mailBot ?y)
    (HoldingObj ?mailbot ?x)
    (beltCell ?z)
    (Connected ?y ?z)
    )
  :effect (and
    (not(HoldingObj ?mailBot ?x))
    (On ?x ?z)
    (not (Holding ?mailBot))
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
  (:action Deliver
    :parameters(?package - package ?cell - cell ?belt - belt ?mailBot - bot)
    :precondition(and
      (BeltOn ?belt)
      (On ?package ?cell)
      (beltCell ?cell)
      (scanned ?package)
        (> (battery-amount ?mailBot) 0) )
    :effect (and
        (Delivered ?package)
        ))
        )
