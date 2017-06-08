ZZCLINCK; LV/WPB - Clean up utilty for hospital location file
 ;
EN S XX=0 F  S XX=$O(^SC(XX)) Q:XX'>0  D
 .Q:$P(^SC(XX,0),"^",3)'="C"
 .I $D(^SC(XX,"SL")) W !,XX,"  ",$G(^SC(XX,"SL"))
 K XX Q
CLN; Clean up st nodes for clinic id 23
 S CLINICID=23
 S XX=0 F  S XX=$O(^SC(CLINICID,"ST",XX)) Q:XX'>0  D
 .I $G(^SC(CLINICID,"ST",XX,1))["z" D
 ..S ^SC(CLINICID,"ST",XX,1)=$TR(^SC(CLINICID,"ST",XX,1),"z",1) W !,$G(^SC(CLINICID,"ST",XX,1))
 .I $G(^SC(CLINICID,"ST",XX,1))["y" D
 ..S ^SC(CLINICID,"ST",XX,1)=$TR(^SC(CLINICID,"ST",XX,1),"y",0) W !,$G(^SC(CLINICID,"ST",XX,1))
 K XX
 S XX=0 F  S XX=$O(^SC(CLINICID,"T",XX)) Q:XX'>0  S YY=0 F  S YY=$O(^SC(CLINICID,"T",XX,2,YY)) Q:YY'>0  D
 .I $P(^SC(CLINICID,"T",XX,2,YY,0),"^",2)>2 W !,$G(^SC(CLINICID,"T",XX,2,YY,0))
 .I $P(^SC(CLINICID,"T",XX,2,YY,0),"^",2)>2 S $P(^SC(CLINICID,"T",XX,2,YY,0),"^",2)=1
 K XX
 S XX=0 F  S XX=$O(^SC(CLINICID,"T0",XX)) Q:XX'>0  I $G(^SC(CLINICID,"T0",XX,1))["z" S ^SC(CLINICID,"T0",XX,1)=$TR(^SC(CLINICID,"T0",XX,1),"z",1)
 S XX=0 F  S XX=$O(^SC(CLINICID,"T1",XX)) Q:XX'>0  I $G(^SC(CLINICID,"T1",XX,1))["z" S ^SC(CLINICID,"T1",XX,1)=$TR(^SC(CLINICID,"T1",XX,1),"z",1)
 S XX=0 F  S XX=$O(^SC(CLINICID,"T2",XX)) Q:XX'>0  I $G(^SC(CLINICID,"T2",XX,1))["z" S ^SC(CLINICID,"T2",XX,1)=$TR(^SC(CLINICID,"T2",XX,1),"z",1)
 S XX=0 F  S XX=$O(^SC(CLINICID,"T3",XX)) Q:XX'>0  I $G(^SC(CLINICID,"T3",XX,1))["z" S ^SC(CLINICID,"T3",XX,1)=$TR(^SC(CLINICID,"T3",XX,1),"z",1)
 S XX=0 F  S XX=$O(^SC(CLINICID,"T4",XX)) Q:XX'>0  I $G(^SC(CLINICID,"T4",XX,1))["z" S ^SC(CLINICID,"T4",XX,1)=$TR(^SC(CLINICID,"T4",XX,1),"z",1)
 S XX=0 F  S XX=$O(^SC(CLINICID,"T5",XX)) Q:XX'>0  I $G(^SC(CLINICID,"T5",XX,1))["z" S ^SC(CLINICID,"T5",XX,1)=$TR(^SC(CLINICID,"T5",XX,1),"z",1)     
 Q
KEYS;
 ;Get security keys and description.
 S XX=0 F  S XX=$O(^DIC(19.1,XX)) Q:XX'>0  D
 .W !!,"KEY NAME: ",$P(^DIC(19.1,XX,0),"^",1),"   DESCRIPTIVE NAME: ",$P(^DIC(19.1,XX,0),"^",2),!,"DESCRIPTION: "
 .S YY=0 F  S YY=$O(^DIC(19.1,XX,1,YY)) Q:YY'>0  D  
 ..W !,$G(^DIC(19.1,XX,1,YY,0))
 K XX
CLNUSERS; get a list of privileged users for each clinic
 W !,"================================"
 S XX=0 F  S XX=$O(^SC(XX)) Q:XX'>0  D
 .Q:$P(^SC(XX,0),"^",3)'="C"
 .Q:$G(^SC(XX,"SDPROT"))'="Y"
 .S CLINIC=$P(^SC(XX,0),"^") ;W !!,XX,"   ",$G(CLINIC)
 .I $P($G(^SC(XX,"SDPRIV",0)),"^",3)>0 W !!,XX,"   ",$G(CLINIC) S YY=0 F  S YY=$O(^SC(XX,"SDPRIV",YY)) Q:YY'>0  D
 ..Q:$G(^SC(XX,"SDPROT"))'="Y"
 ..K PTR
 ..S PTR=$P(^SC(XX,"SDPRIV",YY,0),"^"),USER=$P(^VA(200,PTR,0),"^")
 ..W !,$G(PTR),"    ",$G(USER),"  ",$G(^SC(XX,"SDPROT"))
 .K CLINIC,YY
 K XX
 Q
