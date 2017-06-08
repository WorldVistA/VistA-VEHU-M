ZMJC ;RELIGOUS OBJECT ;2-3-97 [ 02/04/97  5:09 PM ]
 ;TIU CLASS MINNEAPOLIS
 ;
RELIG(DFN)         ;pass - returns religion
 I '$D(VADM(9)) D DEM^TIULO(DFN,.VADM)
 Q $S($P(VADM(9),U,2)]"":$P(VADM(9),U,2),1:"Religion UNKNOWN")
 ;
   
