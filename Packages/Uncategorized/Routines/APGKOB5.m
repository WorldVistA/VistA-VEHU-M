APGKOB5 ;PHOENIX/KLD; 11/12/99; ECHO, EXER. TOL., EKG, DEMOG. OBJECTS; 12/1/99  11:18 AM
ST Q
 ;
ECHO() ;|ECHO;1;2Y|
 N C,CNT,I,REC,X S (C,CNT)=0,T="2Y" D K,NONE("ECHO"),AGO
 I '$D(^MCAR(691,"C",DFN)) Q "~@^TMP(""APGKOB5"","_$J_")"
 F I=9E9:0 S I=$O(^MCAR(691,"C",DFN,I),-1) Q:CNT=1!('I)  D
 .F II=0,11,15 S REC(II)=$G(^MCAR(691,I,II))
 .Q:+REC(0)<ED  S CNT=CNT+1 D SET("Echo Date: "_$$D1(+REC(0)))
 .D SET("Rhythm: "_$$SOC(691,6,$P(REC(0),U,7)))
 .D SET(""),SET("Other Conclusions: "),WP(691,10),SET("")
 .S X=$P(REC(11),U) S:X X=$P(^VA(200,X,0),U)
 .D SET("Cardiology Attending: "_X)
 .S X=$P(REC(15),U) S:X X=$P(^VA(200,X,0),U)
 .D SET("Cardiology Fellow: "_X)
 Q "~@^TMP(""APGKOB5"","_$J_")"
 ;
ETT() ;|ETT;1;2Y|
 N C,CNT,I,REC,X S (C,CNT)=0,T="2Y" D K,NONE("ETT"),AGO
 I '$D(^MCAR(691.7,"C",DFN)) Q "~@^TMP(""APGKOB5"","_$J_")"
 F I=9E9:0 S I=$O(^MCAR(691.7,"C",DFN,I),-1) Q:CNT=1!('I)  D
 .F II=0,3,7,"PROV" S REC(II)=$G(^MCAR(691.7,I,II))
 .Q:+REC(0)<ED  S CNT=CNT+1 D SET("ETT Date: "_$$D1(+REC(0)))
 .D SET("Resting EKG:"),WP(691.7,2),SET("")
 .S X="Ref. MD: "_$P(REC(3),U) D SP(40) S X=X_"ETT Protocol: "
 .S X=X_$$SOC(691.7,7,$P(REC(3),U,2)) D SET(X)
 .S X="Hyperventilation: "_$P(REC(3),U,3) D SP(40) S X=X_"RS HR: "
 .S X=X_$P(REC(3),U,4) D SET(X)
 .S X="RS SBP: "_$P(REC(3),U,5) D SP(40) S X=X_"RS DBP: "
 .S X=X_$P(REC(3),U,6) D SET(X)
 .S X="RU HR: "_$P(REC(3),U,7) D SP(40) S X=X_"RU SBP: "
 .S X=X_$P(REC(3),U,8) D SET(X)
 .S X="RU DBP: "_$P(REC(3),U,9) D SET(X),SET("")
 .D SET("Comment: "),WP(691.7,6),SET("")
 .S X=$P(REC(7),U,2) S:X X=$P(^VA(200,X,0),U)
 .D SET("Attending Physician: "_X)
 .S X=$P(REC("PROV"),U) S:X X=$P(^VA(200,X,0),U)
 .D SET("Primary Provider: "_X)
 Q "~@^TMP(""APGKOB5"","_$J_")"
 ;
 ;
EKG() ;|EKG;1;2Y|
 N C,CNT,I,REC S (C,CNT)=0,T="2Y" D K,NONE("EKG"),AGO
 I '$D(^MCAR(691.5,"C",DFN)) Q "~@^TMP(""APGKOB5"","_$J_")"
 F I=9E9:0 S I=$O(^MCAR(691.5,"C",DFN,I),-1) Q:CNT=1!('I)  D
 .F II=0,"A","PROV" S REC(II)=$G(^MCAR(691.5,I,II))
 .Q:+REC(0)<ED  S CNT=CNT+1 D SET("EKG Date: "_$$D1(+REC(0)))
 .S X="Vent Rate: "_$P(REC(0),U,4) D SP(40) S X=X_"PR Interval: "
 .S X=X_$P(REC(0),U,5) D SET(X)
 .S X="QRS Duration: "_$P(REC(0),U,6) D SP(40) S X=X_"QT: "
 .S X=X_$P(REC(0),U,7) D SET(X)
 .S X="QTC: "_$P(REC(0),U,8) D SP(40) S X=X_"P Axis: "
 .S X=X_$P(REC(0),U,9) D SET(X)
 .S X="R Axis: "_$P(REC(0),U,10) D SP(40) S X=X_"T Axis: "
 .S X=X_$P(REC(0),U,11) D SET(X)
 .S X="Confirmation Status: "_$$SOC(691.5,11,$P(REC(0),U,12)) D SP(40)
 .S X=X_"Interpreted By: "_$P(^VA(200,$P(REC(0),U,13),0),U)
 .D SET(X),SET("")
 .D SET("Auto Instrument Diagnosis: "),WP(691.5,9),SET("")
 .D SET("Auto Instrument Data?: "_$$D($P(REC("A"),U)))
 .D SET("Primary Provider: "_$P(^VA(200,+REC("PROV"),0),U))
 Q "~@^TMP(""APGKOB5"","_$J_")"
 ;
DEM() ;Patient Demographics
 N AGE,C,I,REC,X S C=0 D K
 F I=0,.11,.13,.21,.32,.36,.361,.52 S REC(I)=$G(^DPT(DFN,I))
 S X=$$BSP(10)_"Address: "_$p(REC(.11),U,1) D SP(50)
 S X=X_"Phone: "_$P(REC(.13),U) D SET(X),SET($$BSP(19)_$P(REC(.11),U,2))
 S X=$$BSP(19)_$P(REC(.11),U,4)_", "_$P(^DIC(5,$P(REC(.11),U,5),0),U,2)
 S X=X_"  "_$P(REC(.11),U,6) D SP(50) S X=X_"County: "
 S X=X_$P(^DIC(5,$P(REC(.11),U,5),1,$P(REC(.11),U,7),0),U) D SET(X)
 D SET("") S AGE=$E(DT,1,3)-$E($P(REC(0),U,3),1,3)
 S:$E(DT,4,7)<$E($P(REC(0),U,3),4,7) AGE=AGE-1
 S X=$$BSP(3)_"Marital Status: "_$P(^DIC(11,$P(REC(0),U,5),0),U)
 D SP(50),SET(X_"Age: "_AGE)
 S X=$$BSP(9)_"Religion: "
 S:$P(REC(0),U,8) X=X_$P(^DIC(13,$P(REC(0),U,8),0),U)
 D SP(50) S X=X_"Sex: "_$$SOC(2,.02,$P(REC(0),U,2)) D SET(X)
 D SET($$BSP(7)_"Occupation: "_$P(REC(0),U,7))
 S X="Period of Service: "
 S:$P(REC(.32),U,3) X=X_$P(^DIC(21,$P(REC(.32),U,3),0),U) D SET(X)
 S X="Branch of Service: "
 S:$P(REC(.32),U,5) X=X_$P(^DIC(23,$P(REC(.32),U,5),0),U) D SET(X)
 S X=$$BSP(11)_"Combat: "_$$SOC(2,.5291,$P(REC(.52),U,11)) D SP(50)
 D SET(X_"POW: "_$$SOC(2,.525,$P(REC(.52),U,5)))
 S X=$$BSP(6)_"Eligibility: "
 S:$P(REC(.36),U) X=X_$P(^DIC(8,$P(REC(.36),U),0),U) D SP(50)
 D SET(X_"Status: "_$$SOC(2,.3611,$P(REC(.361),U)))
 S X=$$BSP(7)_"Means Test: "
 S:$P(REC(0),U,14) X=X_$P(^DG(408.32,$P(REC(0),U,14),0),U) D SET(X)
 S X=$$BSP(14)_"NOK: "_$P(REC(.21),U,1) D SP(50)
 D SET(X_"Relation: "_$P(REC(.21),U,2))
 S X=$$BSP(19)_$P(REC(.21),U,3) D SP(50),SET(X_"Phone: "_$P(REC(.21),U,9))
 S X=$$BSP(19)_$P(REC(.21),U,6)_", "
 S:$P(REC(.21),U,7) X=X_$P(^DIC(5,$P(REC(.21),U,7),0),U,2) D SET(X)
 Q "~@^TMP(""APGKOB5"","_$J_")"
 ;
SOC(F,G,D) Q:D="" D   N I,P,RES,X S X=$P(^DD(F,G,0),U,3),RES=""
 F I=1:1 S P=$P(X,";",I) Q:P=""  S:$P(P,":")=D RES=$P(P,":",2)
 Q RES
 ;
WP(F,G) F II=0:0 S II=$O(^MCAR(F,I,G,II)) Q:'II  D SET("  "_^(II,0))
 Q
 ;
BSP(N) Q $E("                                          ",1,N)
SP(N) N SP S $P(SP," ",80)="",X=$E(X_SP,1,N) Q
 ;
SET(X) S C=C+1,^TMP("APGKOB5",$J,C,0)=X Q
 ;
AGO S X1=DT,X2=+T,X=$P(T,X2,2),X2=-X2
 S X2=X2*$S(X="M":30,X="W":7,X="D":1,1:365) D C^%DTC S ED=X Q
 ;
K K ^TMP("APGKOB5",$J) Q
NONE(X) S ^TMP("APGKOB5",$J,1,0)=X_" - NONE FOUND" Q
D(Y) D DD^%DT Q Y
D1(Y) Q +$E(Y,4,5)_"/"_+$E(Y,6,7)_"/"_$E(Y,2,3)_" @ "_$E($P(Y,".",2)_"0000",1,4)
