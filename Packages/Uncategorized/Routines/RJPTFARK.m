RJPTFARK ;RJ WILM DE -ARCHIVE (KILL OLD DATA AFTER ITS BEEN ARCHIVED); MAY 6 86
 ;;4.0
 K ^DGP(45.84,I),^DGP(45.84,"AC",I,I),^DGP(45.84,"B",I,I)
 S DA=$P(^DGPT(I,0),"^",1) K ^DGPT("AAD",DA,$P(^DGPT(I,0),"^",2),I),^DGPT("AFB",DA,I),^DGPT("B",DA,I),^DGPT("AF",$P(^DGPT(I,0),"^",2),I),^DGPT("AS",0,I)
 S K="" F M=0:0 S K=$O(^DGPT(I,"M","AM",K)) Q:K=""  K ^DGPT("ADS",K,I)
 K ^DGPT(I)
 I '$D(^DPT(DA,0)) W !,"Pointer Error.  No Patient in ^DPT to match PTF Record: ",I,"." Q
 I '$D(^DPT(DA,"DA",0)) W !,"Pointer Error.  No Admission in Patient File to match PTF Record: ",I,"." Q
 S E=$P(^(0),"^",3) F J=1:1:E I $D(^DPT(DA,"DA",J,0)) S:$P(^(0),"^",12)=I $P(^DPT(DA,"DA",J,0),"^",12)=""
 Q
