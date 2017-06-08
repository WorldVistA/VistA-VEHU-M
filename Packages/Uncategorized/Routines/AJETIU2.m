AJETIU2 ;HINES/LCR - EMBEDDED OBJECTS ;1-7-98 08:22
 ;V1.0
RELIG(DFN) ;PATIENT RELIGION
 I '$D(VADM(9)) D DEM^TIULO(DFN,.VADM)
 Q $S($P(VADM(9),U,2)]"":$P(VADM(9),U,2),1:"Religious Preference UNKNOWN")
MARITAL(DFN) ;MARITAL STATUS
 I '$D(VADM(10)) D DEM^TIULO(DFN,.VADM)
 Q $S($P(VADM(10),U,2)]"":$P(VADM(10),U,2),1:"Marital Status UNKNOWN")
NOK(DFN,IND) ;
 N LINE,N,V,CC,NR,P,MRK S LINE=1,NA=$G(^DPT(DFN,.21)),NOK=$P(NA,U)
 S MRK=0 I NOK="" S NOK="Not Entered",MRK=1
 S N(1)=$P(NA,U,3),N(2)=$P(NA,U,4),N(3)=$P(NA,U,5),N("CIT")=$P(NA,U,6)
 S N("ST")=$P(NA,U,7),N("ZIP")=$P(NA,U,8),N("PH")=$P(NA,U,9)
 S:N("ST")'="" N("ST")=$P($G(^DIC(5,N("ST"),0)),U,2)
 S N("CSZ")=$S(N("CIT")'="":N("CIT")_", ",1:"")_N("ST")_"  "_N("ZIP")
 S N("PHW")=$P(NA,U,11),N("REL")=$P(NA,U,2),P(1)="",P(2)=""
 I N("ST")>0 S ST0=$G(^DIC(5,N("ST"),0)),P(1)=$P(N(STO),U),P(2)=$P(N(ST0),U,2)
 S N("ST")=$S(P(2)'="":P(2),1:P(1))
 I MRK'=1 F V="ST","CIT","ZIP","PH","PHW","REL","CSZ" I N(V)="" S N(V)="UNK"
 F CC=1:1:3 S NR(CC)="" I N(CC)'="" S NR(LINE)=N(CC),LINE=LINE+1
 Q $S(IND="NOK":NOK,IND>0:NR(IND),IND'="":N(IND),1:"")
NOK2(DFN,IND) ;
 N LINE,N,V,CC,NR,P,MRK S LINE=1,NA=$G(^DPT(DFN,.211)),NOK=$P(NA,U),NR(4)=""
 S MRK=0 I NOK="" S NOK="Not Listed",MRK=1
 S N(1)=$P(NA,U,3),N(2)=$P(NA,U,4),N(3)=$P(NA,U,5),N("CIT")=$P(NA,U,6)
 S N("PHW")=$P(NA,U,11),N("REL")=$P(NA,U,2),P(1)="",P(2)=""
 S N("ST")=$P(NA,U,7),N("ZIP")=$P(NA,U,8),N("PH")=$P(NA,U,9)
 S N("CSZ")=$S(N("CIT")'="":N("CIT")_", ",1:"")_N("ST")_"  "_N("ZIP")
 I MRK'=1 F V="ST","CIT","ZIP","PH","PHW","REL","CSZ" I N(V)="" S N(V)="UNK"
 F CC=1:1:3,"CSZ" S NR(CC)="" I N(CC)'="" S NR(LINE)=N(CC),LINE=LINE+1
 Q $S(IND="NOK":NOK,IND>0:NR(IND),IND'="":N(IND),1:"")
