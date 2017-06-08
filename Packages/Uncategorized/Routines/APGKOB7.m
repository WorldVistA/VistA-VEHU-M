APGKOB7 ;PHOENIX/KLD; 9/26/00; TIU OBJECTS; 11/14/05  9:52 AM
ST Q
 ;
AM(N) ;Active meds, OP, IV, UD.  N=number of days back
 N AGO,C,DIC,HOLD,I,II,PSDFN,RX,SP,X,Y
 S:$G(N)="" N=45 S $P(SP," ",50)="",X1=DT,X2=-N
 D C^%DTC S AGO=X,C=0 D K,NONE("ACTIVE MEDS")
 S DIC="^PS(55,",DIC(0)="QM",X=DFN D ^DIC S PSDFN=+Y
 I PSDFN<0 D  Q "~@^TMP(""APGKOB7"","_$J_")"
 .S ^TMP("APGKOB7",$J,1,0)="NO PHARMACY INFO ON FILE"
 D SET("Active meds in the last "_N_" days:"),SET("")
 D SET("***  Outpatient Meds  ***") S HOLD=C
 F I=0:0 S I=$O(^PS(55,PSDFN,"P",I)) Q:'I  S RX=^(I,0) D
 .F II=0,2 S X(II)=$G(^PSRX(RX,II))
 .Q:X(0)=""!(X(2)="")
 .S X1=$P(X(2),U,5),X2=$P(X(0),U,8) D C^%DTC Q:X<AGO  ;dispense date + days supply
 .S X=$$GETD($P(X(0),U,6))_"  Dispensed: "_$$D($P($P(X(2),U,5),"."))
 .D SET(X_" ("_$P(X(0),U,8)_" days)")
 D NF:HOLD=C,SET(""),SET("***  IV Meds  ***") S HOLD=C
 F I=0:0 S I=$O(^PS(55,PSDFN,"IV",I)) Q:'I  D
 .F II=0,.2 S X(II)=$G(^PS(55,PSDFN,"IV",I,II))
 .Q:X(0)=""!(X(.2)="")  Q:$P(X(0),U,3)<AGO  ;Stop date
 .S X=$E("  Drug: "_$P(^PS(50.7,+X(.2),0),U)_SP,1,45)
 .D SET(X_"  Stop Date: "_$$D($P(X(0),U,3)))
 D NF:HOLD=C,SET(""),SET("***  Unit Dose Meds  ***") S HOLD=C
 F I=0:0 S I=$O(^PS(55,PSDFN,5,I)) Q:'I  S X(2)=$G(^(I,2)) D
 .Q:$P(X(2),U,4)<AGO  ;stop date
 .F II=0:0 S II=$O(^PS(55,PSDFN,5,I,1,II)) Q:'II  S X=+^(II,0) D
 ..D SET($$GETD(X)_"  Stop Date: "_$$D($P(X(2),U,4)))
 D NF:HOLD=C Q "~@^TMP(""APGKOB7"","_$J_")"
 ;
AOP(N) ;Active or Pending OP Meds.  N=number of days back^Sort alphabetically
 N %Q,AGO,C,DIC,HOLD,I,II,PSDFN,RX,SIG,SORT,SP,STATUS,X,Y
 S:$G(N)="" N=45 S SORT=$P(N,U,2),$P(SP," ",50)=""
 S X1=DT,X2=-N D C^%DTC S AGO=X,C=0
 D K,NONE($S($D(APGKPEND):"PENDING",1:"ACTIVE")_" OP MEDS")
 S DIC="^PS(55,",DIC(0)="QM",X=DFN D ^DIC S PSDFN=+Y
 I PSDFN<0 D  Q "~@^TMP(""APGKOB7"","_$J_")"
 .S ^TMP("APGKOB7",$J,1,0)="NO PHARMACY INFO ON FILE"
 D SET("Computer is the source for the following medication list:")
 D SET("") S HOLD=C
 F I=0:0 S I=$O(^PS(55,PSDFN,"P",I)) Q:'I  S RX=^(I,0) D
 .F II=0,2,"OR1","STA" S X(II)=$G(^PSRX(RX,II))
 .Q:X(0)=""!(X(2)="")
 .I $P(X(2),U,6)<DT S X1=$P(X(2),U,5),X2=$P(X(0),U,8) D C^%DTC Q:X<AGO  ;dispense date + days supply
 .I '$D(APGKPEND),'$D(APGKEXP),$D(APGKALL),$P(X(2),U,6)>DT Q:$P(X("STA"),U)'=0&($P(X("STA"),U)'=5)  ;Only allow active & suspended for future expiration dates
 .I $D(APGKPEND),$P(X(2),U,6)>DT Q:$P($G(^OR(100,$P(X("OR1"),U,2),3)),U,3)'=5  ;Order at Pending Status
 .I $D(APGKEXP) Q:$P(X(2),U,6)<AGO  Q:$P(X("STA"),U)'=11  ;Expired Status
 .D SIG($P(X("OR1"),U,2)) S X=$$GETD2($P(X(0),U,6))_"  Sig: "_SIG
 .D:'SORT SET(""),SET(X) D:SORT SET2(X)
 I SORT S C=2,(I,II,STATUS)="" D
 .F  S STATUS=$O(^TMP("APGKOB7",$J,"B",STATUS)) Q:STATUS=""  D
 ..D SET(""),SET(STATUS_":")
 ..F  S I=$O(^TMP("APGKOB7",$J,"B",STATUS,I)) Q:I=""  D
 ...F  S II=$O(^TMP("APGKOB7",$J,"B",STATUS,I,II)) Q:II=""  D SET(""),SET(" "_I)
 K APGKALL,APGKPEND,APGKEXP,^TMP("APGKOB7",$J,"B")
 Q "~@^TMP(""APGKOB7"","_$J_")"
 ;
SIG(N) S SIG="None listed" S:N SIG=$O(^OR(100,N,4.5,"ID","SIG",0))
 S:SIG SIG=$G(^OR(100,N,4.5,SIG,2,1,0))
 I SIG="",N S SIG=$O(^OR(100,N,4.5,"ID","COMMENT",0)) D
 .S:SIG SIG=$G(^OR(100,N,4.5,SIG,2,1,0))
 Q:SIG]""  S SIG=$O(^PSRX("APL",N,0)) Q:'SIG
 S SIG=$P($G(^PSRX(SIG,"SIG")),U) Q
 ;
GETD(X) Q "  Drug: "_$S(X:$E($P(^PSDRUG(X,0),U)_SP,1,45),1:"Unknown")
GETD2(X) Q $S(X:$E($P(^PSDRUG(X,0),U)_SP,1,35),1:"Unknown")
 ;
PINIT() ;Patient's initials
 N FN,LN S LN=$P(^DPT(DFN,0),U),FN=$P(LN,",",2),LN=$P(LN,",")
 Q $E(FN)_$E($P(FN," ",2))_$E(LN)
 ;
BCMS(X) ;BCMA Specific drugs in time range
 ;X=Drug name^Number^Start Date^End Date
 N SPECIFIC D K,NONE($P(X,U)_" BCMA MEDS GIVEN")
 S SPECIFIC(1)=$P(X,U),SPECIFIC(2)=$P(X,U,2),SPECIFIC(3)=0
 S T=$P(X,U,3,4) D BCMA
 Q "~@^TMP(""APGKOB7"","_$J_")"
 ;
BCMG(T) ;BCMA Meds given in time range
 D K,NONE("BCMA MEDS GIVEN TODAY"),BCMA
 Q "~@^TMP(""APGKOB7"","_$J_")"
 ;
BCMA N C,END,FLAG,I,II,ST,X S X=$P(T,U) D ^%DT
 S ST=Y,X=$P(T,U,2) D ^%DT S END=Y+.9999,C=0
 F I=0:0 S I=$O(^PSB(53.79,"B",DFN,I)) Q:'I  D
 .S X=$G(^PSB(53.79,I,0)) Q:$P(X,U,9)'="G"  ;Status not = Given
 .Q:$P(X,U,6)<ST!($P(X,U,6)>END)
 .I $D(SPECIFIC) S FLAG=0 D  Q:FLAG
 ..S:^PS(50.7,$P(X,U,8),0)'[SPECIFIC(1) FLAG=1
 ..S:SPECIFIC(3)'<SPECIFIC(2) FLAG=1 S:'FLAG SPECIFIC(3)=SPECIFIC(3)+1
 .I '$D(^PSB(53.79,I,.6)) D SET($P(^PS(50.7,$P(X,U,8),0),U)_"  "_$P($G(^PSB(53.79,I,.1)),U,5)_" - "_$$D($P(X,U,6))) Q
 .F II=0:0 S II=$O(^PSB(53.79,I,.6,II)) Q:'II  D
 ..D SET($P(^(II,0),U,2)_" "_$P(^(0),U,3)_" - "_$$D($P(X,U,6)))
 Q
 ;
VHL(T) ;Vitals High & Low within a time period
 N C,END,HIGH,I,LOW,ST,TY,VAL,X D K,NONE("VITALS HIGH & LOW")
 S X=$P(T,U) D ^%DT S ST=Y,X=$P(T,U,2) D ^%DT S END=Y+.9999,C=0
 F I=1,2,3,5,8,9,22 S HIGH(I)=0,LOW(I)=99999
 F I=0:0 S I=$O(^GMR(120.5,"C",DFN,I)) Q:'I  D
 .S X=^GMR(120.5,I,0) Q:+X<ST!(+X>END)  S TY=$P(X,U,3),VAL=$P(X,U,8)
 .Q:'$D(HIGH(TY))  S:VAL>HIGH(TY) HIGH(TY)=VAL_U_+X
 .S:VAL<LOW(TY) LOW(TY)=VAL_U_+X
 F I=1,8,22,5,3,2,9 D:$P(HIGH(I),U,2)!($P(LOW(I),U,2))
 .D SET($P(^GMRD(120.51,I,0),U)_": ")
 .S X="  High: "_$P(HIGH(I),U)
 .S:$P(HIGH(I),U,2) X=X_" ("_$$D($P(HIGH(I),U,2))_")"
 .S X=X_"   Low: "_$P(LOW(I),U)
 .S:$P(LOW(I),U,2) X=X_" ("_$$D($P(LOW(I),U,2))_")" D SET(X)
 Q "~@^TMP(""APGKOB7"","_$J_")"
 ;
SUR(F) ;Single field info from patient's Last Surgery
 ;F=field number from file 130
 N DA,GLO,SP,SUBF,X S DA=$$SURGDA()
 I 'DA Q $P(^DD(130,F,0),U)_": NO INFORMATION FOUND"
 S GLO=$P(^DD(130,F,0),U,4),SP=$P(^(0),U,2)
 S X=$P($G(^SRF(DA,$P(GLO,";"))),U,$P(GLO,";",2))
 S SP=(SP["S"!(SP["P")) S:SP SUBF=130,X=$$DIQ(X,F)
 I X,$P(^DD(130,F,0),U,2)["D" S Y=X D DD^%DT S X=Y ;date field
 Q $S(X]"":$P(^DD(130,F,0),U)_": "_X,1:"NOT FOUND")
 ;
SURW(F) ;Word processing field info from patient's Last Surgery
 ;F=global subscript of word processing field
 N C,DA,I S C=0 D K,NONE("SURGERIES") S DA=$$SURGDA()
 I 'DA Q "NO SURGERIES FOUND"
 I '$O(^SRF(DA,F,0)) Q "NO INFORMATION FOUND"
 F I=0:0 S I=$O(^SRF(DA,F,I)) Q:'I  D SET(^(I,0))
 Q "~@^TMP(""APGKOB7"","_$J_")"
 ;
SURM(F) ;Mutliple fields from patient's Last Surgery
 ;F=Field number from file 130  (optional) F can have one or more
 ;^ and display field numbers concatenated to the end
 ;example: ".42^3" to print field 3 from multiple field .42
 N C,DA,GLO,I,SP,SUBF S C=0,SUBF=+$P(^DD(130,+F,0),U,2)
 S GLO=+$P(^(0),U,4),SP=$P(^DD(SUBF,.01,0),U,2)
 S SP=(SP["S"!(SP["P")) D K,NONE("SURGERIES") S DA=$$SURGDA()
 I 'DA Q "NO INFORMATION FOUND"
 I '$O(^SRF(DA,GLO,0)) Q "NO INFORMATION FOUND"
 F I=0:0 S I=$O(^SRF(DA,GLO,I)) Q:'I  S Y=$P(^(I,0),U) D
 .S C(1)=C I SP S C=$P(^DD(SUBF,.01,0),U,2) D Y^DIQ
 .S C=C(1) F II=2:1 Q:$P(F,U,II)=""  D
 ..S X=$P(^DD(SUBF,$P(F,U,II),0),U,4)
 ..S Y=Y_"  "_$$DIQ($P(^SRF(DA,GLO,I,+X),U,$P(X,";",2)),$P(F,U,II))
 .D SET(Y)
 Q "~@^TMP(""APGKOB7"","_$J_")"
 ;
SURGD(F) ;Uses GET1^DIQ to pull info from a double-nested multiple field
 ;F=Subscript where multiple is stored ^ subfile # ^ Field #1 ^ Field #2 etc.
 N C,DA,FD,I,II,III,X D K,NONE("SURGERIES") S C=0,DA=$$SURGDA()
 I 'DA Q "NO INFORMATION FOUND"
 D SET("Case #"_DA)
 F I=0:0 S I=$O(^SRF(DA,+F,I)) Q:'I  D
 .F II=0:0 S II=$O(^SRF(DA,+F,I,1,II)) Q:'II  D
 ..F III=3:1 S FD=$P(F,U,III) Q:FD=""  S X="" D
 ...S X=X_$P(^DD($P(F,U,2),FD,0),U)_": "_$$GET1^DIQ($P(F,U,2),II_","_I_","_DA,FD)
 ...S:III>3 X="   "_X D SET(X)
 Q "~@^TMP(""APGKOB7"","_$J_")"
 ;
SURGDA() Q $O(^SRF("B",DFN,9E9),-1)
DIQ(Y,X) N C S C=$P(^DD(SUBF,X,0),U,2) D Y^DIQ Q Y
 ;
K K ^TMP($J),^TMP("APGKOB7",$J) Q
NONE(X) S ^TMP("APGKOB7",$J,1,0)=X_" - NONE FOUND" Q
NF D SET("  ***  NONE FOUND  ***") Q
SET(X) S C=C+1,^TMP("APGKOB7",$J,C,0)=X Q
SET2(Z) N Y S Y=$P(X("STA"),U),C(1)=C,C=$P(^DD(52,100,0),U,2) D Y^DIQ
 S:Y]"" C=C(1)+1,^TMP("APGKOB7",$J,"B",Y,$E(Z,1,255),RX)="" Q
D(Y) D DD^%DT Q Y
D1(Y) Q +$E(Y,4,5)_"/"_+$E(Y,6,7)_"/"_$E(Y,2,3)_" @ "_$E($P(Y,".",2)_"0000",1,4)
D2(Y) Q $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
