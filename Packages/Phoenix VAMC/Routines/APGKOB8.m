APGKOB8 ;PHOENIX/KLD; 11/26/01; TIU OBJECTS; 11/14/05  9:53 AM
ST Q
 ;
DS() ;Discharge meds & supplies
 N C,I,II,III,X S C=0,X=DFN_";DPT("
 D K,NONE("DISCHARGE MEDS & SUPPLIES")
 F I=0:0 S I=$O(^OR(100,"AC",X,I)) Q:'I  D
 .F II=0:0 S II=$O(^OR(100,"AC",X,I,II)) Q:'II  D
 ..F III=0,3 S X(III)=$G(^OR(100,II,III))
 ..Q:$P(X(3),U,3)'=5  ;Pending status
 ..Q:$P(X(0),U,11)'=4&($P(X(0),U,11)'=27)  ;Outpat meds, supplies
 ..Q:$P(X(0),U,17)'="D"  ;Discharge event status
 ..F III=0:0 S III=$O(^OR(100,II,.1,III)) Q:'III  D SET("") D
 ...D SET($P(^ORD(101.43,+^OR(100,II,.1,III,0),0),U)_$$STREN())
 ..F III=0:0 S III=$O(^OR(100,II,4.5,III)) Q:'III  D:^(III,0)["SIG"
 ...F J=0:0 S J=$O(^OR(100,II,4.5,III,2,J)) Q:'J  D
 ....D SET("  Sig: "_^(J,0))
 Q "~@^TMP(""APGKOB8"","_$J_")"
 ;
STREN() ;Ordered drug strength
 N STREN S STREN=$O(^OR(100,II,4.5,"ID","STRENGTH",0)) Q:'STREN ""
 Q ^OR(100,II,4.5,STREN,1)
 ;
PC() ;Primary care info
 N C,I,R S C=0 D K,NONE("PRIMARY CARE INFO"),PCDETAIL^ORWPT1(.R,DFN)
 F I=1:1 Q:'$D(R(I))  D SET(R(I))
 Q "~@^TMP(""APGKOB8"","_$J_")"
 ;
PCON() ;Pending consults
 N C,I,REC,X S C=0 D K,NONE("PENDING CONSULTS")
 F I=9E9:0 S I=$O(^GMR(123,"F",DFN,I),-1) Q:'I  D
 .S REC=$G(^GMR(123,I,0)) Q:$P(REC,U,12)'=5  ;Pending status
 .S X=$S($P(REC,U,5):$P($G(^GMR(123.5,$P(REC,U,5),0)),U),1:"")
 .S:X="" X="UNKNOWN LOCATION" D SET($$D($P($P(REC,U,7),"."))_"   "_X)
 Q "~@^TMP(""APGKOB8"","_$J_")"
 ;
SKIN(T) ;Skin tests on file.  T=Skin Test name^Number^Time Period
 N APGKDFN,C,ED,I,N,REC,VISIT,X S (C,N)=0 D K,NONE("SKIN TESTS"),PCE
 Q:'APGKDFN "~@^TMP(""APGKOB8"","_$J_")"
 F I=9E9:0 S I=$O(^AUPNVSK("C",APGKDFN,I),-1) Q:'I  D:N<$P(T(1),U,2)
 .S REC=$G(^AUPNVSK(I,0)) Q:REC=""  Q:$P(^AUTTSK(+REC,0),U)'=$P(T(1),U)
 .S VISIT=$P(REC,U,3) Q:$P($G(^AUPNVSIT(VISIT,0)),U)<ED
 .D SET($$D($P(^AUPNVSIT(VISIT,0),U))) S N=N+1
 Q "~@^TMP(""APGKOB8"","_$J_")"
 ;
IMM(T) ;Immunizations on file.  T=Number^Time Period
 N APGKDFN,C,ED,I,N,REC,VISIT,X S (C,N)=0,T=U_T
 D K,NONE("IMMUNIZATIONS"),PCE Q:'APGKDFN "~@^TMP(""APGKOB8"","_$J_")"
 F I=9E9:0 S I=$O(^AUPNVIMM("C",APGKDFN,I),-1) Q:'I  D:N<$P(T(1),U,2)
 .S REC=$G(^AUPNVIMM(I,0)) Q:REC=""
 .I $D(APGKIMM) Q:$P(^AUTTIMM(+REC,0),U)'[APGKIMM
 .S VISIT=$P(REC,U,3) Q:$P($G(^AUPNVSIT(VISIT,0)),U)<ED
 .D SET($$D($P(^AUPNVSIT(VISIT,0),"."))_"  "_$P(^AUTTIMM(+REC,0),U))
 .S N=N+1
 K APGKIMM Q "~@^TMP(""APGKOB8"","_$J_")"
 ;
ALG() ;Allergies with detail.
 N C,I,II,REC,SP,X S C=0,$P(SP," ",30)="" D K,NONE("ALLERGIES")
 F I=9E9:0 S I=$O(^GMR(120.8,"B",DFN,I),-1) Q:'I  D
 .S REC=$G(^GMR(120.8,I,0)) Q:REC=""
 .S X=$E($P(REC,U,2)_SP,1,30)_" "
 .S X=$E(X_$$D($P($P(REC,U,4),"."))_SP,1,45)_" ("
 .S X=X_$S($P(REC,U,6)="o":"observed",$P(REC,U,6)="h":"historical",1:"")
 .D SET(""),SET(X_")") S X="  Symptoms: "
 .I '$O(^GMR(120.8,I,10,0)) D SET(X_"None listed") Q
 .F II=0:0 S II=$O(^GMR(120.8,I,10,II)) Q:'II  S REC=^(II,0) D:+REC
 ..;D:X["Symptoms: " SET("")
 ..D SET(X_$P(^GMRD(120.83,+REC,0),U)) S X="            "
 Q "~@^TMP(""APGKOB8"","_$J_")"
 ;
FO(T,E) ;Future orders.  T=Type of order (pointer to 100.98, such as
 ;5 or 5^6^7^8^9 or ALL.  E=Exclude these types (same format as T)
 N APGKDFN,C,I,II,III,J,ORD,REC,SD,SP,TYPE,X D K,NONE("FUTURE ORDERS")
 I T'="ALL" F I=1:1:$L(T,U) S TYPE($P(T,U,I))=""
 I T="ALL" F I=0:0 S I=$O(^ORD(100.98,I)) Q:'I  S TYPE(I)=""
 I E]"" F I=1:1:$L(E,U) K TYPE($P(E,U,I))
 S C=0,$P(SP," ",40)="",APGKDFN=DFN_";DPT(",(II,III)=""
 F I=0:0 S I=$O(^OR(100,"ACT",APGKDFN,I)) Q:'I  D
 .F  S II=$O(^OR(100,"ACT",APGKDFN,I,II)) Q:II=""  D
 ..F  S III=$O(^OR(100,"ACT",APGKDFN,I,II,III)) Q:III=""  D
 ...S REC=$G(^OR(100,III,0)),SD=$P(REC,U,8),TYPE=$P(REC,U,11)
 ...Q:'TYPE!(SD<DT)  S ORD=+$G(^(4)) Q:'$D(TYPE(TYPE))
 ...F J=0:0 S J=$O(^OR(100,III,.1,J)) Q:'J  S X=+^(J,0) D
 ....Q:'$D(^ORD(101.43,X,0))  S X=$P(^(0),U)
 ....D SET($E(X_SP,1,40)_" "_$$D(SD)_III)
 Q "~@^TMP(""APGKOB8"","_$J_")"
 ;
LN(N,T) ;Last note.  N=Note Title (or ANY), T=Time period
 N C,ED,I,II,NOTEDATE,TITLE,X S (C,NOTEDATE)=0
 D K,NONE("LAST NOTE ("_N_")"),AGO^APGKOB5
 S TITLE=N S:N'="ANY" TITLE=$O(^TIU(8925.1,"B",N,0))
 I TITLE="" D SET(N_": INVALID NOTE TITLE") G LNQ
 F I=9E9:0 S I=$O(^TIU(8925,"C",DFN,I),-1) Q:'I!(NOTEDATE)  D
 .S X=$G(^TIU(8925,I,0)) I TITLE'="ANY" Q:+X'=TITLE
 .Q:+$G(^TIU(8925,I,12))<ED  S NOTEDATE=+^(12)
 .S:N="ANY" N="NOTE ("_$P(^TIU(8925.1,+X,0),U)_")" S I(1)=I
 S:'NOTEDATE NOTEDATE="NONE" S:NOTEDATE NOTEDATE=$$D(NOTEDATE)
 D SET("LAST "_N_": "_NOTEDATE),SET("")
 I '$D(APGKNOTX) D:'$G(I(1)) SET("NO TEXT FOUND") I $G(I(1)) D
 .F II=0:0 S II=$O(^TIU(8925,I(1),"TEXT",II)) Q:'II  D SET(^(II,0))
LNQ K APGKNOTX Q "~@^TMP(""APGKOB8"","_$J_")"
 ;
OP(P) ;Orders to a specific package.  P=IEN of package from file 9.4
 ;Multiple packages can be seperated by an ^.  P="1^2^3"
 N A,C,I,II,ORD,SP,X D K,NONE("ORDERS TO A PACKAGE")
 S $P(SP," ",30)="",A=DFN_";DPT(",C=0
 F I=1:1 S X=$P(P,U,I) Q:X=""  S ORD(X)=$P(P,";",2)
 F I=0:0 S I=$O(^OR(100,"AC",A,I)) Q:'I  D
 .F ORD=1:0 S ORD=$O(^OR(100,"AC",A,I,ORD)) Q:'ORD  D
 ..S X(0)=$G(^OR(100,ORD,0))  Q:'$P(X(0),U,14)
 ..Q:'$D(ORD($P(X(0),U,14)))
 ..F II=0:0 S II=$O(^OR(100,ORD,.1,II)) Q:'II  S X=^(II,0) D
 ...S X(1)="" S:$D(APGK) X(1)=+X_U
 ...S X=$E($E($P($G(^ORD(101.43,+X,0)),U),1,22)_SP,1,25)
 ...S X=$E(X_$$D($P($P(X(0),U,8),"."))_SP,1,40)
 ...S X=X_$$D($P($P(X(0),U,9),".")) D SET(X(1)_X)
 Q "~@^TMP(""APGKOB8"","_$J_")"
 ;
PA() ;Patient address. S T="a number" in the object method for a left margin
 N C,REC,SP,X D K,NONE("ADDRESS")
 S C=0,X=$P(^DPT(DFN,0),U) S $P(SP," ",$G(T)+1)=""
 D SET(SP_$P(X,",",2,99)_" "_$P(X,",")) S REC=$G(^DPT(DFN,.11))
 D SET(SP_$P(REC,U)),SET($P(REC,U,2)):$P(REC,U,2)]""
 D SET(SP_$P(REC,U,3)):$P(REC,U,3)]"" D CSZ1,SET(SP_X)
 Q "~@^TMP(""APGKOB8"","_$J_")"
 ;
CSZ() ;City, state, zip.  S T="a number" in the object method for a left margin
 N REC,SP,X S REC=$G(^DPT(DFN,.11)),$P(SP," ",$G(T)+1)=""
 D CSZ1 Q SP_X
 ;
CSZ1 S X=$P(REC,U,4)_", "
 S X=X_$S($P(REC,U,5):$P(^DIC(5,$P(REC,U,5),0),U),1:"UNK")
 S X=X_"  "_$P(REC,U,6) Q
 ;
PLN() ;Patient's last name
 Q $P(^DPT(DFN,0),",")
 ;
PFNLN() ;Patient's first name _ last name
 Q $P($P(^DPT(DFN,0),U),",",2)_" "_$P(^(0),",")
 ;
DAT(X2) ;Dates X2=number of days from today
 S X1=DT D C^%DTC Q $$D(X)
 ;
K K ^TMP($J),^TMP("APGKOB8",$J) Q
PCE S APGKDFN=$O(^AUPNPAT("B",DFN,0)),T(1)=T,T=$P(T,U,3) D AGO^APGKOB5 Q
NONE(X) S ^TMP("APGKOB8",$J,1,0)=X_" - NONE FOUND" Q
SET(X) S C=C+1,^TMP("APGKOB8",$J,C,0)=X Q
D(Y) D DD^%DT Q Y
