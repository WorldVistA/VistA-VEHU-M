MJBAA1 ;MJB/ISC-A;ENTER CONTACT DATA INTO UI MULTIPLE  ; Compiled 08/12/97 01:42PM for M/WNT
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
 ;MJBSS - Site already entered in ^DIZ(500041,
 ;
AGAIN W !!,?5,"Do you want to enter another set of contacts ?"  S %=1 D YN^DICN I %'=2 D INIT
 ;
 Q
INIT ;Entry Point here
 W @IOF  S U="^"
NEW K X,Y,MJBS,MJBI,MJBL,MJBIP,MJBLP,MJBAI,MJBUI,MJBSS,MJBS1,%
 ;
 W !!,?15,"ENTRY OF CONTACTS AND PHONE NUMBERS"
 ;
WHO R !!!,"Who is the IRM contact ? ",MJBI:DTIME  I '$T!(MJBI["^") G AGAIN
 ;
WHERE S DIC="^DIC(4,",DIC(0)="AEMOQZ",DIC("A")="Where does this person work ? " D ^DIC K DIC G:(X="^")!Y<0 WHERE S MJBS=+Y 
 ;
IPH R !,"What is the IRM contact's Phone number ? ",MJBIP:DTIME  I '$T!(MJBIP["^") G AGAIN
 ;
LAB R !,"Who is the lab contact ? ",MJBL:DTIME  I '$T!(MJBL["^") G AGAIN
 ;
LRPH R !,"What is the Lab Contact's Phone number ? ",MJBLP:DTIME  I '$T!(MJBLP["^") G AGAIN
 ;
 W !!!,"BEGIN SCANNING CAPTAIN ..................."
 ;
LOOP ;get instrument
 ;S MJBAI=0 F  S MJBAI=$O(^DIZ(500041,MJBAI)) Q:MJBAI<1  W "."  D LOOP2
 S MJBAI=0 F  S MJBAI=$O(^DIZ(500041,MJBAI)) Q:MJBAI<1  S MJBANM=$P($G(^(MJBAI,0)),"^",1)  W "."  D LOOP2
 G AGAIN
 ;
 ;having the instrument, get the GIM
LOOP2 ;
 S MJBUI=0 F  S MJBUI=$O(^DIZ(500041,MJBAI,30,MJBUI)) Q:MJBUI<1  W "."  D LOOP3
 ;S MJBUI=0 F  S MJBUI=$O(^DIZ(500041,MJBAI,30,MJBUI)) Q:MJBUI<1  W !,"   U/I type: "_$P($G(^(MJBUI,0)),"^",1)  D LOOP3
 Q
 ;
 ;having the instrument, get the gim
 ;
LOOP3 S MJBSS=0 F  S MJBSS=$O(^DIZ(500041,MJBAI,30,MJBUI,1,MJBSS))  Q:MJBSS<1  S MJBS1=$P($G(^DIZ(500041,MJBAI,30,MJBUI,1,MJBSS,0)),"^",1) D ADD:MJBS1=MJBS 
 Q
 ;
ADD W *7,!!,"We have VAMC "_MJBS1_" Matching with "_MJBS_" for: "_MJBANM
 W !,"We want to stuff for IRM "_MJBI_" ph: "_MJBIP
 W !,"And for LAB "_MJBL_" Lab # : "_MJBLP
 W !,"Is this OK" S %=1 D YN^DICN I %'=2 D
 . W !!,"Let me set it up then..........."
 . S $P(^DIZ(500041,MJBAI,30,MJBUI,1,MJBSS,0),"^",2)=MJBI
 . S $P(^DIZ(500041,MJBAI,30,MJBUI,1,MJBSS,0),"^",3)=MJBIP
 . S $P(^DIZ(500041,MJBAI,30,MJBUI,1,MJBSS,0),"^",4)=MJBL
 . S $P(^DIZ(500041,MJBAI,30,MJBUI,1,MJBSS,0),"^",5)=MJBLP
 . W !,"ADDED ",!
 . Q
RTN ;
 ;
