(define (problem pddl-problem1)
       (:domain mailBot-World)
       (:objects
         c51 - cell
         c52 - cell
         c53 - cell
         c54 - cell
         c55 - cell
         c41 - cell
         c42 - cell
         c43 - cell
         c44 - cell
         c45 - cell
         c31 - cell
         c32 - cell
         c33 - cell
         c34 - cell
         c35 - cell
         c21 - cell
         c22 - cell
         c23 - cell
         c24 - cell
         c25 - cell
         c11 - cell
         c12 - cell
         c13 - cell
         c14 - cell
         c15 - cell
         scanner - scanner
         p001 - package
         p010 - package
         p011 - package

         p002 - package
         p020 - package
         p022 - package

         p003 - package
         p030 - package
         p033 - package

         p004 - package
         p040 - package
         p044 - package

         belt - belt
         switch - switch
         mailBotbot - bot

         )
         (:init
           (Connected c11 c12)
           (Connected c11 c21)

           (Connected c12 c12)
           (Connected c21 c11)

           (Connected c12 c13)
           (Connected c12 c22)

           (Connected c13 c12)
           (Connected c22 c12)

           (Connected c13 c23)
           (Connected c13 c14)

           (Connected c23 c13)
           (Connected c14 c13)

           (Connected c14 c15)
           (Connected c24 c14)

           (Connected c15 c14)
           (Connected c14 c24)

           (Connected c15 c25)
           (Connected c25 c15)


           (Connected c25 c24)
           (Connected c25 c35)

           (Connected c24 c25)
           (Connected c35 c25)

           (Connected c24 c34)
           (Connected c23 c24)

           (Connected c34 c24)
           (Connected c24 c23)

           (Connected c23 c33)
           (Connected c23 c22)

           (Connected c33 c23)
           (Connected c22 c23)

           (Connected c22 c32)
           (Connected c21 c22)

           (Connected c32 c22)
           (Connected c22 c21)

           (Connected c21 c31)

           (Connected c31 c21)

           (Connected c31 c32)
           (Connected c32 c33)

           (Connected c32 c31)
           (Connected c33 c32)

           (Connected c33 c43)
           (Connected c33 c34)

           (Connected c43 c33)
           (Connected c34 c33)

           (Connected c34 c35)
          ; (Connected c34 c44)

           (Connected c35 c34)
          ; (Connected c44 c34)

        ;   (Connected c35 c45)

           ;(Connected c45 c35)

           (Connected c45 c55)
           (Connected c45 c44)

           (Connected c55 c45)
           (Connected c44 c45)


           (Connected c44 c54)
           (Connected c44 c43)

           (Connected c54 c44)
           (Connected c43 c44)

           (Connected c43 c53)
           (Connected c43 c42)

           (Connected c53 c43)
           (Connected c42 c43)

           (Connected c42 c52)
           (Connected c42 c41)

           (Connected c42 c42)
           (Connected c41 c42)

           (Connected c41 c51)

           (Connected c51 c41)

           (Connected c51 c52)

           (Connected c52 c51)


           (Connected c53 c54)

           (Connected c54 c53)

           (Connected c54 c55)

           (Connected c55 c54)

           (On p001 c11)
           (On p010 c13)
           (On p011 c15)

           (On p002 c22)
           (On p020 c23)
           (On p022 c12)

           (On p003 c33)
           (On p030 c33)
           (On p033 c13)

           (On p004 c44)
           (On p040  c43)
           (On p044 c43)

           (On mailBotbot c33)
           (On scanner c51)
           (On switch c35)
           ;(beltCell c44)
           (beltCell c45)
           )
           (:goal (and
             (Delivered p001)
             (Delivered p011)
             (Delivered p010)

             (Delivered p002)
             (Delivered p020)
          ;   (Delivered p022)

             ;(Delivered p003)
             ;(Delivered p030)
             ;(Delivered p033)

             ;(Delivered p003)
             ;(Delivered p040)
            ; (Delivered p044)

             (On scanner c51)
             (On mailBotbot c33)
             ))

      )
