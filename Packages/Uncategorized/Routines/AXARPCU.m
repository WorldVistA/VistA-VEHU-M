AXARPCU ;WPB/JLTP/GBH ; UTILITY BROKER CALLS ; 19-JAN-99
 ;;2.0;WPB Patch Tracking;10-SEP-1998;;Build 2
 ;
GETNAME(AXAY,AXAX) ;
 S REC=$O(^DPT("SSN",AXAX,0))
 I +REC'>0 S AXAY(0)="BAD SSN" Q
 S NAME=$P($G(^DPT(REC,0)),U,1)
 S AXAY(0)=$S($G(NAME)]"":$G(NAME),1:"*")
 Q
 ;
GETFIELD(AXAY,AXAX) ;
 S FILE=$P($G(AXAX),U),FIELD=$P($G(AXAX),U,2),DA=$P($G(AXAX),U,3)
 S FLAG=$P($G(AXAX),U,4)
 I FLAG="" S FLAG="E"
 S DIC=FILE
 S DR=FIELD
 S DIQ="OUT"
 S DIQ(0)=FLAG
 S AXAY="NO DATA"
 D EN^DIQ1
 I $G(OUT(FILE,DA,FIELD,FLAG))]"" D
 .S AXAY=$G(OUT(FILE,DA,FIELD,FLAG))
 Q
 ;
 ;=================== Date/Time Compare ===============================
DTC(R,X) ;
 ; R = Result  YEARS^DAYS^HOURS^MINUTES
 ; X = DATE@TIME1^DATE@TIME2
 N DATE1,DATE2
 S DATE1=$$DTI($P(X,U)),DATE2=$$DTI($P(X,U,2))
 I DATE1<0!(DATE2<0) S R="ERROR" Q
 I DATE1<DATE2 S X=DATE1,DATE1=DATE2,DATE2=X
 S X=$$FMDIFF^XLFDT(DATE1,DATE2,3)
 S R=+$P(X," "),X=$TR($P(X," ",2),":","^"),R=R_U_X
 Q
 ;
 ;================= External Date to Internal =========================
DTI(X) ;
 S %DT="T" D ^%DT
 Q Y
 ;
DTIR(RESULT,X) ;
 S %DT="T" D ^%DT
 S (RESULT,RESULT(0))=Y
 Q
 ;
EXTD(AXAY) ;
 N RESULT
 D NOW^%DTC
 S RESULT=%
 S AXAY=RESULT
 Q
 ;================= Internal Date to External =========================
DTE(AXAY,AXAX) ;
 S Y=AXAX D DD^%DT S AXAY=Y
 Q
 ;==================== ADD x DAYS TO DATE =============================
CDTC(AXAY,AXAX) ;
 N X,X1,X2
 S X=$P($G(AXAX),U,1),X2=$P($G(AXAX),U,2)
 D ^%DT I Y=-1 S AXAY="ERROR" Q
 S X1=Y D C^%DTC
 I X=-1 S AXAY="ERROR" Q
 S AXAY=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q
 ;
 ;==================== Validate Signature =============================
 ;
SIG(AXAY,AXAZ) ;Validate Signature
 S AXAY(1)=0,AXAS=0
 S VALID=$$VALIDATE($$DECRYP^XUSRB1(AXAZ))
 S:VALID=1 AXAY(1)=1
 Q
VALIDATE(X) ;
 D HASH^XUSHSHP I X]"",(X=$P($G(^VA(200,+DUZ,20)),U,4)) S AXAS=1
 Q
 ;
 ;=========== Get Choices from Set of Codes/Pointed to file ============
 ;
 ;   AXAX expects to receive FILE,FIELD.
 ;   AXAY is whatever you want to send back to the GUI form.
 ;
GETLIST(AXAY,AXAX) ;
 S FILE=$P($G(AXAX),U),FIELD=$P($G(AXAX),U,2)
 I $P($G(^DD(FILE,FIELD,0)),U,2)["S" D SET1 Q
 I $P($G(^DD(FILE,FIELD,0)),U,2)["P" D SET3 Q
 Q
SET1 ;-- extract a set of codes --
EN2 N LIST,X S LIST=$G(^DD(FILE,FIELD,0))
 I +$P(LIST,U,2) S FILE=+$P(LIST,U,2),FIELD=.01 G EN2
 S (LIST,LIST2)=$P(LIST,U,3)
 F X=1:1 Q:$P($G(LIST),";",X)']""  S AXAY(X)=$P($G(LIST),";",X)
 Q
SET3 ;-- extract items from pointed-to file --
 S XREF="B",X=0
 I +$P(^DD(FILE,FIELD,0),U,2) S FILE=+$P(^(0),U,2),FIELD=.01 G SET3
 S ROOT="^"_$P($G(^DD(FILE,FIELD,0)),U,3)
 S ITEM="" F  D  Q:$G(ITEM)']""
 .S ITEM=$O(@(ROOT_"XREF,ITEM)")) Q:$G(ITEM)']""
 .S PTR=0 S PTR=$O(@(ROOT_"XREF,ITEM,PTR)"))
 .S X=X+1,AXAY(X)=PTR_":"_ITEM
 .I $P($G(AXAX),U,3)]"" D
 ..S PCE=$P($G(AXAX),U,3)
 ..S ADDED=$P(@(ROOT_"PTR,0)"),U,PCE)
 ..S AXAY(X)=AXAY(X)_":"_ADDED
 Q
 ;
 ;====== Get Data Stored in: Set of Codes / Pointed-to / WP Field =====
 ;
 ;   AXAX expects to receive FILE,FIELD,IEN.
 ;   AXAY is whatever you want to send back to the GUI form.
 ;
GETDATA(AXAY,AXAX) ;
 S FILE=$P($G(AXAX),U),FIELD=$P($G(AXAX),U,2)
 S IEN=$P($G(AXAX),U,3),ROOT=^DIC(FILE,0,"GL")
 S DDPTR=$P($G(^DD(FILE,FIELD,0)),U,2)
 S XREF=$P($G(^DD(FILE,FIELD,0)),U,4)
 S NODE=$P($G(XREF),";"),PIECE=$P($G(XREF),";",2)
 I ($P($G(^DD(FILE,FIELD,0)),U,2)["P")&(PIECE>0) D PTR Q
 I ($P($G(^DD(FILE,FIELD,0)),U,2)["P")&(PIECE=0) D PTRMULT Q
 I ($P($G(^DD(FILE,FIELD,0)),U,2)["S")&(PIECE>0) D SET Q
 I ($P($G(^DD(FILE,FIELD,0)),U,2)["S")&(PIECE=0) D SETMULT Q
 I $D(^DD(DDPTR,.01,0)),$P($G(^DD(DDPTR,.01,0)),U,2)["W" D WPFLD Q
 Q
SET ;
 S CODE=$P(@(ROOT_"IEN,NODE)"),U,PIECE) D SET1 K AXAY
 S A=$P($G(LIST),CODE_":",2),AXAY(1)=CODE_":"_$P($G(A),";")
 Q
SETMULT ;
 D SET1 K AXAY
 S (REC,X)=0 F  D  Q:+REC'>0
 .S REC=$O(@(ROOT_"IEN,NODE,REC)")) Q:+REC'>0
 .S RECORD=@(ROOT_"IEN,NODE,REC,0)")
 .S DATA=RECORD
 .;S DATA=$P($G(RECORD),U,1)
 .S A=$P($G(LIST2),DATA_":",2)
 .S X=X+1
 .S AXAY(X)=$G(DATA)_":"_$P($G(A),";")
 Q
PTR ;
 S PTR=$P(@(ROOT_"IEN,NODE)"),U,PIECE)
 S PROOT="^"_$P($G(^DD(FILE,FIELD,0)),U,3)
 S AXAY(1)=PTR_":"_$P(@(PROOT_"PTR,0)"),U,1)
 Q
PTRMULT ;
 S XROOT=+$P($G(^DD(FILE,FIELD,0)),U,2)
 S PROOT="^"_$P($G(^DD(XROOT,.01,0)),U,3)
 S (REC,X)=0 F  D  Q:+REC'>0
 .S REC=$O(@(ROOT_"IEN,NODE,REC)")) Q:+REC'>0
 .S RECORD=@(ROOT_"IEN,NODE,REC,0)")
 .S DATA=$P($G(RECORD),U,1)
 .S X=X+1,AXAY(X)=$G(DATA)_":"_$P(@(PROOT_"DATA,0)"),U,1)
 Q
 ;
WPFLD ;
 S FILE=$P($G(AXAX),U),FIELD=$P($G(AXAX),U,2),IEN=$P($G(AXAX),U,3)
 S ROOT=^DIC(FILE,0,"GL")
 S NODE=$P($G(^DD(FILE,FIELD,0)),U,4),NODE=$P(NODE,";",1)
WPGET ;
 S DA=0  F  D  Q:+DA'>0
 .S DA=$O(@(ROOT_"IEN,NODE,DA)")) Q:+DA'>0
 .S AXAY(DA)=@(ROOT_"IEN,NODE,DA,0)")
 Q
 ;
 ;============== Resolve Entries Stored as (ie: 2,4-6) ================
 ;
 ;   AXAX expects to receive FILE,FIELD,IEN.
 ;   AXAY is whatever you want to send back to the GUI form.
 ;
CKRANGE(AXAY,AXAX) ;
 S AXAY(1)="*"
 N CODE,LAST,DATA,DAY,Y,X
 S FILE=$P($G(AXAX),U),FIELD=$P($G(AXAX),U,2)
 S IEN=$P($G(AXAX),U,3),ROOT=^DIC(FILE,0,"GL")
 S XREF=$P($G(^DD(FILE,FIELD,0)),U,4)
 S NODE=$P($G(XREF),";"),PIECE=$P($G(XREF),";",2)
 S CODE=$P($G(@(ROOT_"IEN,NODE)")),U,PIECE) Q:$G(CODE)']""
 S LAST=$L(CODE,",")
 F X=1:1:LAST D
 .S DATA=$P($G(CODE),",",X) Q:$G(DATA)']""  D
 .I $G(DATA)'["-" S DAY(DATA)=$G(DATA) Q
 .F Y=$P(DATA,"-",1):1:$P(DATA,"-",2) S DAY(Y)=Y
 S X=0,AXAY(1)="*"
 F  D  Q:+X'>0
 .S X=$O(DAY(X)) Q:+X'>0  S AXAY(1)=AXAY(1)_","_X
 Q
 ;
 ;================= Replace Entries in a Multiple =====================
 ;
 ;   AXAX expects to receive FILE,FIELD,IEN.
 ;   AXAZ expects to receive Replacement DATA (internal code or pointer).
 ;   AXAY is whatever you want to send back to the GUI form.
 ;
REPLMULT(AXAY,AXAX,AXAZ) ;
 D REPLIN,REPLDEL,REPLADD
 Q
REPLIN ;
 S FILE=$P($G(AXAX),U),FIELD=$P($G(AXAX),U,2),DA(1)=$P($G(AXAX),U,3)
 S ROOT=^DIC(FILE,0,"GL")
 S NODE=$P($G(^DD(FILE,FIELD,0)),U,4),NODE=$P(NODE,";",1)
 S SAVEDIK=ROOT_DA(1)_","_$C(34)_NODE_$C(34)_","
 Q
REPLDEL ;
 S DA=0 F  D  Q:+DA'>0
 .S DIK=SAVEDIK,DA=$O(@(ROOT_"DA(1),NODE,DA)")) Q:+DA'>0
 .D ^DIK
 Q
REPLADD ;
 S DIC=SAVEDIK,DIC(0)="LNX"
 S DIC("P")=$P($G(^DD(FILE,FIELD,0)),U,2)
 S AXA=0
 F  D  Q:+AXA'>0
 .S AXA=$O(AXAZ(AXA)) Q:+AXA'>0
 .S X=AXAZ(AXA)
 .K DD,DO D FILE^DICN
 Q
 ;
 ;============ Replace Text in a Word Processing field ===============
 ;
 ;   AXAX expects to receive FILE,FIELD,IEN.
 ;   AXAZ expects to receive Replacement DATA (internal code or pointer).
 ;   AXAY is whatever you want to send back to the GUI form.
 ;
REPLWP(AXAY,AXAX,AXAZ) ;
 ;
 D WPIN,WPDEL,WPADD
 Q
WPIN ;
 S FILE=$P($G(AXAX),U),FIELD=$P($G(AXAX),U,2),IEN=$P($G(AXAX),U,3)
 S ROOT=^DIC(FILE,0,"GL")
 S NODE=$P($G(^DD(FILE,FIELD,0)),U,4),NODE=$P(NODE,";",1)
 Q
WPDEL ;
 K @(ROOT_"IEN,NODE)")
 Q
WPADD ;
 S (AXA,AXAC)=0
 F  D  Q:+AXA'>0
 .S AXA=$O(AXAZ(AXA)) Q:+AXA'>0  S AXAC=AXA
 .S X=$G(AXAZ(AXA))
 .S @(ROOT_"IEN,NODE,AXA,0)")=X
 S @(ROOT_"IEN,NODE,0)")="^^"_AXAC_"^"_AXAC_"^"_DT_"^^"
 Q
 ;
DTFC(RESULTS,INPUT,FLAG) ; reformat date/time
 S FLAG=+$G(FLAG)
 I INPUT="" S (RESULTS,RESULTS(1))="" Q
 S X=INPUT,%DT="T" D ^%DT
 S INPUT=Y,X="NOW"
 D ^%DT
 I $S(INPUT=-1:1,FLAG<0:Y<INPUT,FLAG>0:INPUT>Y,1:0) S INPUT=-1
 I INPUT=-1 S (RESULTS,RESULTS(1))="DATE ERROR" Q
 S (RESULTS,RESULTS(1))=$$FMTE^XLFDT(INPUT,5)
 Q
 ;
DTVALID(RESULTS,IDT,PDT,FLAG) ; Compare Date/Times
 ; Results returns -1 for invalid 1 for valid
 ; IDT is the benchmark Date/Time (time optional) external form
 ; PDT is the proposed Date/Time (time optional) external form
 ; FLAG = -2 means PDT must be <  IDT (The DAY only)
 ; FLAG = -1 means PDT must be <  IDT (The DAY&TIME)
 ; FLAG =  0 means PDT must be =  IDT (The DAY&TIME)
 ; FLAG =  1 means PDT must be >  IDT (The DAY&TIME)
 ; FLAG =  2 means PDT must be > IDT (The DAY only)
 N X,Y
 S FLAG=+$G(FLAG)
 I IDT="" S RESULTS="" Q
 I PDT="" S RESULTS="" Q
 S IDT=$$DTI^AXARPCU(IDT)
 S PDT=$$DTI^AXARPCU(PDT)
 I FLAG=-2 D
 .S IDT=$P(IDT,"."),PDT=$P(PDT,".")
 .I (PDT<IDT)!(PDT=IDT) S RESULTS="VALID DATE" Q
 .I PDT>IDT S RESULTS="DATE ERROR" Q
 I FLAG=-1 D
 .I PDT<IDT S RESULTS="VALID DATE" Q
 .I (PDT>IDT)!(PDT=IDT) S RESULTS="DATE ERROR" Q
 I FLAG=1 D
 .I PDT>IDT S RESULTS="VALID DATE" Q
 .I (PDT<IDT)!(PDT=IDT) S RESULTS="DATE ERROR" Q
 I FLAG=0 D
 .I PDT=IDT S RESULTS="VALID DATE" Q
 .I (PDT<IDT)!(PDT>IDT) S RESULTS="DATE ERROR" Q
 I FLAG=2 D
 .S IDT=$P(IDT,"."),PDT=$P(PDT,".")
 .I (PDT>IDT)!(PDT=IDT) S RESULTS="VALID DATE" Q
 .I PDT<IDT S RESULTS="DATE ERROR" Q
 Q
 ;
REPLFLD(AXAY,AXAX,AXAZ) ;
 N DIE,DA,DATA,DR,Y
 S FILE=$P($G(AXAX),U)
 S DIE=^DIC(FILE,0,"GL")
 S DA=$P($G(AXAX),U,3)
 S DATA=$P($G(AXAZ),U,1)
 S DR=$P($G(AXAX),U,2)_"///^S X="_$C(34)_DATA_$C(34)
 D ^DIE
 S (AXAY,AXAY(0))=$D(Y)
 Q
 ;
PROJ(AXAY) ;
 K AXAY
 S (REC,COUNT)=0
 F  D  Q:+REC'>0
 .S REC=$O(^XWB(8994,REC)) Q:'REC
 .S RECORD=$G(^XWB(8994,REC,0))
 .S NAME=$P($G(RECORD),U,1) Q:$E(NAME,1,3)'="AXA"
 .S TAG=$P($G(RECORD),U,2)
 .S ROUTINE=$P($G(RECORD),U,3)
 .S COUNT=COUNT+1
 .S AXAY(COUNT)=NAME_U_TAG_U_ROUTINE
 Q
 ;
GETPCHS(AXAY,AXAX) ;
 S COUNT=0,REC=+AXAX
 F  D  Q:+REC'>0!(COUNT=500)
 .S REC=$O(^AXA(548261,REC)) Q:+REC'>0!(COUNT=500)
 .S STATUS=$$GET1^DIQ(548261,REC,2.07) Q:STATUS="COMPLETE"
 .S LAST=REC,COUNT=COUNT+1
 .S NODE0=$G(^AXA(548261,REC,0))
 .S NODE1=$G(^AXA(548261,REC,1))
 .S NODE2=$G(^AXA(548261,REC,2))
 .S AXAY(COUNT)=REC_"   "_$G(NODE0)_U_$G(NODE1)_U_$G(NODE2)
 S AXAY(0)=$S(COUNT=500:LAST,1:"DONE")
 Q
 ;
LA7(AXAY,AXAX) ;
 S I=0
 F  S I=$O(AXAX(I)) Q:'I  S BAD(AXAX(I))=""
 S I=0,X=""
 F  S X=$O(BAD(X)) Q:X=""  S I=I+1,AXAY(I)=X
 Q
 ;
LABELS(AXAY,AXAX,AXAZ) ;
 S LINES=$P(AXAX,U,2)
 S (IOP,ZZIOP)="Q;"_$P(AXAX,U),%ZIS="Q" D ^%ZIS
 I POP D  Q
 .S AXAY(1)="ERROR" Q
 S ZTRTN="DQLABS^AXARPCU"
 S ZTSAVE("*")=""
 S ZTDESC="PRINT LAB LABELS"
 S ZTDTH=$H
 D ^%ZTLOAD
 S AXAY(1)="DONE - Queued - Task Number: "_$G(ZTSK)_"."
 D ^%ZISC
 K AXAX,AXAZ
 Q
DQLABS U IO
 Q:'LINES
 F X=1:1:LINES D
 .W AXAZ(X),!
 Q
 ;
ISPROG(AXAY) ;
 K AXAY
 I $D(^XMB(3.8,1461,1,"B",DUZ)) S AXAY="PROG" Q
 I $D(^XMB(3.8,1237,1,"B",DUZ)) S AXAY="CAC" Q
 S AXAY="NOT AUTHORIZED TO USE THIS FORM"
 Q
 ;
REPLSTAT(AXAY,AXAX,AXAZ) ;
 N DIE,DA,DATA,DR,Y
 S FILE=$P($G(AXAX),U)
 S DIE=^DIC(FILE,0,"GL")
 S DA=$P($G(AXAX),U,3)
 S DATA=$P($G(AXAZ),U,1)
 S DR=$P($G(AXAX),U,2)_"///^S X=DATA"  ;................. status
 S DR=DR_";2.08////^S X=$P($G(^VA(200,DUZ,0)),U)" ;...... status by
 I DATA="COMPLETE"!(DATA["IN LIVE") D
 . S DR=DR_";2.03////^S X=DT"  ;......................... date in live
 . S DR=DR_";2.04////^S X=$P($G(^VA(200,DUZ,0)),U)"  ;... in live by
 I DATA["IN TEST" D
 . S DR=DR_";2.01////^S X=DT"  ;......................... date in test
 . S DR=DR_";2.02////^S X=$P($G(^VA(200,DUZ,0)),U)"  ;... in test by
 I DATA["OK" D
 . S DR=DR_";2.05////^S X=DT"  ;......................... date ok
 . S DR=DR_";2.06////^S X=$P($G(^VA(200,DUZ,0)),U)"  ;... ok by
 D ^DIE
 S (AXAY,AXAY(0))=$D(Y)
 Q
 ;
INTDATE(AXAY,AXAX) ;
 S %DT="TS",X=AXAX D ^%DT S AXAY=Y
 Q
