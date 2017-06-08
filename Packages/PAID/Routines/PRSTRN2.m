PRSTRN2 ; HISC/REL,WAA - Transmission History ;11/2/89  14:33
 ;;3.5;PAID;;Jan 26, 1995
 S PP=$P(^PRST(455,0),"^",3) I PP<1 W !!,"No Data for Current Pay Period!",! G EX
 S X0=$G(^PRST(455,PP,"S"))
 ;
 W @IOF,!!?12,"Transmission History for Pay Period ",$E(PP,4,5),!
 W !!,"Number of Valid Records Input: ",?50,$P(X0,"^",1)
 W !,"Number of Rejected Records: ",?50,$P(X0,"^",2)
 W !,"Input Employee: ",?50 S Y=$P(X0,"^",3) D UR
 W !,"Input Date/Time: ",?50 S Y=$P(X0,"^",4) D DT
 W !!,"Number of Employees Last Transmitted: ",?50,$P(X0,"^",5)
 W !,"Number of Records Last Transmitted: ",?50,$P(X0,"^",6)
 S X=$G(^PRST(455,PP,0))
 W !,"Output Clerk: ",?50 S Y=$P(X,"^",4) D UR
 W !,"Output Date/Time: ",?50 S Y=$P(X,"^",5) D DT
 W !!,"Total Number of Employees Transmitted: ",?50,$P(X0,"^",7)
 W !,"Total Number of Records Transmitted: ",?50,$P(X0,"^",8)
 D MSG
 W !!,"Total Number of Messages for Transmission: ",?50,NT("T")
 W !,"Number of Messages Acknowledged by Austin: ",?50,NA("T")
 R !!,"Press RETURN to Continue: ",X:DTIME W ! G EX
MSG S (NT("T"),NA("T"))="0"
 S MSG="" F MSG=0:0 S MSG=$O(^PRST(455,PP,"X",MSG)) Q:MSG<1  S TYP=$P(^PRST(455,PP,"X",MSG,0),"^",2) S:TYP'="" NT("T")=NT("T")+1 D MSG2
 Q
MSG2 S X=+$O(^XMB(3.9,MSG,1,"C","XXX@Q-TAB.VA.GOV",0)) I X<1!('$D(^XMB(3.9,MSG,1,X,0))) W !,"ERROR!!! MESSAGE# ",MSG,*7 Q
 S:$P(^XMB(3.9,MSG,1,X,0),"^",4)'="" NA("T")=NA("T")+1
 Q
DT ;Date converter
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 Q
UR ;Check for valid person
 S X=$G(^VA(200,+Y,0)) W:X'="" $P(X,"^",1) Q
EX K %,%H,D,DISYS,I,Y,Z,DFN,MSG,NA,NT,PP,RR,TYP,X,X0,Y Q
