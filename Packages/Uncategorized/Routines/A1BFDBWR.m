A1BFDBWR ;ALBANY ISC ; ECF ; MAY 11 1993 8:53 am [ 06/04/93  2:34 PM ]
 ;;V1.0
EN ;;Check database for write disabled      
 ;
START ;
DBWRITE ;
 S A1BFDSON=1 ;Disable switch on until otherwise
 S A1BFVP=$V(44)+2,A1BFVP1=$V(A1BFVP+2,-3,2),A1BFVD1=$ZH(2000)
 I $ZB(A1BFVP1,A1BFVD1,1) S A1BFDSON=0 Q
 S A1BFDSON=0 ;The disable switch is off
 Q
DBREAD ;
 S A1BFDSON=1  ;Disable switch is on until otherwise
 S A1BFVP=$V(44)+2,A1BFVP1=$V(A1BFVP+2,-3,2),A1BFVD1=$ZH(4000)
 I $ZB(A1BFVP1,A1BFVD1,1) S A1BFDSON=0 Q
 S A1BFDSON=0  ;The disable switch is off
 Q
USERLOG ;
 S A1BFDSON=1  ;Disable switch is on until otherwise
 S A1BFVP=$V(44)+2,A1BFVP1=$V(A1BFVP+2,-3,2),A1BFVD1=$ZH(40)
 I $ZB(A1BFVP1,A1BFVD1,1) S A1BFDSON=0 Q
 S A1BFDSON=0 ;The disable switch is off
 Q
