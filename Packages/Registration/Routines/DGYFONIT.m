DGYFONIT ;;OCT 27,1992
 ;;5.2;REGISTRATION;**13**;JUL 29,1992
 ;
 K DIF,DIK,DDF,DDT,DTO,D0,DLAYGO,DIC,DIDUZ,DIR,DA,ORVROM,DFR,DTN,DIX,DZ
 S DIFQ=0,ORVROM=0 W !!,"This version of 'DGYFONIT' was created on OCT 27,1992"
 W !?9,"(at ISC-ALBANY DEMO MAS V5, by OE/RR V.2.14)",!
 G Q:DIFQ D ^DGYFONI1 G Q:'$D(DIFQ) S DIK(0)="B"
 D ^DGYFONI2,^DGYFONI3
 L  S DUZ=DIDUZ W !,*7,"OK, I'M DONE.",!
 K %ZW,%,%H,D0,DA,DIDUZ,DIF,DIFQ,DIG,DIH,DIK,DIU,DIV,DSEC,I,J,KEY,DIY,N,NM,NO,ORVROM,R,X,X0
 Q
 ;
Q W *7,!!,"NO UPDATING HAS OCCURRED!" Q
 ;
IXF ;;DGYF
