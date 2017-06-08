MJBAA2 ;ISC-A;MJB; This routine will inquire as to instruments by site.  ; Compiled 08/15/97 08:15PM for M/WNT
 ;v1
 ;
INIT W @IOF,!,"Inquiry by Site for Universal interfaces",!!
 ;PROMPT FOR THE SITE AND GET IT.
 ;MJBS=THE SITE'S NAME
 ;MJBSI=THE SITE'S IEN
 S DIC="^DIC(4,",DIC(0)="AEMOZ",DIC("A")="Enter the site you wish to inquire to: " D ^DIC K DIC  S MJBS=Y(0,0),MJBSI=$P((Y),"^",1)  I Y<1 G INIT
 ;
 ;Start drilling down the instruments checking against the site
 ;store the satisfied infor in an array. 
 ;
INST S I=0  F I=1:1 S MJB(MJBSI,I)="",MJBAI=0 F  S MJBAI=$O(^DIZ(500041,MJBAI)) Q:MJBAI<1  S MJBANM=$P($G(^(MJBAI,0)),"^",1)  D LP1
 ;
LP1 S MJBUI=0 F  S MJBUI=$O(^DIZ(500041,MJBAI,30,MJBUI)) Q:MJBUI=""  D LP2
 ;
LP2 S MJBSS=0 F  S MJBSS=$O(^DIZ(500041,MJBAI,30,MJBUI,1,MJBSS))  Q:MJBSS<1  S MJBS1=$P($G(^DIZ(500041,MJBAI,30,MJBUI,1,MJBSS,0)),"^",1) I MJBS1=MJBSI  S MJB(MJBSI,I)=MJBS_"^"_MJBUI_"^"_MJBANM
 ;
