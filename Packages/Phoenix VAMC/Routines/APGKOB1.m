APGKOB1 ;PHOENIX/KLD; 10/8/98; TIU OBJECTS; 6/4/99  11:23 AM
ST Q
 ;
MAR() ;Marital status
 N X S X=$P($G(^DPT(DFN,0)),U,5) Q $S(X:$P(^DIC(11,X,0),U),1:"UNKNOWN")
 ;
PER() ;Period of service
 N X S X=$P($G(^DPT(DFN,.32)),U,3)
 Q $S(X:$P(^DIC(21,X,0),U),1:"UNKNOWN")
 ;
APN() ;Address & phone for Next of Kin
 N REC,X S REC=$G(^DPT(DFN,.21)),X=$P(REC,U,1),X=X_", " ;<543/EPH> Added ',X=$P(REC,U,1...
 S X=X_$S($P(REC,U,3)]"":$P(REC,U,3),1:"NO STREET LISTED") ;<543/EPH> Chanded to S X=X_$S
 S:$P(REC,U,4)]"" X=X_" "_$P(REC,U,4)
 S X=X_"  "_$S($P(REC,U,6)]"":$P(REC,U,6),1:"NO CITY LISTED")
 I $P(REC,U,6)]"" S:$P(REC,U,7) X=X_", "_$P(^DIC(5,$P(REC,U,7),0),U,2)
 Q X_" "_$P(REC,U,8)_"  "_$P(REC,U,9)
 ;
ADM() ;Admissions in the last year (up to 10)
 N C,DA,I,INV,REC,SP,X D K,NONE("ADMISSIONS")
 S C=0,INV=9999999.9999999-(DT-10000),$P(SP," ",20)=""
 F I=0:0 S I=$O(^DGPM("ATID1",DFN,I)) Q:'I!(I>INV)!(C>10)  D
 .F DA=0:0 S DA=$O(^DGPM("ATID1",DFN,I,DA)) Q:'DA  D
 ..S REC=$G(^DGPM(DA,0)) Q:REC=""  S X=$P(^DIC(42,$P(REC,U,6),0),U)
 ..S X=$E($$D(9999999.9999999-I)_SP,1,25)_"Ward: "_X
 ..S X=$E(X_SP,1,40)_"DX: "_$P(REC,U,10) D SET($E(X_SP,1,79))
 Q "~@^TMP(""APGKOB1"","_$J_")"
 ;
OPV() ;Outpatient visits in the last 6 months (up to 10)
 N C,DA,I,SIX,X D K,NONE("OUTPAT VISITS")
 S X1=DT,X2=-183 D C^%DTC S SIX=X,C=0
 F I=9E9:0 S I=$O(^SCE("ADFN",DFN,I),-1) Q:I<SIX!(C>9)  D
 .F DA=0:0 S DA=$O(^SCE("ADFN",DFN,I,DA)) Q:'DA  D
 ..S X=$G(^SCE(DA,0)) Q:X=""  S X=$P(^SC($P(X,U,4),0),U)
 ..D SET($$D(I)_"  Loc: "_X)
 Q "~@^TMP(""APGKOB1"","_$J_")"
 ;
RDS() ;Rated disabilities (up to 10)
 N C,I,X D K,NONE("RATED DISABILITIES") S C=0
 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I!(C>9)  S X=^(I,0) D:X]""
 .D SET($P(^DIC(31,+X,0),U)_"  "_$P(X,U,2)_"%  "_$S('$P(X,U,3):"Not ",1:"")_"SC")
 Q "~@^TMP(""APGKOB1"","_$J_")"
 ;
TRA() ;Transfusions in last year (up to 10)
 N C,DA,I,INV,X D K,NONE("TRANSFUSIONS") S C=0,INV=9999999-(DT-10000)
 S LRDFN=$G(^DPT(DFN,"LR")) I 'LRDFN Q "TRANSFUSIONS - NO LRDFN ON FILE"
 F I=0:0 S I=$O(^LR(LRDFN,1.6,I)) Q:'I!(I>INV)  S X=$G(^(I,0)) D:X]""
 .D SET($$D(+X)_"   "_$P(^LAB(66,$P(X,U,2),0),U))
 Q "~@^TMP(""APGKOB1"","_$J_")"
 ;
SUR() ;Surgeries in last year (up to 10)
 D S2(10,1) Q "~@^TMP(""APGKOB1"","_$J_")"
SUR1() D S2(50,10) Q "~@^TMP(""APGKOB1"","_$J_")"
S2(N,Y) N C,I,X,YEAR D K,NONE("SURGERIES")
 S X1=DT,X2=-365*Y D C^%DTC S C=0,YEAR=X
 F I=0:0 S I=$O(^SRF("B",DFN,I)) Q:'I!(C>(N-1))  D
 .S X=$G(^SRF(I,0)) Q:$P(X,U,9)<YEAR
 .D SET($$D($P(X,U,9))_"  Proc: "_$P($G(^("OP")),U))
 Q
 ;
TL() ;Today's Lab results
 N C,I,LRDFN,TEST,X D K,NONE("LAB RESULTS TODAY")
 S C=0,LRDFN=$G(^DPT(DFN,"LR")),SD=9999999-DT-1,ED=SD+1 Q:'LRDFN
 F I=SD:0 S I=$o(^LR(LRDFN,"CH",I)) Q:'I!(I>ED)  D
 .F TEST=1:0 S TEST=$o(^LR(LRDFN,"CH",I,TEST)) Q:'TEST  S X=^(TEST) D
 ..D SET($P(^DD(63.04,TEST,0),U)_": "_$P(X,U)_"  "_$P(X,U,2))
 Q "~@^TMP(""APGKOB1"","_$J_")"
 ;
BMI() ;Body Mass Index  |BMI;3;2Y|
 N AGO,C,DA,H,HT,I,WT,X
 S AGO=9999999-(DT-20000),C=0,X="BODY MASS INDEX" D K,NONE(X)
 F I=0:0 S I=$O(^GMR(120.5,"AA",DFN,8,I)) Q:'I!(I>AGO)!(C>2)  D
 .F DA=0:0 S DA=$o(^GMR(120.5,"AA",DFN,8,I,DA)) Q:'DA  D
 ..S C=C+1,HT(C)=9999999-I_U_$P(^GMR(120.5,DA,0),U,8)
 S:C=1&('$P($G(HT(1)),U,2)) C=0 ;Invalid height
 I 'C D SET(X_" - NO HEIGHTS FOUND") Q "~@^TMP(""APGKOB1"","_$J_")"
 S C=0 F I=0:0 S I=$O(^GMR(120.5,"AA",DFN,9,I)) Q:'I!(I>AGO)!(C>2)  D
 .F DA=0:0 S DA=$o(^GMR(120.5,"AA",DFN,9,I,DA)) Q:'DA  D
 ..S C=C+1,WT(C)=9999999-I_U_$P(^GMR(120.5,DA,0),U,8)
 I 'C D SET(X_" - NO WEIGHTS FOUND") Q "~@^TMP(""APGKOB1"","_$J_")"
 S C=0 D SET(X) F I=1:1:3 D:$D(WT(I))
 .S HT=0 S:$P($G(HT(I)),U,2) HT=$P(HT(I),U,2) S WT=$P(WT(I),U,2)
 .S H=HT*.0254,H=H*H,WT=WT/2.2,X=$$D(+WT(I))_"   "
 .S:H X=X_$J((WT/H),4,1) D SET(X)
 Q "~@^TMP(""APGKOB1"","_$J_")"
 ;
IDW() ;Ideal Weight |IDEAL WEIGHT;3;2Y|
 N C,ED,I,REC,SP,X D K,NONE("IDEAL WEIGHT")
 S C=0,$P(SP," ",20)="",ED=DT-20000,ED=9999999-ED
 F I=0:0 S I=$O(^FHPT(DFN,"N",I)) Q:'I!(C)!(I>ED)  S X=$G(^(I,0)) D
 .Q:'$P(X,U,10)  S REC=$E("Date: "_$$D($P(9999999-I,"."))_SP,1,22)
 .S REC=REC_"Ideal Weight: "_$P(X,U,10) D SET(REC)
 Q "~@^TMP(""APGKOB1"","_$J_")"
 ;
TO() ;Today's orders
 N A,C,I,II,ORD,SP,X D K
 S ^TMP("APGKOB1",$J,1,0)="" ;,NONE("ORDERS TODAY")
 S $P(SP," ",20)="",A=DFN_";DPT(",C=2,SD=9999999-DT-1,ED=SD+1
 F I=SD:0 S I=$o(^OR(100,"AC",A,I)) Q:'I!(I>ED)  D
 .F ORD=1:0 S ORD=$o(^OR(100,"AC",A,I,ORD)) Q:'ORD  D
 ..F II=0,3 S X(II)=^OR(100,ORD,II)
 ..F II=0:0 S II=$O(^OR(100,ORD,.1,II)) Q:'II  D
 ...S X=$E($E($P(^ORD(101.43,+^(II,0),0),U),1,22)_SP,1,25)
 ...S X=$E(X_$P(^ORD(100.01,$P(X(3),U,3),0),U)_SP,1,34)_" "
 ...S X=$E(X_$$D($P(X(0),U,7))_SP,1,57)_$$D($P(X(0),U,8)) D SET(X)
 I C>2 S X=$e("  Item Ordered"_SP,1,25)_$E("STATUS"_SP,1,11) D
 .S C=0,X=$E(X_"START DATE"_SP,1,57)_"STOP DATE" D SET(X),SET("")
 Q "~@^TMP(""APGKOB1"","_$J_")"
 ;
CLAIM() ;Claim number
 N X S X=$P($G(^DPT(DFN,.31)),U,3)
 Q "CLAIM NUMBER - "_$S(X="":"NONE FOUND",1:X)
 ;
RELIG() ;Patient's religious preference
 N X S X=$P($G(^DPT(DFN,0)),U,8)
 Q "RELIGION - "_$S(X="":"NONE FOUND",1:$P(^DIC(13,X,0),U))
 ;
K K ^TMP("APGKOB1",$J) Q
NONE(X) S ^TMP("APGKOB1",$J,1,0)=X_" - NONE FOUND" Q
SET(X) S C=C+1,^TMP("APGKOB1",$J,C,0)=X Q
D(Y) D DD^%DT Q Y
OPVFUT() ;Future Optpatient visits for 6 months (up to 10)
 ;Columbia,Mo/EPH; Added this section to original routine. 7/27/00
 N C,DA,DATE,NDATE,X D K,NONE("OUTPAT VISITS")
 S X1=DT,X2=90 D C^%DTC S NDATE=X,DATE=DT-1,C=0
 F  S DATE=$O(^DPT(DFN,"S",DATE)) Q:DATE<1!(DATE>NDATE)!(C>9)  D
 .S INFO=$G(^DPT(DFN,"S",DATE,0)) Q:INFO=""  S INFO=$P(^SC($P(INFO,"^",1),0),"^")
 .D SET($$D(DATE)_"  Clinic: "_INFO)
 Q "~@^TMP(""APGKOB1"","_$J_")"
 ;
