MJBAA1 ;MJB/ISC-A;ENTER CONTACT DATA INTO UI MULTIPLE  ; Compiled 07/30/97 01:48PM for M/WNT
 ;V1
 ; This routine will allow the user to stuff both IRM and Lab 
 ; contacts, and thier phone numbers into multiple instruments
 ; within the Universal Interface multiple. 
 ;
 ;Variables:
 ;MJBS - site: IEN of the Institution file
 ;MJBI - IRM contact (user input)
 ;MJBL - Lab Contact (user input)
 ;MJBIP - IRM Phone number (user input)
 ;MJBLP - Lab Phone number (user input)
 ;MJBAI - Auto instrument IEN
 ;MJBUI - Universal interface IEN
 ;
INIT ;
 W @IOF
 W !!,?15,"ENTRY OF CONTACTS AND PHONE NUMBERS"
 ;
WHO R !!!,"Who is the IRM contact ? ",MJBI:DTIME
 ;
WHERE S DIC="^DIC(4,",DIC(0)="AEMOQZ",DIC("A")="Where does this person work ? " D ^DIC K DIC G:X=""!(X[U)!(Y<0) WHERE S MJBS=+Y 
 ;
IPH R !,"What is the IRM contact's Phone number ? ",MJBIP:DTIME
 ;
LAB R !,"Who is the lab contact ? ",MJBL:DTIME
 ;
LRPH R !,"What is the Lab Contact's Phone number ? ",MJBLP:DTIME
 ;
LOOP1 ;
 ; TEST LOOP
 ;S MJBAI=0 F  S MJBAI=$O(^DIZ(500041,MJBAI)) W !,$P(^(MJBAI,0),"^",1) H 1 Q:'MJBAI
 S MJBAI=0 F  S MJBAI=$O(^DIZ(500041,MJBAI)) D  Q:'MJBAI
 .S MJBUI=0 F  S MJBUI=$O(^DIZ(500041,MJBAI,30,MJBUI)) D  Q:'MJBUI
 ..S MJBSS=0 F  S MJBSS=$O(^DIZ(500041,MJBAI,30,MJBUI,1,MJBSS))  Q:'MJBSS
 ..W !,?5,$P(^DIZ(500041,MJBAI,0),"^",1) H 1
 ..W !,?10,$P(^DIZ(500041,MJBAI,30,MJBUI,0),"^",1) H 1
 ..W !,?15,$P(^DIZ(500041,MJBAI,30,MJBUI,1,MJBSS,0),"^",1) H 1
 ;
 ;
 ;...I MJBSS=MJBS S 
 Q
