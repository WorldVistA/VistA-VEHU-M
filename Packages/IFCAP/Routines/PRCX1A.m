PRCX1A ;WISC/PLT-PATCH POST-INI UTILITY ;1/20/98  13:27
V ;;5.0;IFCAP;**125,146**;4/21/95
 QUIT  ;invalid entry
 ;
EN ;Clean up the cross-reference ^prc(442,"AM",
 ; delete all cross-reference for cancelled, complete (amendment) purchase card order.
 ;this will speed up the reconciliation match.
 N PRCRI,X,Y,Z,A,B
 N PRCA,PRCB
 D EN^DDIOL("POST INITIAL STARTS") W !
 S PRCA=0 F  S PRCA=$O(^PRC(442,"AM",PRCA)) QUIT:'PRCA  D
 . S PRCRI(442)=0
 . F  S PRCRI(442)=$O(^PRC(442,"AM",PRCA,PRCRI(442))) QUIT:'PRCRI(442)  D
 .. S A=^PRC(442,PRCRI(442),7)
 .. I $P(A,"^") S A=$P(^PRCD(442.3,+A,0),"^",2) I A=45!(A=41)!(A=40) W "." K ^PRC(442,"AM",PRCA,PRCRI(442))
 .. QUIT
 . QUIT
 ;fill-in missing reconciled status in file 440.6
 W ! S PRCRI(440.6)=0
 F  S PRCRI(440.6)=$O(^PRCH(440.6,PRCRI(440.6))) QUIT:'PRCRI(440.6)  I $P(^(PRCRI(440.6),0),"^",16)="" D
 . S A=^PRCH(440.6,PRCRI(440.6),1),B=^(0)
 . I $P(A,"^") W "." D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"15////R")
 . QUIT
 D EN^DDIOL("POST INITIAL IS DONE!!!")
 QUIT
 ;
E146 ;PATCH PRC*5*146 POST INITIAL
 D EN^DDIOL("POST INITIAL STARTS")
 D EN^DDIOL("Index the new cross-reference in file 440.6")
 N DIK
 S DIK="^PRCH(440.6,",DIK(1)="5^D"
 D ENALL^DIK
 D EN^DDIOL("POST INITIAL IS DONE!!!")
 QUIT
