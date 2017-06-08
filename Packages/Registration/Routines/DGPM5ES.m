DGPM5ES ;ALB/MJK - DGPM Global Estimator ; 14 DEC 1990
 ;;MAS VERSION 4.7;;**25**;
 ;
EN ; -- main entry point
 K IOP D HOME^%ZIS
 D INTRO^DGPM5ES1,MAIL^DGPM5ES1,CHK G ENQ:'Y
 W !
 F I=1:1 S X=$P($T(TASK+I),";;",2) Q:X="END"  W !,X
 W !
 S ZTRTN="EST^DGPM5ES",ZTDESC="DGPM Global Estimator",ZTIO="" D ^%ZTLOAD
 G ENQ:'$D(ZTSK)
 W !,"Job has been queued. (Task #",ZTSK,")"
ENQ K L,I,ZTIO,ZTRTN,ZTDESC,Y,X,ZTSK
 Q
 ;
INIT ; space usage estimates
 S EST("DA")=.4146 ; adm's
 S EST(1)=.3685 ; d/c's
 S EST(2)=.3692 ; xfrs
 S EST("T")=.3949 ; ts xfrs
 Q
 ;
EST ; -- dequeue task here
 D INIT
 F NODE="DA",1,2,"T" S (YR(NODE),CNT(NODE))=0
 S X1=DT,X2=-365 D C^%DTC S DGDT=X ; one yr ago
 ;
 F DFN=0:0 S DFN=$O(^DPT(DFN)) Q:'DFN  F A=0:0 S A=$O(^DPT(DFN,"DA",A)) Q:'A  D CNT:$D(^(A,0))
 D SEND
ESTQ K L,DGHDR,EST,DGDT,DFN,A,CNT,NODE,YR,I,Y,X Q
 ;
CNT ; -- count xfrs
 I $D(^DPT(DFN,"DA",A,0)) S CNT("DA")=CNT("DA")+1 S:+^(0)>DGDT YR("DA")=YR("DA")+1
 I $D(^DPT(DFN,"DA",A,1)) S CNT(1)=CNT(1)+1 S:+^(1)>DGDT YR(1)=YR(1)+1
 F NODE=2,"T" F I=0:0 S I=$O(^DPT(DFN,"DA",A,NODE,I)) Q:'I  I $D(^(I,0)) S CNT(NODE)=CNT(NODE)+1 S:+^(0)>DGDT YR(NODE)=YR(NODE)+1
 Q
 ;
CHK ; -- check if already converted
 S Y=1 G CHKQ:'$O(^DGPM(1000))
 W !!,*7,"Your patient file appears to already have been converted."
 S DIR(0)="Y",DIR("B")="No",DIR("A")="Do you wish to continue"
 D ^DIR K DIR
CHKQ Q
 ;
SEND ; -- mail estimate
 S DGRT="^UTILITY(""DGPMEST"",$J)",L=0 K @DGRT,BLK S $P(BLK," ",50)=""
 S X="     Site: "_^DD("SITE") D LN S X=" " D LN
 I 'CNT("DA") S X="NOTE: There are no admissions to convert." D LN S X=" " D LN
 S TYPE="CNT",DGHDR="Analysis of All ADT Transactions" D SEND1 S X=" " D LN,LN,LN
 S TYPE="YR",Y=DGDT D DD^%DT S DGHDR="Analysis of ADT Transactions Since "_Y D SEND1 S X=" " D LN,LN
 S X="* Estimation algorithm factors in global pointer and data(including cross" D LN
 S X="  references) requirments at a 74% efficiency level." D LN
 S X="  Also, one block equals 1024 bytes." D LN
 S XMSUB="DGPM Global Size Estimate",XMDUZ=.5,XMY(DUZ)="",XMTEXT=$E(DGRT,1,$L(DGRT)-1)_"," D ^XMD
SENDQ K TYPE,XMSUB,XMDUZ,XMTEXT,XMY,@DGRT,DGRT,BLK Q
 ;
SEND1 ; -- send est for TYPE
 S (TOT,CTOT)=0
 S X=$E(BLK,1,(80-$L(DGHDR))/2)_DGHDR D LN S X=" " D LN
 S X="Type of                 # of          Est. Blocks        Estimated" D LN
 S X="Movement              Movements   x   per movement   =   Total Blocks" D LN
 S X="-------------------   ---------       ------------       ------------" D LN
 F NODE="DA",1,2,"T" D MVT S X=MVT_"    "_$J(@TYPE@(NODE),6)_"           "_$J(EST(NODE),6)_"             "_$J(EST\1,6) D LN
 S X="                      ---------                          ------------" D LN
 S X="                       "_$J(CTOT,6)_"                              "_$J(TOT\1,6)_" blocks*" D LN
 K TOT,CTOT,MVT Q
 ;
MVT ;
 S EST=@TYPE@(NODE)*EST(NODE),TOT=TOT+EST\1,CTOT=CTOT+@TYPE@(NODE)
 S MVT=$E($S(NODE="DA":"Admissions",NODE=1:"Discharges",NODE=2:"Transfers",1:"Specialty Transfers")_BLK,1,19)
 Q
 ;
LN S L=L+1,@DGRT@(L,0)=X Q
 ;
TASK ;
 ;; 
 ;;Since the entire patient file must be scanned for admissions,
 ;;it is suggested that this estimator be scheduled to run at
 ;;off-peak hours.
 ;;
 ;;When the queued job is completed, a Mailman message will be
 ;;sent to you.  The message will contain the transaction type
 ;;counts, along with the estimated global needs. 
 ;;END
