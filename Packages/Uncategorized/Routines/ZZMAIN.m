ZZMAIN ;
 S X=1,Y=6,Z=8
 D SUB1 W !,"SUM = ",SUM
 Q
SUB1 ;
 F I=1:1:5 S SUM=(X+I)+Y+(Z*I)
 Q        
