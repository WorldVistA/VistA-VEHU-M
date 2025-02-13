 ;ATL/ACE PROGRAMMER-MAILING LIST SYSTEM VECSG19
 ;;1
 ;       VARIABLE LIST
 ;
 ;       NAME    =       INDIVIDUAL'S NAME
 ;       ADDR    =       ADDRESS
 ;       CITY    =       CITY
 ;       STATE   =       STATE
 ;       ZIP     =       ZIP CODE
 ;
START ;
 W @IOF
 W !!,?20,"CREATE MAILING LIST ENTRY"
NAME ;
 R !!,"ENTER NAME : ",NAME:DTIME I '$T!(NAME["^")!(NAME="") G EXIT
 I NAME'?1U.AP1","1U.AP!($L(NAME)>30)!(NAME["?") G EXIT
 I  W !,"ENTER THE NAME OF THE NEW ENTRY. "
 I  W "ENTER LAST NAME,FIRST NAME",! G NAME
 D CREATE,STORE G NAME
EXIT ;
 K NAME,ADDR,CITY,STATE,ZIP
 Q
CREATE ;
 S (ADDR,CITY,STATE,ZIP)=""
ADDR ;
 R !,"ADDRESS : ",ADDR:DTIME I '$T!(ADDR["^") G CREXIT
 I ADDR="" G CITY
 I ADDR'?.ANP!($L(ADDR)>25)!(ADDR["?")
 I  W !,"CITY MUST NOT EXCEED 20 CHARACTERS" G CITY
CITY ;
 R !,"CITY : ",CITY:DTIME I '$T!(CITY["^") G CREXIT
 I CITY="" G STATE
 I CITY'?.ANP!($L(CITY)>20)!(CITY["?")
 I  W !,"CITY MUST NOT EXCEED 20 CHARACTERS" G CITY
STATE ;
 R !,"STATE : ",STATE:DTIME I '$T!(STATE["^") G CREXIT
 I STATE="" G ZIP
 I STATE'?2U!(STATE["?") W !,"STATE MUST BE A 2 LETTER"
 I  W " ABBREVIATION",! G STATE
ZIP ;
 R !,"ZIP CODE : ",ZIP:DTIME I '$T!(ZIP["^") G EXIT
 I ZIP="" G CREXIT
 I ZIP'?5N&(ZIP'?9N)!(ZIP["?") W !,"ZIP CODE MUST BE FIVE"
 I  W " OR NINE DIGITS, NO HYPHEN" G ZIP
CREXIT ;
 Q
STORE ;
 S ^VECS5G(NAME)=ADDR_"^"_CITY_"^"_STATE_"^"_ZIP
 Q
  
