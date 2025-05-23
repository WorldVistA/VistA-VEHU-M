YTSVR12 ;SLC/LLH - Score VR12 ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 72
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
SETSC(DES,LEG) ;
 N QUES,ANS
 S QUES=$E(DES)
 I QUES=1 Q $S(LEG=1:100,LEG=2:85,LEG=3:60,LEG=4:35,1:"")
 I QUES=2 Q $S(LEG'="":((LEG-1)*50),1:"")
 I (QUES>2)&(QUES<6) Q $S(LEG'="":((5-LEG)*25),1:"")
 I QUES=6 D  Q ANS
 .I $E(DES,2)'="C" S ANS=$S(LEG'="":((6-LEG)*20),1:"")
 .I $E(DES,2)="C" S ANS=$S(LEG'="":((LEG-1)*20),1:"")
 I QUES=7 Q $S(LEG'="":((LEG-1)*25),1:"")
 Q
 ;
SETKEY(DES) ;
 ;
 I DES=1 Q $$PWR^XLFMTH(2,11)
 I DES="2A" Q $$PWR^XLFMTH(2,10)
 I DES="2B" Q $$PWR^XLFMTH(2,9)
 I DES="3A" Q $$PWR^XLFMTH(2,8)
 I DES="3B" Q $$PWR^XLFMTH(2,7)
 I DES="4A" Q $$PWR^XLFMTH(2,6)
 I DES="4B" Q $$PWR^XLFMTH(2,5)
 I DES="5" Q $$PWR^XLFMTH(2,4)
 I DES="6A" Q $$PWR^XLFMTH(2,3)
 I DES="6B" Q $$PWR^XLFMTH(2,2)
 I DES="6C" Q $$PWR^XLFMTH(2,1)
 I DES="7" Q $$PWR^XLFMTH(2,0)
 Q
 ;
SUMKEY(KEY) ;
 N QN,SUM
 S SUM=0,QN=0
 I '$D(KEY) Q SUM
 F  S QN=$O(KEY(QN)) Q:'QN  S SUM=SUM+KEY(QN)
 Q SUM
MCALC(SC,KEYSUM,ROU,MCS,PCS) ;
 N I,MROW,PROW,MLABEL,PLABEL
 S MLABEL=KEYSUM_U_ROU("MKS")
 S MROW=$P($T(@MLABEL),";;",2,99)
 S PLABEL=KEYSUM_U_ROU("PKS")
 S PROW=$P($T(@PLABEL),";;",2,99)
 F I=1:1:12 D
 .S MCS=MCS+($P(MROW,"~",I)*SC(I))
 .S PCS=PCS+($P(PROW,"~",I)*SC(I))
 S MCS=MCS+$P(MROW,"~",13)
 S PCS=PCS+$P(PROW,"~",13)
 Q
GETROU(KEYSUM,ROU) ; get routine to look up values to use in calculations
 N I,K1,K2,TMP
 K ROU
 S K1=""
 F I="MKS","PKS" F  S K1=$O(@I@(K1)) Q:K1=""  S K2="" D
 .F  S K2=$O(@I@(K1,K2)) Q:'K2  D
 ..I KEYSUM=K1 S ROU(I)=@I@(K1,K2)
 ..I (KEYSUM>K1)&((KEYSUM<K2)!(KEYSUM=K2)) S ROU(I)=@I@(K1,K2)
 Q
DATA1 ;
 N I,KEY,KEYSUM,VN,MTCH,ROU,SC
 S YSINSNAM=$P($G(YSDATA(2)),U,3)
 I $G(YSINSNAM)="" S YSINSNAM=$G(YS("CODE"),"NO NAME PASSED")
 S NODE=2 F  S NODE=$O(YSDATA(NODE)) Q:NODE=""  D  ; Start at YSDATA(3)
 .S DATA=YSDATA(NODE)
 .S YSQN=$P(DATA,U,1)
 .S YSSEQ=$P(DATA,U,2),YSSEQ=$P(YSSEQ,";",1) ; Sequence Number
 .S YSCDA=$P($G(DATA),U,3) ; Choice ID
 .I (YSCDA=1155)!(YSCDA=1156)!(YSCDA="NOT ASKED") S YSCDA=""
 .D DESGNTR^YTSCORE(YSQN,.DES)
 .S LEG=$S(YSCDA'="":$$GET1^DIQ(601.75,YSCDA_",",4,"I"),1:"")
 .;Questions 8 and 9 are not scored
 .I DES<8 D
 ..;convert DES to Variable Name
 ..;S VN=$S(DES=1:"gh1x",DES="2A":"pf02x",DES="2B":"pf04x",DES="3A":"rp2x",DES="3B":"rp3x",DES="4A":"re2x",DES="4B":"re3x",DES="5":"bp2x",DES="6A":"mh3x",DES="6B":"vt2x",DES="6C":"mh4x",DES="7":"sf2x",1:"unk")
 ..;rather than use Var Names, use piece in row found in table routines
 ..S VN=$S(DES=1:1,DES="2A":2,DES="2B":3,DES="3A":4,DES="3B":5,DES="4A":6,DES="4B":7,DES="5":8,DES="6A":9,DES="6B":10,DES="6C":11,DES="7":12,1:"unk")
 ..S SC(VN)=$$SETSC(DES,LEG)
 ..I LEG="" S KEY(DES)=$$SETKEY(DES)
 S KEYSUM=$$SUMKEY(.KEY)
 I $G(KEYSUM)'="" D GETROU(.KEYSUM,.ROU)
 D MCALC(.SC,.KEYSUM,.ROU,.MCS,.PCS)
 Q
 ;
SCORESV ;
 I $D(^TMP($J,"YSG",1)),^TMP($J,"YSG",1)="[ERROR]" D  Q  ;-->out
 .K ^TMP($J,"YSCOR")
 .S ^TMP($J,"YSCOR",1)="[ERROR]"
 .S ^TMP($J,"YSCOR",2)="VR-12 Scale not found"
 ;
 S PCS=$J(PCS,0,4)
 S MCS=$J(MCS,0,4)
 ;
 K ^TMP($J,"YSCOR")
 S ^TMP($J,"YSCOR",1)="[DATA]"
 S ^TMP($J,"YSCOR",2)=$$GET1^DIQ(601.87,627_",",3,"I")_"="_PCS
 S ^TMP($J,"YSCOR",3)=$$GET1^DIQ(601.87,628_",",3,"I")_"="_MCS
 Q
 ;
BLDLKU ;
 N I,ROU,SCR,X
 F I=1:1 S X=$P($T(MCSKEY+I),";;",2,99) Q:X="zzzzz"  D
 .S SCR=$P(X,"~"),ROU=$P(X,"~",2)
 .S MKS($P(SCR,U),$P(SCR,U,2))=ROU
 F I=1:1 S X=$P($T(PCSKEY+I),";;",2,99) Q:X="zzzzz"  D
 .S SCR=$P(X,"~"),ROU=$P(X,"~",2)
 .S PKS($P(SCR,U),$P(SCR,U,2))=ROU
 Q
DLLSTR(YSDATA,YS,YSTRNG) ;
 ;  YSTRNG = 1 Score Instrument
 ;  YSTRNG = 2 get Report Answers and Text
 ;
 N DATA,DES,NODE,LEG,YSCDA,YSAN,YSSEQ,YSQN,YSINSNAM
 N PCS,MCS,MKS,PKS
 ;
 S PCS=0,MCS=0
 ;
 ;Can use stored scores, all special text is in MH REPORTS
 I YSTRNG=2 Q
 ;
 D BLDLKU
 D DATA1
 D SCORESV
 Q
 ;
MCSKEY ;
 ;;0^105~YTSVRM1
 ;;106^229~YTSVRM2
 ;;230^354~YTSVRM3
 ;;355^489~YTSVRM4
 ;;490^618~YTSVRM5
 ;;620^759~YTSVRM6
 ;;760^900~YTSVRM7
 ;;901^1046~YTSVRM8
 ;;1047^1174~YTSVRM9
 ;;1175^1312~YTSVRM10
 ;;1313^1454~YTSVRM11
 ;;1455^1600~YTSVRM12
 ;;1601^1745~YTSVRM13
 ;;1746^1898~YTSVRM14
 ;;1900^2063~YTSVRM15
 ;;2064^2190~YTSVRM16
 ;;2191^2327~YTSVRM17
 ;;2328^2467~YTSVRM18
 ;;2468^2612~YTSVRM19
 ;;2613^2756~YTSVRM20
 ;;2757^2907~YTSVRM21
 ;;2908^3074~YTSVRM22
 ;;3075^3210~YTSVRM23
 ;;3211^3359~YTSVRM24
 ;;3360^3514~YTSVRM25
 ;;3515^3671~YTSVRM26
 ;;3672^3829~YTSVRM27
 ;;3830^3989~YTSVRM28
 ;;3990^4094~YTSVRM29
 ;;zzzzz
 Q
PCSKEY ;
 ;;0^112~YTSVRP1
 ;;113^234~YTSVRP2
 ;;235^359~YTSVRP3
 ;;360^494~YTSVRP4
 ;;495^620~YTSVRP5
 ;;621^755~YTSVRP6
 ;;756^893~YTSVRP7
 ;;894^1037~YTSVRP8
 ;;1038^1162~YTSVRP9
 ;;1163^1296~YTSVRP10
 ;;1297^1432~YTSVRP11
 ;;1433^1576~YTSVRP12
 ;;1577^1715~YTSVRP13
 ;;1716^1863~YTSVRP14
 ;;1864^2023~YTSVRP15
 ;;2024^2153~YTSVRP16
 ;;2154^2286~YTSVRP17
 ;;2287^2422~YTSVRP18
 ;;2423^2569~YTSVRP19
 ;;2570^2704~YTSVRP20
 ;;2705^2851~YTSVRP21
 ;;2852^3006~YTSVRP22
 ;;3007^3152~YTSVRP23
 ;;3153^3296~YTSVRP24
 ;;3297^3445~YTSVRP25
 ;;3446^3604~YTSVRP26
 ;;3605^3754~YTSVRP27
 ;;3755^3909~YTSVRP28
 ;;3910^4090~YTSVRP29
 ;;zzzzz
 Q
