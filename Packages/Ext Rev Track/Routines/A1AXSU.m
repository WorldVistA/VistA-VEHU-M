A1AXSU ;SLL/ALB ISC; SURVEY REPORT;1/15/88
 ;;VERSION 1.0
 ;
EN1 ; by facility
 I DUZ(2)<1000 S FR=$P(^DIZ(11837,DUZ(2),0),",",1) S TO=FR_"Z"
 S FLDS="[A1AX PSU]",BY="2",DIC="^DIZ(11830,",L=0 D EN1^DIP
 G EXIT
EN2 ; by review organization
 S FLDS="[A1AX PSU]",BY="3",DIC="^DIZ(11830,",L=0 D EN1^DIP
 G EXIT
EN3 ; by review date
 S FLDS="[A1AX PSU]",BY=".01",DIC="^DIZ(11830,",L=0 D EN1^DIP
 G EXIT
EXIT ;
 K DIC,DIC(0),TO,FR,BY,FLDS,X
 K A1AXL,DIJ,DP,K,NE,NE1,P,PR,R,RS,RS1,Y,ZA,ZB,ZC
 Q
