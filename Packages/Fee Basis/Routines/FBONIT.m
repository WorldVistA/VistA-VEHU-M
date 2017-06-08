FBONIT ; ; 30-JAN-1995
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 K DIF,DIK,DDF,DDT,DTO,D0,DLAYGO,DIC,DIR,DA,ORVROM,DFR,DTN,DIX,DZ
 S DIFQ=0,ORVROM=22 W !!,"This version of 'FBONIT' was created on 30-JAN-1995"
 W !?9,"(at ALBANY ISC VAX DEVELOPMENT, by OE/RR V.2.5)",!
 G Q:DIFQ D ^FBONIT1 G Q:'$D(DIFQ) S DIK(0)="B"
 D ^FBONIT2,^FBONIT3
 L  W !,*7,"OK, Protocol Installation is Complete.",!
 K %ZW,%,%H,D0,DA,DIF,DIFQ,DIG,DIH,DIK,DIU,DIV,DSEC,I,J,KEY,DIY,N,NM,NO,ORVROM,R,X,X0
 Q
 ;
Q W *7,!!,"NO UPDATING HAS OCCURRED!" Q
 ;
IXF ;;FB
