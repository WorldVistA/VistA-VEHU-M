MJBDPT2 ; ISC-A;MJB;CHECKS LR NODE IN DPT  ; Compiled 1999-05-26 03:12PM for M/WNT
 ;
 ; this routine is designed to make a fast run down ^DPT
 ; and check the LR node for a second piece.
 ; it was written in response to CIRN
INIT ;
 S MJB=0
 F  S MJB=$O(^DPT(MJB,"LR")) S LAB=MJB  D
 . I $D(LAB)&LAB["^" W !,$P(^DPT(MJB,0),"^",1)_"  "_LAB
 Q
