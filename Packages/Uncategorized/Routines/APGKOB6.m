APGKOB6 ;PHOENIX/KLD; 1/7/00; TIU OBJECTS; 11/8/00  10:44 AM
ST Q
 ;
LNA() ;|LAST NUTRITIONAL ASSESSMENT| Object
 N C,ID,X D K S X=$$FHWORADT^FHWORA(DFN),C=1
 I +X<0 D  Q "~@^TMP(""APGKOB6"","_$J_")"
 .D NONE("LAST NUTRITIONAL ASSESSMENT"),SET($P(X,U,2)) Q
 S ID=$O(^TMP($J,"FHADT",DFN,0)),ID=^TMP($J,"FHADT",DFN,ID)
 K ^TMP($J) D NUTR^ORWRP1(.X,DFN,ID)
 Q "~@^TMP(""ORXPND"","_$J_")"
 ;
AOP() ;Active Outpatient Prescriptions
 N C,DA,I,II,SP,X D K,NONE("ACTIVE OUTPATIENT PRESCRIPTIONS") S C=0
 D OP(0) Q "~@^TMP(""APGKOB6"","_$J_")"
 ;
SUSOP() ;Suspended Outpatient Prescriptions
 N C,DA,I,II,SP,X D K,NONE("SUSPENDED OUTPATIENT PRESCRIPTIONS") S C=0
 D OP(5) Q "~@^TMP(""APGKOB6"","_$J_")"
 ;
OP(S) F I=0:0 S I=$O(^PS(55,DFN,"P","A",I)) Q:'I  D
 .F DA=0:0 S DA=$O(^PS(55,DFN,"P","A",I,DA)) Q:'DA  D
 ..F II=0,2,"STA" S X(II)=$G(^PSRX(DA,II))
 ..Q:$P(X("STA"),U)'=S  ;Active Status=0, Suspended=5, etc.
 ..D SB($P(^PSDRUG($P(X(0),U,6),0),U),$P(X(2),U,2))
 Q:'$D(^TMP("APGKOB6",$J,"B"))  ;"~@^TMP(""APGKOB6"","_$J_")"
 S C=0,I="",$P(SP," ",40)=""
 F  S I=$O(^TMP("APGKOB6",$J,"B",I)) Q:I=""  D
 .F II=0:0 S II=$O(^TMP("APGKOB6",$J,"B",I,II)) Q:'II  S X=^(II) D
 ..D SET($E(I_SP,1,40)_"  Fill Date: "_$$D(X)) 
 K ^TMP("APGKOB6",$J,"B") Q
 ;
INS() ;Patient Insurance Policies (all)
 N C,I,REC,SP,X S C=1,$P(SP," ",50)="" D K,NONE("Insurance Policies")
 F I=0:0 S I=$O(^DPT(DFN,.312,I)) Q:'I  S REC=^(I,0) D
 .S X=$E($P(^DIC(36,+REC,0),U),1,21)_SP
 .S X=$E(X_SP,1,24)_$E($$SOC^APGKOB5(2.312,.2,$P(REC,U,20)))
 .S X=$E(X_SP,1,30)_$P(REC,U,2),X=$E(X_SP,1,47)
 .S X=$E(X_$P(REC,U,3)_SP,1,58)_$$SOC^APGKOB5(2.312,6,$P(REC,U,6))
 .S X=$E(X_SP,1,67)_$$D($P(REC,U,8)) D SET(X)
 I C>1 S C=0 D SET("  Insurance            COB   Subscriber ID     Group      Holder    Effective")
 Q "~@^TMP(""APGKOB6"","_$J_")"
 ;
MS() ;Military Service
 N C,I,REC,SP,X,Z D K,NONE("Military Service")
 S C=0,$P(SP," ",20)="",REC=$G(^DPT(DFN,.32))
 I $P(REC,U,5)="" Q "~@^TMP(""APGKOB6"","_$J_")"
 D SET("Service Branch    Service #    Entered         Seperated       Discharge")
 F I=1,2,3 S Z=I*5 D:$P(REC,U,Z)
 .S X=$E($P(^DIC(23,$P(REC,U,Z),0),U)_SP,1,18)_$P(REC,U,Z+3)
 .S X=$E(X_SP,1,31)_$$D($P(REC,U,Z+1)),X=$E(X_SP,1,47)
 .S X=$E(X_$$D($P(REC,U,Z+2))_SP,1,63)
 .S:$P(REC,U,Z-1) X=X_$P(^DIC(25,$P(REC,U,Z-1),0),U) D SET(X)
 Q "~@^TMP(""APGKOB6"","_$J_")"
 ;
PLA(F) ;Problem List Active F=0 or 1 for full display
 N C,I,SP,X S $P(SP," ",60)=""
 D K,NONE("Problem List - Active"),GETLIST^GMPLHS(DFN,"A") S C=0
 I '$D(^TMP("GMPLHS",$J)) Q "~@^TMP(""APGKOB6"","_$J_")"
 D SET("Computerized Problem List is the source for the following:")
 D SET("")
 F I=0:0 S I=$O(^TMP("GMPLHS",$J,I)) Q:'I  S X=$J(I,2)_". "_^(I,"N") D
 .S:F X=$E(X_SP,1,54)
 .S:F X=X_$$D2($P(^TMP("GMPLHS",$J,I,0),U,2))_"  "_$P(^(0),U,7)
 .S X=$E(X,1,80) D COMMENT:$D(^TMP("GMPLHS",$J,I,"C")),SET(X)
 K ^TMP("GMPLHS",$J) Q "~@^TMP(""APGKOB6"","_$J_")"
COMMENT N II,III F II=0:0 S II=$O(^TMP("GMPLHS",$J,I,"C",II)) Q:'II  D
 .F III=0:0 S III=$O(^TMP("GMPLHS",$J,I,"C",II,III)) Q:'III  D
 ..S X=X_"  "_$P(^(III,0),U)
 Q
 ;
PFT(T) ;Pulmonary Function Test
 N C,DA,ED,I,II,REC,SP,X S C=0,$P(SP," ",60)="",X=T,T=$P(T,U,2)
 D K,NONE("PFT"),AGO^APGKOB3 S T=X
 F I=0:0 S I=$O(^MCAR(690,"AC",DFN,I)) Q:'I!(I>ED)!(C=+T)  D
 .F DA=0:0 S DA=$O(^MCAR(690,"AC",DFN,I,"MCAR(700",DA)) Q:'DA  D
 ..F II=0:0 S II=$O(^MCAR(700,DA,4,II)) Q:'II  S REC=^(II,0) D
 ...S X=$$D2(9999999.9999-I)_"  Flows Study: "
 ...S X=$E(X_$$SOC^APGKOB5(700.018,.01,$P(REC,U))_SP,1,45)
 ...S X=$E(X_"FVC: "_$P(REC,U,2)_SP,1,60)_"FEV1: "_$P(REC,U,3) D SET(X)
 Q "~@^TMP(""APGKOB6"","_$J_")"
 ;
SP() ;|LAST SURGICAL PATH REPORT|
 D K,NONE("SURGICAL PATH REPORT") S C=0,LRDFN=$G(^DPT(DFN,"LR"))
 I 'LRDFN D SET("SURGICAL PATH REPORT - NO LRDFN ON FILE") Q "~@^TMP(""APGKOB6"","_$J_")"
 S DATE=$O(^LR(LRDFN,"SP",0)) Q:'DATE "~@^TMP(""APGKOB6"","_$J_")"
 D SET("LAST SURGICAL PATH REPORT - "_$$D(9999999-DATE))
 F I=.3,.5,1,1.1,1.2 D:$O(^LR(LRDFN,"SP",DATE,I,0))
 .D SET("  "_$P("^^PREOP DIAG.^^POSTOP DIAG^^^^^GROSS DESCRIPTION^MICROSCOPIC EVAL^SUPPLEMENTARY REPORT",U,I*10)_":")
 .F II=0:0 S II=$O(^LR(LRDFN,"SP",DATE,I,II)) Q:'II  D
 ..S FLAG=1 D SET("    "_^(II,0))
 Q "~@^TMP(""APGKOB6"","_$J_")"
 ;
SET(X) S C=C+1,^TMP("APGKOB6",$J,C,0)=X Q
SB(X,Y) S C=C+1,^TMP("APGKOB6",$J,"B",X,C)=Y Q
 ;
AGO S X1=DT,X2=+T,X=$P(T,X2,2),X2=-X2
 S X2=X2*$S(X="M":30,X="W":7,X="D":1,1:365) D C^%DTC S ED=X Q
 ;
K K ^TMP($J),^TMP("APGKOB6",$J) Q
NONE(X) S ^TMP("APGKOB6",$J,1,0)=X_" - NONE FOUND" Q
D(Y) D DD^%DT Q Y
D1(Y) Q +$E(Y,4,5)_"/"_+$E(Y,6,7)_"/"_$E(Y,2,3)_" @ "_$E($P(Y,".",2)_"0000",1,4)
D2(Y) Q $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
