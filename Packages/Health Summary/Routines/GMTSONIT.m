GMTSONIT ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 ;
 K DIF,DIK,DDF,DDT,DTO,D0,DLAYGO,DIC,DIR,DA,ORVROM,DFR,DTN,DIX,DZ
 S DIFQ=0,ORVROM=22 W !!,"This version of 'GMTSONIT' was created on 19-OCT-1995"
 W !?9,"(at ISCSLC, by OE/RR V.2.5)",!
 G Q:DIFQ D ^GMTSONI1 G Q:'$D(DIFQ) S DIK(0)="B"
 D ^GMTSONI2,^GMTSONI3
 L  W !,*7,"OK, Protocol Installation is Complete.",!
 K %ZW,%,%H,D0,DA,DIF,DIFQ,DIG,DIH,DIK,DIU,DIV,DSEC,I,J,KEY,DIY,N,NM,NO,ORVROM,R,X,X0
 Q
 ;
Q W *7,!!,"NO UPDATING HAS OCCURRED!" Q
 ;
IXF ;;GMTS
