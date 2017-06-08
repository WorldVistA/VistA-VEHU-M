AKENWSLB ;KCMO/EDN copied from AKFRWLAB                 ;4/7/98 
 ;;00.01
 ;
LABR(TARGET,DFN) ;-- Get most recent lab results
 ;
 N D,N,I
 N AKFRD,AKFRD1,AKFRD2,AKFRT,AKFRT1,LRDFN,AKFRSDT,AKFRCNT,AKFREDT,AKFRQ,AKFRZ
 K @TARGET
 S I=1,AKFRQ=0,AKFRCNT=0,AKFREDT=""
 S @TARGET@(I,0)="No Laboratory Results Available"
 ;++++++++++++++++++++++++++++++++++ 07202K EDN +++++++++++++++
 ;I '$D(^DPT(DFN,"LR")) Q
 I '$D(^DPT(DFN,"LR")) Q "~@"_$NA(@TARGET)
 ;---------------------------------------------------------------
 S LRDFN=^DPT(DFN,"LR")
 S AKFRD=0 F  S AKFRD=$O(^LR(LRDFN,"CH",AKFRD)) Q:(AKFRD<1)!(AKFRQ=1)  D
 .Q:$P(^LR(LRDFN,"CH",AKFRD,0),"^",3)=""
 .S AKFREDT=$P(AKFRD,".",1)_".9999",AKFRQ=1
 ;++++++++++++++++++++++++++++++++++ 07202K EDN +++++++++++++++
 ;Q:AKFREDT=""
 Q:AKFREDT="" "~@"_$NA(@TARGET)
 ;---------------------------------------------------
 S AKFRD=0 F  S AKFRD=$O(^LR(LRDFN,"CH",AKFRD)) Q:(AKFRD>AKFREDT)!(AKFRD<1)  D
 .Q:$P(^LR(LRDFN,"CH",AKFRD,0),"^",3)=""
 .S AKFRSDT=$P(^LR(LRDFN,"CH",AKFRD,0),"^",1),AKFRSDT=$P(AKFRSDT,".",1)
 .;I (AKFRCNT>0)&(AKFRSDT'=AKFREDT) S AKFRQ=1 Q
 .S N=0 F  S N=$O(^LR(LRDFN,"CH",AKFRD,N))  Q:N<1  D
 ..S AKFRT="CH;"_N_";1" Q:'$D(^LAB(60,"C",AKFRT))
 ..S AKFRT1="",AKFRT1=$O(^LAB(60,"C",AKFRT,AKFRT1)),AKFRT=$P(^LAB(60,AKFRT1,0),"^",1)
 ..S $P(AKFRT," ",20)="",AKFRT=$E(AKFRT,1,18)
 ..S AKFRD2=$P(^LR(LRDFN,"CH",AKFRD,0),"^",1),AKFRD2=$E(AKFRD2,4,5)_"/"_$E(AKFRD2,6,7)_"/"_$E(AKFRD2,2,3)_$J(+$E(AKFRD2_"00",9,10)_":"_$E(AKFRD2_"0000",11,12),6)
 ..S @TARGET@(I,0)=AKFRD2_"    "_AKFRT_"   "_$P(^LR(LRDFN,"CH",AKFRD,N),"^",1)_$P(^(N),"^",2) S I=I+1,AKFRCNT=AKFRCNT+1
 .;S AKFREDT=AKFRSDT
 D LR^AKFRWLA1(.AKFRZ,DFN)
 I $E(AKFRZ,6,23)'="None^None^None^^^^" D
 .I $P(AKFRZ,"^",2)'="None" S @TARGET@(I,0)=$P(AKFRZ,"^",6)_"          Microbiology results available",I=I+1
 .I $P(AKFRZ,"^",3)'="None" S @TARGET@(I,0)=$P(AKFRZ,"^",7)_"          Cytology results available",I=I+1
 .I $P(AKFRZ,"^",4)'="None" S @TARGET@(I,0)=$P(AKFRZ,"^",8)_"          Surgical Path results available",I=I+1
 ;K AKFRD,AKFRD1,AKFRD2,AKFRT,AKFRT1,LRDFN,DFN,AKFRSDT,AKFRCNT,AKFREDT,AKFRQ,AKFRZ
 Q "~@"_$NA(@TARGET)
 ;
LABIR(AKFRY,DFN) ;-- Interim report for previous day and today
 K AKFRY N Y
 ;*************************************************
 S DUZ("AG")="V"
 ;*************************************************
 ;++++++++++++++++++++ edn 040798
 N X,Y,%DT,I
 S %DT="P"
 S X="T"
 D ^%DT
 S SDT=Y ;          TODAY
 S X="T-1"
 D ^%DT
 S EDT=Y ;          YESTERDAY
 ;S SDT=2_$P(SDT,"/",3)_$P(SDT,"/",1)_$P(SDT,"/",2)
 ;S EDT=2_$P(EDT,"/",3)_$P(EDT,"/",1)_$P(EDT,"/",2)
 ;--------------------------------
 S LRDFN=^DPT(DFN,"LR")
 S LRSDT=SDT+.5,LREDT=EDT
 S LRIDT=9999999-LRSDT,LREDT=9999999-LREDT
 S LRLAB=1
 D INIT^LRRP2
 S IOP="WORKSTATION",%ZIS=0 D ^%ZIS Q:POP
 D PT^LRX
 U IO D SDQ^LRRP2
 D ^%ZISC K SDT,EDT,LRPARAM,LRORN,LRLABKY,LRPLASMA,LRSERUM,LRBLOOD,LRVIDO,LRVIDOF,LRDT0,LRURINE,LRUNKNOW,LRIDT,LRLAB,LRSDT
 D KILL^LRRK
 I $D(^TMP("AKFRW-REPORT",$J)) D
 .   S INDEX=0
 .   S BLANK=0
 .   ;    SCRAPE OFF BLANK LINES EXCEPT FOR FIRST ONE
 .   F  S INDEX=$O(^TMP("AKFRW-REPORT",$J,INDEX)) Q:+INDEX=0  D
 .   .   I $L(^TMP("AKFRW-REPORT",$J,INDEX))>0 S BLANK=0
 .   .   E  D
 .   .   .   I BLANK=1 K ^TMP("AKFRW-REPORT",$J,INDEX)
 .   .   .   E  S BLANK=1
 .   ;S AKFRY="^TMP(""AKFRW-REPORT"","_$J_")"
 .   M AKFRY=^TMP("AKFRW-REPORT",$J)
 Q
 ;
FLAB(AKFRY,DFN) ;-- Future Lab Orders
 ;
 N I,N,L K AKFRY
 S I=0
 I '$D(^DPT(DFN,"LR")) S AKFRY(0)="Patient has never had lab" Q
 S AKFRY(I)="No future lab orders"
 S LRDFN=^DPT(DFN,"LR")
 S LRODT=DT-.5 F  S LRODT=$O(^LRO(69,LRODT)) Q:LRODT<1  D
 .S N="" F  S N=$O(^LRO(69,LRODT,1,"AA",LRDFN,N)) Q:N<1  D
 ..Q:'$D(^LRO(69,LRODT,1,N))
 ..Q:$D(^LRO(69,LRODT,1,N,1))
 ..S L=0 F  S L=$O(^LRO(69,LRODT,1,N,2,L)) Q:L<1  D
 ...S AKFRTST=$P(^LRO(69,LRODT,1,N,2,L,0),"^")
 ...S AKFRTST=$P(^LAB(60,AKFRTST,0),"^",1)
 ...S AKFRY(I)=$E(LRODT,4,5)_"/"_$E(LRODT,6,7)_"/"_$E(LRODT,2,3)_"  "_AKFRTST S I=I+1
 K LRODT,AKFRTST,LRDFN,DFN
 Q
 ;
PLAB(AKFRY,DFN) ;-- Past Lab Orders
 ;
 N I,N,L K AKFRY
 S I=0
 I '$D(^DPT(DFN,"LR")) S AKFRY(0)="Patient has never had lab" Q
 S AKFRY(0)="No lab in the past 6 months"
 S X1=DT,X2=-180 D C^%DTC S LREDT=X
 S LRDFN=^DPT(DFN,"LR")
 S LRODT=DT+.9999 F  S LRODT=$O(^LRO(69,LRODT),-1) Q:LRODT<1!(LRODT<LREDT)  D
 .S N="" F  S N=$O(^LRO(69,LRODT,1,"AA",LRDFN,N)) Q:N<1  D 
 ..Q:'$D(^LRO(69,LRODT,1,N))
 ..Q:'$D(^LRO(69,LRODT,1,N,1))
 ..S L=0 F  S L=$O(^LRO(69,LRODT,1,N,2,L)) Q:L<1  D
 ...S AKFRTST=$P(^LRO(69,LRODT,1,N,2,L,0),"^")
 ...Q:AKFRTST<1
 ...S AKFRTST=$P(^LAB(60,AKFRTST,0),"^",1)
 ...S AKFRY(I)=$E(LRODT,4,5)_"/"_$E(LRODT,6,7)_"/"_$E(LRODT,2,3)_"  "_AKFRTST S I=I+1
 K LRODT,AKFRTST,DFN,LRDFN,LREDT,X1,X2,X
 Q
