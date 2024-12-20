VEJDWPBU ;WPB/CAM routine modified for dental GUI;8/1/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;; SLC/MKB - Order Dialog utilities ;6/30/97  10:19
 ;ORCD;3.0;ORDER ENTRY/RESULTS REPORTING;**8**;Dec 17, 1997
INPT() ; -- Return 1 or 0, if patient/order sheet = inpatient
 I $L($G(OREVENT)) Q $S(OREVENT="A":1,OREVENT="T":1,OREVENT="D":0,OREVENT="V":0,1:$G(ORWARD))
 Q $G(ORWARD)
 ;
EXT(P,I,F) ; -- Returns external value of ORDIALOG(Prompt,Instance)
 N TYPE,PARAM,FNUM,IENS,X,Y,J,Z
 S TYPE=$E(ORDIALOG(P,0)),PARAM=$P(ORDIALOG(P,0),U,2),X=ORDIALOG(P,I)
 I "FNW"[TYPE Q X
 I TYPE="Y" Q $S(X:"YES",X=0:"NO",1:"")
 I TYPE="D" S:'$L($G(F)) F=1 Q $$FMTE^XLFDT(X,F)
 I TYPE="R" Q $$FTDATE(X,$G(F)) ; DAY@TIME
 I TYPE="P" D  Q Y
 . S PARAM=$P(PARAM,":"),FNUM=$S(PARAM:+PARAM,1:+$P(@(U_PARAM_"0)"),U,2))
 . S IENS=+X_",",J=$L(PARAM,",") I J>2 F  S J=J-2 Q:J'>0  S Z=$P(PARAM,",",J),IENS=IENS_$S(Z:Z,1:+$P(Z,"(",2))_","
 . S:'+$G(F) F=.01 S Y=$$GET1^DIQ(FNUM,IENS,+F)
 I TYPE="S" F J=1:1:$L(PARAM,";") S Z=$P(PARAM,";",J) I $P(Z,":")=X S Y=$S(+$G(F):X,1:$P(Z,":",2)) Q
 Q $G(Y)
 ;
FTDATE(X,F) ; -- Returns free text form of date (i.e. TODAY)
 N D,T,P,Y I X="" Q ""
 S X=$$UP^XLFSTR(X),D=$P(X,"@"),T=$P(X,"@",2) ; D=date,T=time parts
 I "NOW"[X Q "NOW"
 I "NOON"[X Q "NOON"
 I $E("MIDNIGHT",1,$L(X))=X Q "MIDNIGHT"
 I (X="AM")!(X="NEXT") Q X_" Lab collection"
 I $E(D)'="T",$E(D)'="V" D  Q $$FMTE^XLFDT(X,F)
 . N %DT S %DT="TX" D ^%DT S:Y>0 X=Y S:'$G(F) F=1
 S P=$S(D["+":"+",D["-":"-",1:"")
 I P="" S Y=$S($E(D)="T":"TODAY",1:"NEXT VISIT") ; no offset
FTD1 E  D
 . N OFFSET,NUM,UNIT
 . S OFFSET=$P(D,P,2),NUM=+OFFSET,UNIT=$E($P(OFFSET,NUM,2)) ; +/-#D
 . I $E(D)="T",NUM=1 S Y=$S(P="+":"TOMORROW",1:"YESTERDAY") Q
 . S Y=NUM_" "_$S(UNIT="W":"WEEK",UNIT="M":"MONTH",1:"DAY")
 . S:NUM>1 Y=Y_"S" ; plural
 . S:$E(D)="T" Y=Y_" "_$S(P="+":"FROM TODAY",1:"AGO")
 . S:$E(D)="V" Y=Y_" "_$S(P="+":"AFTER",1:"BEFORE")_" NEXT VISIT"
 I $L(T) S Y=Y_"@"_$$TIME(T)
 Q Y
 ;
FTDHELP ; -- Displays ??-help for R-type prompts
 W !!,"Examples of Valid Dates:"
 W !,"  JAN 20 1957 or 20 JAN 57 or 1/20/57 or 012057"
 W !,"  T   (for TODAY)   T+1 (for TOMORROW)   T+2   T+7   etc."
 W !,"  T-1 (for YESTERDAY)   T-3W (for 3 WEEKS AGO) etc."
 ;W !,"  V   (for the NEXT VISIT)   V-1 (for DAY BEFORE NEXT VISIT) etc."
 W !,"If the year is omitted, the current year is assumed."
 I DOMAIN'["R",DOMAIN'["T" W !,"Time may not be entered." Q
 W !,"The date "_$S(DOMAIN["R":"must",1:"may")_" be followed by a time, such as JAN 20@10, T@10AM, etc."
 W !,"You may also enter a time such as NOON, MIDNIGHT, or NOW."
 Q
 ;
FTDCOMP(X1,X2,OPER) ; -- Compares free text dates from prompts X1 & X2
 ;    Returns 1 or 0, IF $$VAL(X1)<OPER>$$VAL(X2) is true
 N X,Y,Y1,Y2,Z,%DT
 S X=$$VAL(X1),%DT="FTX" D ^%DT S Y1=Y ; Y'>0 ??
 S X=$$VAL(X2),%DT="FTX" D ^%DT S Y2=Y ; Y'>0 ??
 S Z="I "_Y1_OPER_Y2 X Z
 Q $T
 ;
TIME(X) ; -- Returns 00:00 PM formatted time
 N Y,Z,%DT
 I "NOON"[X Q X
 I "MIDNIGHT"[X Q "MIDNIGHT"
 S X="T@"_X,%DT="TX" D ^%DT I Y'>0 Q ""
 S Z=$$FMTE^XLFDT(Y,"2P"),Z=$P(Z," ",2)_$$UP^XLFSTR($P(Z," ",3))
 Q Z
 ;
VAL(TEXT,INST) ; -- Returns internal form of TEXT's current value
 N I,X S X="" S:'$G(INST) INST=1
 I '$D(ORDIALOG("B",TEXT)) S I=$O(ORDIALOG("B",TEXT)) Q:$E(I,1,$L(TEXT))'=TEXT X S TEXT=I ; partial match
 S X=$P($G(ORDIALOG("B",TEXT)),U,2) ; ptr
 Q $G(ORDIALOG(X,INST))
 ;
ORDMSG(OI) ; -- Display order message for orderable OI
 Q:'$O(^VEJ(101.43,OI,8,0))  ; no order message
 N I S I=0 W !
 F  S I=$O(^VEJ(101.43,OI,8,I)) Q:I'>0  W !,$G(^(I,0))
 W ! Q
 ;
PTR(NAME) ; -- Returns pointer to Dialog file for prompt NAME
 Q $O(^VEJ(101.41,"AB",$E(NAME,1,63),0))
 ;
NMSP(PKG) ; -- Returns package namespace from pointer
 N Y S Y=$$GET1^DIQ(9.4,+PKG_",",1)
 S:$E(Y,1,2)="PS" Y="PS" S:Y="GMRV" Y="OR"
 Q Y
 ;
GETQDLG(QIFN) ; -- define ORDIALOG(PROMPT) for quick order QIFN
 S ORDIALOG=$$DEFDLG(QIFN) Q:'ORDIALOG
 D GETDLG(ORDIALOG),GETORDER("^VEJ(101.41,"_QIFN_",6)")
 X:$D(^VEJ(101.41,QIFN,3)) ^(3) ; entry action for quick order
 Q
 ;
DEFDLG(QDLG) ; -- Returns default dialog for QDLG
 N DG,DLG,TOP S DG=+$P($G(^VEJ(101.41,+QDLG,0)),U,5)
 S DLG=+$P($G(^ORD(100.98,DG,0)),U,4) ; default dialog
 I 'DLG S TOP=+$O(^ORD(100.98,"AD",DG,0)),DLG=+$P($G(^ORD(100.98,TOP,0)),U,4)
 Q DLG
 ;
GETDLG(IFN) ; -- define ORDIALOG(PROMPT) for dialog IFN
 N SEQ,DA,ITEM,PTR,PROMPT,TEXT,INDEX,HELP,XHELP,SCREEN,ORD,INPUTXFM,LKP
 S SEQ=0 K ^TMP("ORWORD",$J)
 F  S SEQ=$O(^VEJ(101.41,IFN,10,"B",SEQ)) Q:SEQ'>0  S DA=0 F  S DA=$O(^VEJ(101.41,IFN,10,"B",SEQ,DA)) Q:'DA  D
 . S ITEM=$G(^VEJ(101.41,IFN,10,DA,0)),INPUTXFM=$G(^(.1)),HELP=$G(^(1)),SCREEN=$G(^(4)),XHELP=$G(^(6))
 . S PTR=$P(ITEM,U,2),TEXT=$P(ITEM,U,4),INDEX=$P(ITEM,U,10) Q:'PTR
 . S:'$L(TEXT) TEXT=$P(^VEJ(101.41,PTR,0),U,2) K ORD
 . S PROMPT=$G(^VEJ(101.41,PTR,1)),ORD=DA_U_$P(PROMPT,U,3)
 . S ORD(0)=$P(PROMPT,U)_$S($P(PROMPT,U)="S":"M",1:"")_U_$P(PROMPT,U,2)_$S($L(INPUTXFM):U_INPUTXFM,1:"")
 . S ORD("A")=TEXT S:$L($P(ITEM,U,13)) ORD("TTL")=$P(ITEM,U,13)
 . I $P(ITEM,U,7) S ORD("MAX")=$P(ITEM,U,12),ORD("MORE")=$P(ITEM,U,14) ; fields for multiples
 . I $L(HELP) S LKP=$P(HELP,U,2),HELP=$P(HELP,U) S:$L(HELP) ORD("?")=HELP S:$L(LKP) ORD("LKP")=$S($L(LKP,";")>1:$TR(LKP,";","^"),1:U_LKP)
 . S:$L(XHELP) ORD("??")=U_XHELP
 . S:$L(INDEX) ORD("D")=INDEX
 . S:$L(SCREEN) ORD("S")=SCREEN
 . S ORDIALOG("B",$$UP^XLFSTR($P(TEXT,":")))=SEQ_U_PTR
 . M ORDIALOG(PTR)=ORD
 Q
 ;
GETDLG1(IFN) ; -- basic ORDIALOG(PROMPT) for dialog IFN
 N SEQ,DA,PROMPT,PTR,WINCTRL
 K ^TMP("ORWORD",$J) S SEQ=0
 F  S SEQ=$O(^VEJ(101.41,IFN,10,"B",SEQ)) Q:SEQ'>0  S DA=0 F  S DA=$O(^VEJ(101.41,IFN,10,"B",SEQ,DA)) Q:'DA  D
 . S PTR=$P($G(^VEJ(101.41,IFN,10,DA,0)),U,2) Q:'PTR
 . S WINCTRL=$P($G(^VEJ(101.41,IFN,10,DA,"W")),U)
 . S PROMPT=$G(^VEJ(101.41,PTR,1)) Q:'$L(PROMPT)
 . S ORDIALOG(PTR)=DA_U_$P(PROMPT,U,3)_U_WINCTRL
 . S ORDIALOG(PTR,0)=$P(PROMPT,U,1,2)
 Q
 ;
GETORDER(ROOT,ARRAY) ; -- retrieve order values from RESPONSES in ARRAY()
 N I,ID,PTR,INST,TYPE,DA,X S:'$L($G(ARRAY)) ARRAY="ORDIALOG"
 I +ROOT=ROOT S ROOT="^OR(100,"_ROOT_",4.5)" ; assume Orders file IFN
 S I=0 F  S I=$O(@ROOT@(I)) Q:I'>0  S ID=$G(@ROOT@(I,0)) D
 . S DA=$P(ID,U),PTR=$P(ID,U,2),INST=$P(ID,U,3) S:'INST INST=1
 . S:'PTR PTR=$P(^VEJ(101.41,+ORDIALOG,10,DA,0),U,2) Q:'PTR
 . Q:'$D(ORDIALOG(PTR))  S TYPE=$E($G(ORDIALOG(PTR,0))) Q:'$L(TYPE)
 . I TYPE'="W" S X=$G(@ROOT@(I,1)) S:$L(X) @ARRAY@(PTR,INST)=X
 . I TYPE="W",ARRAY="ORDIALOG" M ^TMP("ORWORD",$J,PTR,INST)=@ROOT@(I,2) S @ARRAY@(PTR,INST)="^TMP(""ORWORD"","_$J_","_PTR_","_INST_")"
 . I TYPE="W",ARRAY'="ORDIALOG" M @ARRAY@(PTR,INST)=@ROOT@(I,2) S @ARRAY@(PTR,INST)=$NA(@ARRAY@(PTR,INST))
 Q
 ;
DUP(PROMPT,CURRENT) ; -- Compare CURRENT instance of PROMPT for duplicates
 N X,Y,I
 S X=ORDIALOG(PROMPT,CURRENT),Y=0
 S I=0 F  S I=$O(ORDIALOG(PROMPT,I)) Q:I'>0  I I'=CURRENT,$P(ORDIALOG(PROMPT,I),U)=$P(ORDIALOG(PROMPT,CURRENT),U) S Y=1 Q
 Q Y
 ;
LIST ; -- Show contents of ORDIALOG(PROMPT,"LIST")
 N NUM S NUM=$G(ORDIALOG(PROMPT,"LIST")) Q:'NUM
 W !,"Choose from"_$S('$P(NUM,U,2):" (or enter another):",1:":")
LIST1 N I,DONE,CNT S (I,CNT,DONE)=0
 F  S I=$O(ORDIALOG(PROMPT,"LIST",I)) Q:I'>0  D  Q:DONE
 . S CNT=CNT+1 I CNT>(IOSL-2) S CNT=0 I '$$MORE S DONE=1 Q
 . W !,$J(I,5)_" "_$P(ORDIALOG(PROMPT,"LIST",I),U,2)
 Q
 ;
SETLIST ; -- Show allowable set of codes
 W !,"Choose from:"
SETLST1 N I,X F I=1:1:$L(DOMAIN,";") S X=$P(DOMAIN,";",I) I $L(X) D
 . W !,?5,$P(X,":"),?15,$P(X,":",2)
 Q
 ;
MORE() ; -- show more?
 N X,Y,DIR
 S DIR(0)="EA",DIR("A")="    press <return> to continue or ^ to exit ..."
 D ^DIR
 Q +Y
 ;
FIRST(P,I) ; -- Returns 1 or 0, if current instance I is first of multiple
 Q '$O(ORDIALOG(P,I),-1)
 ;
RECALL(P,I) ; -- Returns first value for prompt P, instance I
 N Y S:'$G(I) I=1 S Y=$G(^TMP("ORECALL",$J,+ORDIALOG,P,I))
 Q Y
