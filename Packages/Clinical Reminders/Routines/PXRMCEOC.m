PXRMCEOC ;SLC/AGP - Computed findings for WH project ;06/27/2018
 ;;2.0;CLINICAL REMINDERS;**45**;Feb 4, 2005;Build 566
 ;
EPISODE(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;
 ;
 N DIR,DTE,IEN,NAME,OPENONLY
 S NFOUND=0
 S NAME=$P(TEST,":"),OPENONLY=$S($P(TEST,":",2)="OPEN":1,1:0)
 I NAME="" Q
 I '$D(^PXRM(809,"C",DFN,NAME)) Q
 I OPENONLY D  Q
 .S IEN=+$O(^PXRM(809,"OPEN",DFN,NAME,"")) I IEN'>0 Q
 .S NFOUND=1,TEST(NFOUND)=1 D GETDATA(DFN,IEN,1,.DATE,.DATA,.TEXT)
 S DTE=0 F  S DTE=$O(^PXRM(809,"C",DFN,NAME,DTE)) Q:DTE'>0!(NFOUND=NGET)  D
 .I BDT>0,DTE<BDT Q
 .I EDT>0,DTE>EDT Q
 .S IEN=0 F  S IEN=$O(^PXRM(809,"C",DFN,NAME,DTE,IEN)) Q:IEN'>0!(NFOUND=NGET)  D
 ..S NFOUND=NFOUND+1,TEST(NFOUND)=1 D GETDATA(DFN,IEN,NFOUND,.DATE,.DATA,.TEXT)
 Q
 ;
GETDATA(DFN,IEN,INC,DATE,DATA,TEXT) ;
 N ARRAY,EDATE,LDATE,ITEM,NAME,NODE,STATUS,TCNT,X
 S NODE=^PXRM(809,IEN,0)
 S DATE(INC)=$P(NODE,U)
 S NAME=$P(NODE,U,2)
 S STATUS=$S($P(NODE,U,4)="O":"Open",$P(NODE,U,4)="C":"Closed",1:"Unknown")
 S DATA(INC,"STATUS")=STATUS
 S DATA(INC,"NAME")=NAME
 S DATA(INC,"DIALOG")=1
 S TCNT=0
 S TCNT=TCNT+1,TEXT(INC,TCNT)="Cascade: "_NAME
 S TCNT=TCNT+1,TEXT(INC,TCNT)="Started on: "_$$FMTE^XLFDT(DATE(INC))
 S TCNT=TCNT+1,TEXT(INC,TCNT)="Status: "_STATUS
 ;build array of items by dates
 S X=0 F  S X=$O(^PXRM(809,IEN,1,X)) Q:X'>0  D
 .S NODE=^PXRM(809,IEN,1,X,0)
 .S ARRAY($P(NODE,U),$P(NODE,U,2))=NODE
 ;re-loop
 S X=0 F  S X=$O(^PXRM(809,IEN,1,X)) Q:X'>0  D
 .S NODE=^PXRM(809,IEN,1,X,0)
 .S ITEM=$P(NODE,U),EDATE=$P(NODE,U,2),LDATE=$P(NODE,U,5)
 .I ITEM["OR(100" D GETOR(DFN,ITEM,EDATE,LDATE,INC,.TEXT,.TCNT)
 .I ITEM["WV(790.1" D GETWVP(DFN,ITEM,EDATE,LDATE,INC,.TEXT,.TCNT)
 .K ARRAY(ITEM,EDATE)
 S TCNT=TCNT+1,TEXT(INC,TCNT)="----------------------------------------------------------"
 Q
 ;
GETOR(DFN,ITEM,DATE,LDATE,INC,TEXT,TCNT) ;
 N I,ORIGVIEW,PXRMTEMP,STATUS
 S ORIGVIEW=3
 S TCNT=TCNT+1,TEXT(INC,TCNT)=""
 D TEXT^ORQ12(.PXRMTEMP,+ITEM,80)
 S STATUS=$$GETSTAT^ORQ12(+ITEM)
 S TCNT=TCNT+1,TEXT(INC,TCNT)=PXRMTEMP(1)_" ordered on "_$$FMTE^XLFDT(DATE)_" status: "_STATUS
 S I=1 F  S I=$O(PXRMTEMP(I)) Q:I'>0  D
 .S TCNT=TCNT+1,TEXT(INC,TCNT)=PXRMTEMP(I)
 Q
 ;
GETWVP(DFN,ITEM,DATE,LDATE,INC,TEXT,TCNT) ;
 N ACCESS,CNT,ID,NODE,TEMP,X
 S TCNT=TCNT+1,TEXT(INC,TCNT)=""
 I DATE>0 S TCNT=TCNT+1,TEXT(INC,TCNT)="Procedure added on "_$$FMTE^XLFDT(DATE)_" last updated: "_$$FMTE^XLFDT(LDATE)
 D GETWVP^WVRPCGF1(DFN,ITEM,.TEMP)
 S CNT=0 F  S CNT=$O(TEMP(CNT)) Q:CNT'>0  S TCNT=TCNT+1,TEXT(INC,TCNT)=TEMP(CNT)
 S TCNT=TCNT+1,TEXT(INC,TCNT)="----------------------------------------------------------"
 Q
 ;
OBJ(SUB,DFN,NAME) ;
 K ^TMP(SUB,$J)
 N DATA,DATE,IEN,I,TEXT
 S IEN=+$O(^PXRM(809,"OPEN",DFN,NAME,""))
 I IEN'>0 S DATE="A" F  S DATE=$O(^PXRM(809,"C",DFN,NAME,DATE),-1) D  Q:DATE=""!(IEN>0)
 .I DATE="" Q
 .S IEN=$O(^PXRM(809,"C",DFN,NAME,DATE,""))
 I IEN'>0 S ^TMP(SUB,$J,1,0)="No Cascade found" G OBJX
 D GETDATA(DFN,IEN,1,.DATE,.DATA,.TEXT)
 I '$D(TEXT(1)) S ^TMP(SUB,$J,1,0)="No Open Cascade found" G OBJX
 S I=0 F  S I=$O(TEXT(1,I)) Q:I'>0  S ^TMP(SUB,$J,I,0)=TEXT(1,I)
OBJX ;
 Q "~@"_$NA(^TMP(SUB,$J))
 ;
