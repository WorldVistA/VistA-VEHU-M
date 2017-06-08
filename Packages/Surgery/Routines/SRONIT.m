SRONIT ; ; 09-FEB-1993
 ;;3.0; Surgery ;;24 Jun 93
 ;
 K DIF,DIK,DDF,DDT,DTO,D0,DLAYGO,DIC,DIR,DA,ORVROM,DFR,DTN,DIX,DZ
 S DIFQ=0,ORVROM=22 W !!,"This version of 'SRONIT' was created on 09-FEB-1993"
 W !?9,"(at Birmingham ISC, by OE/RR V.2.5)",!
 G Q:DIFQ D ^SRONIT1 G Q:'$D(DIFQ) S DIK(0)="B"
 D ^SRONIT2,^SRONIT3
 L  W !,*7,"OK, Protocol Installation is Complete.",!
 K %ZW,%,%H,D0,DA,DIF,DIFQ,DIG,DIH,DIK,DIU,DIV,DSEC,I,J,KEY,DIY,N,NM,NO,ORVROM,R,X,X0
 Q
 ;
Q W *7,!!,"NO UPDATING HAS OCCURRED!" Q
 ;
IXF ;;SR
