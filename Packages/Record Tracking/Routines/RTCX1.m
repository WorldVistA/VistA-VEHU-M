RTCX1 ; GENERATED FROM 'RT PENDING REQUESTS' PRINT TEMPLATE (#569) ; 05/20/93 ; (continued)
 G BEGIN
D I Y=DITTO(C) S Y="" Q
 S DITTO(C)=Y
 Q
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 Q
DT I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1
 Q
HEAD ;
 W !,?41,"CURRENT",?112,"DATE/TIME RECORD"
 W !,?0,"NAME",?22,"TYPE",?35,"REC#",?41,"LOCATION",?59,"Phone/Room",?84,"REQ#",?95,"REQUESTOR",?112,"NEEDED"
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
