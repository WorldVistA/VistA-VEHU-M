APGKOB10 ;PHOENIX/KLD; 8/9/04; TIU OBJECTS; 1/11/06  8:20 AM
ST Q
 ;
NVA(T) ;Active Non-VA Meds
 N C,ED,I,II,PSDFN,REC,SP,X S $P(SP," ",80)="",(C,C(1))=0
 D K,NONE("NON-VA MEDS"),AGO^APGKOB5
 S PSDFN=$O(^PS(55,"B",DFN,0)) Q:'PSDFN "~@^TMP(""APGKOB10"","_$J_")"
 Q:'$O(^PS(55,PSDFN,"NVA",0)) "~@^TMP(""APGKOB10"","_$J_")"
 S $P(REC,"=",80)="" D SET("     Active Non-VA Meds"),SET(REC)
 F I=9E9:0 S I=$O(^PS(55,PSDFN,"NVA",I),-1) Q:'I  S REC=^(I,0) D
 .Q:$P(REC,U,9)&($P(REC,U,9)<ED)  ;Start Date
 .Q:$P(REC,U,6)  ;D/C status or dead
 .S C(1)=C(1)+1,X=$E(C(1)_")"_SP,1,5)_$P(^PS(50.7,+REC,0),U) D SET("")
 .D:'$P(T,U,2)
 ..D SET($E(X_SP,1,52))
 ..S X="       Dose: "_$S($P(REC,U,3)]"":$P(REC,U,3),1:"Unknown")
 ..S X=$E(X_SP,1,27)_" Med Route: "
 ..S X=X_$S($P(REC,U,4)]"":$P(REC,U,4),1:"Unknown")
 ..S X=$E(X_SP,1,55)_" Schedule: "_$P(REC,U,5) D SET(X)
 .D:$P(T,U,2)
 ..S X=X_"  "_$S($P(REC,U,3)]"":$P(REC,U,3),1:"Dose Unknown")
 ..S X=X_"  "
 ..S X=X_$S($P(REC,U,4)]"":$P(REC,U,4),1:"Med Route Unknown")
 ..S X=X_"  "_$P(REC,U,5) D SET(X)
 .F II=0:0 S II=$O(^PS(55,PSDFN,"NVA",I,1,II)) Q:'II  S REC=^(II,0) D
 ..S X(1)=$O(^PS(55,PSDFN,"NVA",I,1,0))
 ..S X=$S(II=X(1):"       Comments: ",1:$E(SP,1,17))_REC D SET(X)
 Q "~@^TMP(""APGKOB10"","_$J_")"
 ;
LO(P,M) ;Last Order.  P=Package IEN from file 9.4
 N C,CNT,I,II,ORD,SP S (C,CNT)=0,$P(SP," ",50)="",M=$G(M,1)
 D K,NONE("Last Active "_$P(^DIC(9.4,P,0),U)_" Order")
 S ^TMP("APGKOB10",$J,3,0)=^TMP("APGKOB10",$J,1,0)
 S X="  Item Ordered           Start Date"
 S:$D(APGKSTAT) X=X_"       Status" D SET(X),SET("")
 F I=0:0 S I=$O(^OR(100,"AC",DFN_";DPT(",I)) Q:'I!(CNT'<M)  D
 .F ORD=0:0 S ORD=$O(^OR(100,"AC",DFN_";DPT(",I,ORD)) Q:'ORD  D
 ..S X(0)=$G(^OR(100,ORD,0)),X(3)=$G(^(3))
 ..Q:$P(X(0),U,14)'=P  ;Package
 ..I '$D(APGKSTAT) Q:56'[$P(X(3),U,3)  ;Status
 ..S CNT=CNT+1 F II=0:0 S II=$O(^OR(100,ORD,.1,II)) Q:'II  D
 ...S X=$E($E($P($G(^ORD(101.43,+^(II,0),0)),U),1,22)_SP,1,25)
 ...S X=$E(X_$$D($P($P(X(0),U,8),"."))_SP,1,40) ;Start Date
 ...;S X=X_$$D($P($P(X(0),U,9),".")) ;Stop Date
 ...S:$D(APGKSTAT) X=X_"  "_$P(^ORD(100.01,$P(X(3),U,3),0),U)
 ...D SET(X)
 K APGKSTAT Q "~@^TMP(""APGKOB10"","_$J_")"
 ;
COL() ;Active Outpat & Inpat Meds in a column
 N C,I,II,OUT,SP S (C,OUT)=0,$P(SP," ",41)=""
 D K,NONE("Active Outpat/Inpat Meds")
 S X=$$LIST^TIULMED(DFN,"^TMP(""TIUMED"",$J)",1,0,1,0,0,0)
 F I=0:0 S I=$O(^TMP("TIUMED",$J,I)) Q:'I  S X=^(I,0) D:"="'[$E(X)
 .S:X["Active Outpatient Medications" OUT=1
 .S:X["Active Inpatient Medications" OUT=0
 .F II=1:35 S X(1)=$E(X,II,II+34) Q:X(1)=""  D 
 ..S:II>1 X(1)="  "_X(1)
 ..S C=C+1,^TMP("APGKOB10",$J,"SORT",OUT,C)=X(1)
 S C=0 F I=0:0 S I=$O(^TMP("APGKOB10",$J,"SORT",0,I)) Q:'I  D SET(^(I))
 S C=0 F I=0:0 S I=$O(^TMP("APGKOB10",$J,"SORT",1,I)) Q:'I  S X=^(I) D
 .S C=C+1 I C=1 S:^TMP("APGKOB10",$J,C,0)[" - NONE FOUND" ^(0)=""
 .S:$G(^TMP("APGKOB10",$J,C,0))="" ^(0)=SP
 .S:$L(^(0))<41 ^(0)=$E(^(0)_SP,1,40) S ^(0)=^(0)_X
 K ^TMP("TIUMED",$J),^TMP("APGKOB10",$J,"SORT")
 Q "~@^TMP(""APGKOB10"","_$J_")"
 ;
GFR(T) ;GFR score. T=your Creatinine test name
 N AGE,CREAT,GFR,RACE,SEX S CREAT=$$ONE^APGKOB2(T_"^1^9Y")
 S CREAT=$E(^TMP("APGKOB2",$J,1,0),46,49) I 'CREAT Q "NO CREATS FOUND"
 S AGE=$$AGE^TIULO(DFN),SEX=$P(^DPT(DFN,0),U,2)
 S RACE=$P(^DIC(10,$P(^(0),U,6),0),U),GFR=186*CREAT*-1.154*AGE*-.203
 S:SEX="F" GFR=GFR*.742 S:RACE["BLACK" GFR=GFR*1.21
 Q GFR
 ;
EM(N) ;Expired meds in last N days
 N AGO,C,ED,I,II,REC,RX,SP,T,X
 D K,NONE("EXPIRED MEDS IN LAST "_N_" DAYS")
 S T=N_"D" D AGO^APGKOB5 S AGO=X,C=0,$P(SP," ",50)=""
 F I=0:0 S I=$O(^PS(55,DFN,"P",I)) Q:'I  S RX=^(I,0) D
 .F II=0,2,"STA" S REC(II)=$G(^PSRX(RX,II))
 .Q:"02"[$P(REC("STA"),U)  ;Active, refilled
 .Q:$P(REC(2),U,6)<AGO!($P(REC(2),U,6)>DT)
 .S X=$E($P(^PSDRUG($P(REC(0),U,6),0),U)_SP,1,40)
 .D SET(X_"Exp: "_$$D($P(REC(2),U,6)))
 Q "~@^TMP(""APGKOB10"","_$J_")"
 ;
CV911() ;Combat Vet Discharged after 9/11/01
 N C,X D K S C=0
 I $P($G(^DPT(DFN,.52)),U,11)'="Y" D SET("") G CV911Q ;Not a combat vet
 I $P($G(^DPT(DFN,.32)),U,7)<3010911 D SET("") G CV911Q  ;d/c before 9/11
 D SET("OIF/OEF Vet; Must be seen within 30 days")
 S $P(X,"-",73)="" D SET(X)
CV911Q Q "~@^TMP(""APGKOB10"","_$J_")"
 ;
STOP(S) ;Appts in clinic with selected stop code S=Stop code ^ 0, 1, or 2
 ;1=ALL appts, 0=past appts, 2=future appts
 N APTYP,C,I S APTYP=$P(S,U,2),S=+S,C=0
 D K,NONE($P("PAST^ALL^FUTURE",U,APTYP+1)_" APPTS IN CLINICS WITH STOP CODE "_S)
 D GA^APGKOB4("","") G:CNT=0 STOPQ
 F I=0:0 S I=$O(^TMP($J,"SDAMA301",DFN,I)) Q:'I  S X=^(I) D
 .Q:APTYP=0&(I>DT)  Q:APTYP=2&(I<DT)
 .Q:$P(X,U,3)["CANCELLED"!($P(X,U,3)["RESCHEDULED")
 .S CLIN=+$P(X,U,2),STOP=$P(^SC(CLIN,0),U,7) Q:'STOP
 .S STOP=$P(^DIC(40.7,STOP,0),U,2) Q:STOP'=S
 .D NSET($$D(I)_"  "_$P($P(X,U,2),";",2))
 I $O(^TMP("APGKOB10",$J,""))-1 S C=0 D
 .F I=-9E9:0 S I=$O(^TMP("APGKOB10",$J,I)) Q:I>0  D
 ..D SET(^TMP("APGKOB10",$J,I,0)) ;=^TMP("APGKOB10",$J,I,0)
 ..K ^TMP("APGKOB10",$J,I,0)
STOPQ Q "~@^TMP(""APGKOB10"","_$J_")"
 ;        ;
K K ^TMP("APGKOB10",$J) Q
NONE(X) S ^TMP("APGKOB10",$J,1,0)=X_" - NONE FOUND" Q
SET(X) S C=C+1,^TMP("APGKOB10",$J,C,0)=X Q
NSET(X) S C=C+1,^TMP("APGKOB10",$J,-C,0)=X Q
D(Y) D DD^%DT Q Y
