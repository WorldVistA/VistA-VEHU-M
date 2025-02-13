ORY377O ;SLC/AGP - CPRS VERSION 31 QUICK ORDER CONVERSION ;02/07/19  10:59
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**377**;Dec 17, 1997;Build 582
 Q
AUTODC ;
 N DA,DIC,DIE,ERR,EVENT,EVENTS,FDA,IENS,IEN,NAME,NODE,OI,OIS,ORMGR,DR,TEXT,X,Y
 ;get list orderable items
 S NAME="" F  S NAME=$O(^ORD(101.43,"S.DIET",NAME)) Q:NAME=""  I $P(NAME," ")="NPO" D
 .S IEN=0 F  S IEN=$O(^ORD(101.43,"S.DIET",NAME,IEN)) Q:IEN'>0  S OIS(IEN)=NAME
 ; get list of Auto DC rules
 S IEN=0 F  S IEN=$O(^ORD(100.6,IEN)) Q:IEN'>0  D
 .S NODE=$G(^ORD(100.6,IEN,0)) I "OST"'[$P(NODE,U,2) Q
 .S EVENTS(IEN)=$P(NODE,U)
 ;process EVENTS array and update the file
 S IEN=0 F  S IEN=$O(EVENTS(IEN)) Q:IEN'>0  D
 .K DA
 .S EVENT=EVENTS(IEN),DA(1)=IEN
 .K FDA
 .S X=IEN
 .S OI=0 F  S OI=$O(OIS(OI)) Q:OI'>0  D
 ..S NAME=OIS(OI)
 ..I $D(^ORD(100.6,DA(1),8,"B",OI)) Q
 ..S TEXT(1)="  Adding OI "_NAME_" to "
 ..S TEXT(2)="  Auto-DC Rule: "_EVENT
 ..D MES^XPDUTL(.TEXT)
 ..S DIC="^ORD(100.6,"_DA(1)_",8,",X=OI,DIC(0)="L"
 ..L +^ORD(100.6,DA(1)):DILOCKTM
 ..E  D MES^XPDUTL("  Cannot get lock on entry: "_EVENT) Q
 ..S ORMGR=1
 ..D FILE^DICN
 ..I Y=-1 D  Q
 ...L -^ORD(100.6,DA(1))
 ...K TEXT
 ...S TEXT(1)="  Error adding OI "_NAME_" to "
 ...S TEXT(2)="  Auto-DC Rule: "_EVENT
 ...D MES^XPDUTL(.TEXT)
 ..;update lock field
 ..I $P($G(^ORD(100.6,DA(1),8,$P(Y,U),0)),U)=X S $P(^ORD(100.6,DA(1),8,$P(Y,U),0),U,2)=1
 ..L -^ORD(100.6,DA(1))
 Q
 ;
EN ;
 ;I $$PATCH^XPDUTL("OR*3.0*377") Q
 D TASK("PROCESS^ORY377O","Update to Dietetic Quick Orders")
 D TASK("PSOQOUPD^ORY377O","Update to Outpatient Meds Quick Orders")
 D TASK("RADQOUPD^ORY377O","Update to Radiology Quick Orders")
 Q
 ;
TASK(ZTRTN,ZTDESC) ;
 N ZTDTH,ZTSAVE,ZTIO,TEXT,ZTSK
 S TEXT="  "_ZTDESC_" has been queued, task number "
 S ZTIO=""
 S ZTDTH=$$NOW^XLFDT
 D ^%ZTLOAD
 I $D(ZTSK) S TEXT=TEXT_ZTSK D MES^XPDUTL(.TEXT)
 Q
 ;
GETTYPE(TYPE) ;
 N RESULT S RESULT=$S(TYPE="Q":"Quick Order",TYPE="M":"Menu",TYPE="D":"Dialog",TYPE="O":"Order Set",TYPE="A":"Action",1:"")
 Q RESULT
 ;
PROCESS ;
 N ARRAY,CNT,DIALOG,ERRORS,IEN,INPUT,ISTUBE,LIST,NUM,NODE,ORDIEN,PROMPT,PROMPTS,PTR,PTRS,SUB
 K ^XTMP("OR QO DIALOG CONVERSION CPRS 31")
 S ^XTMP("OR QO DIALOG CONVERSION CPRS 31",0)=$$FMADD^XLFDT(DT,30)_U_DT_U_"CPRS 31 Quick Order Conversion"
 S SUB="OR FHW QO"
 K ^TMP($J,SUB)
 S INPUT("FHW1")=""
 S INPUT("FHW OP MEAL")=""
 S INPUT("FHW8")=""
 D FINDQO^ORQOUTL(.ARRAY,.INPUT,SUB,1,1)
 S DIALOG="" F  S DIALOG=$O(INPUT(DIALOG)) Q:DIALOG=""  D
 .S PROMPT=$S(DIALOG="FHW1":"OR GTX STOP DATE/TIME",1:"") I PROMPT="" Q
 .S PTR=$O(^ORD(101.41,"B",PROMPT,"")) Q:PTR'>0
 .S PTRS("STOP")=PTR
 .S PROMPT="OR GTX CANCEL FUTURE ORDERS"
 .S PTR=$O(^ORD(101.41,"B",PROMPT,"")) Q:PTR'>0
 .S PTRS("CANCEL")=PTR
 .S IEN=0 F  S IEN=$O(^TMP($J,SUB,IEN)) Q:IEN'>0  D
 ..S ORDIEN=+$G(^TMP($J,SUB,IEN,"ORDIALOG")) I ORDIEN'>0 Q
 ..S ISTUBE=$S($P($G(^ORD(101.41,ORDIEN,0)),U)="FHW8":1,1:0)
 ..S PTR=$S(ISTUBE=1:PTRS("CANCEL"),ISTUBE=0:PTRS("STOP"),1:"") I PTR'>0 Q
 ..I $G(^TMP($J,SUB,IEN,"ORDIALOG",PTR,1))="" Q
 ..S NUM=+$P($G(^TMP($J,SUB,IEN,"ORDIALOG",PTR)),U)
 ..S NODE=$G(^TMP($J,SUB,IEN))
 ..S LIST($P(NODE,U),IEN)=NODE
 ..K ^TMP($J,"OR DESC")
 ..D EN^ORORDDSC(IEN,"OR DESC")
 ..M ^TMP($J,SUB,IEN,"BEFORE")=^TMP($J,"OR DESC",IEN)
 ..M ^XTMP("OR QO DIALOG CONVERSION CPRS 31",IEN)=^ORD(101.41,IEN)
 ..I $$UPDATE(IEN,PTR,NUM,NODE,.ERRORS)=0 K LIST($P(NODE,U),IEN),^XTMP("OR QO DIALOG CONVERSION CPRS 31",IEN) Q
 ..I ISTUBE=1 S $P(^ORD(101.41,IEN,0),U,8)=0,$P(^ORD(101.41,IEN,5),U,8)=""
 ..K ^TMP($J,"OR DESC")
 ..D EN^ORORDDSC(IEN,"OR DESC")
 ..M ^TMP($J,SUB,IEN,"AFTER")=^TMP($J,"OR DESC",IEN)
 D REPORT(.LIST,.ERRORS,SUB)
 K ^TMP($J,"OR DESC")
 Q
 ;
ORDERM(SUB,IEN,CNT) ;
 N NL,NODE,NOUT,P,SPACER,SPACERI,TEMP,TEXT,TEXTOUT,TYPE,X,Y
 S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)=$$RJ^XLFSTR("Order Menus: ",23)
 S X=0,NL=0 F  S X=$O(^TMP($J,SUB,IEN,"ORDER MENUS",X)) Q:X'>0  D
 .S SPACER="  ",Y=""
 .S NODE=$G(^TMP($J,SUB,IEN,"ORDER MENUS",X)) S TYPE=$P(NODE,U,4)
 .S NL=NL+1,TEXT(NL)=SPACER_TYPE_": "_$P(NODE,U)_"\\"
 .;I NL>1 S NL=NL+1,TEXT(NL)="\\"
 .;S NODE=$G(^TMP($J,SUB,IEN,"ORDER MENUS",X,Y)) S TYPE=$P(NODE,U,5)
 .;F  S Y=$O(^TMP($J,SUB,IEN,"ORDER MENUS",X,Y)) Q:Y=""  D
 .;.S NODE=$G(^TMP($J,SUB,IEN,"ORDER MENUS",X,Y)) S TYPE=$P(NODE,U,5)
 .;.I Y'["." S SPACER=SPACERI
 .;.I Y["." D
 .;..S TEMP="" F P=1:1:$L(Y,".")-1 S TEMP=TEMP_"  "
 .;..S SPACER=SPACERI_TEMP
 .;.S NL=NL+1,TEXT(NL)=SPACER_TYPE_": "_$P(NODE,U,2)_"\\",SPACER=SPACER_"  "
 D FORMAT^PXRMTEXT(23,74,.NL,.TEXT,.NOUT,.TEXTOUT)
 F X=1:1:NOUT S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)=TEXTOUT(X)
 Q
 ;
QO(SUB,IEN,NODE,NAME,CNT) ;
 N I,NL,NOUT,TEXT,TEXTOUT,X
 K TEXT S NL=1,TEXT(NL)="\\",NL=NL+1,TEXT(NL)=$$RJ^XLFSTR("Name: ",23)_NAME_" (IEN: "_IEN_")\\"
 S NL=NL+1,TEXT(NL)=$$RJ^XLFSTR("Display Name: ",23)_$P(NODE,U,2)_"\\"
 S NL=NL+1,TEXT(NL)=$$RJ^XLFSTR("Personal Quick Order: ",23)_$S($G(^TMP($J,SUB,IEN,"ISPERQO"))=1:"Yes",1:"No")_"\\"
 D FORMAT^PXRMTEXT(1,74,.NL,.TEXT,.NOUT,.TEXTOUT)
 F X=1:1:NOUT S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)=TEXTOUT(X)
 I $D(^TMP($J,SUB,IEN,"BEFORE")) D
 .S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="Before:"
 .S I=0 F  S I=$O(^TMP($J,SUB,IEN,"BEFORE",I)) Q:I'>0  D
 ..S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)=^TMP($J,SUB,IEN,"BEFORE",I)
 ;
 I $D(^TMP($J,SUB,IEN,"AFTER")) D
 .S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="After:"
 .S I=0 F  S I=$O(^TMP($J,SUB,IEN,"AFTER",I)) Q:I'>0  D
 ..S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)=^TMP($J,SUB,IEN,"AFTER",I)
 Q
 ;
REMIND(SUB,IEN,CNT) ;
 N NL,NODE,NOUT,SPACER,TEXT,TEXTOUT,TYPE,X,Y
 S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)=$$RJ^XLFSTR("Reminder Dialogs: ",23)
 S X=0,NL=0 F  S X=$O(^TMP($J,SUB,IEN,"REMINDER DIALOGS",X)) Q:X'>0  D
 .I NL>0 S NL=NL+1,TEXT(NL)="\\"
 .S Y=0 F  S Y=$O(^TMP($J,SUB,IEN,"REMINDER DIALOGS",X,Y)) Q:Y'>0  D
 ..S NODE=$G(^TMP($J,SUB,IEN,"REMINDER DIALOGS",X,Y))
 ..S NL=NL+1,TEXT(NL)="  "_NODE_"\\"
 D FORMAT^PXRMTEXT(23,74,.NL,.TEXT,.NOUT,.TEXTOUT)
 F X=1:1:NOUT S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)=TEXTOUT(X)
 Q
 ;
REPORT(LIST,ERRORS,SUB) ;
 K ^TMP("OR MSG",$J),XMY
 N CNT,I,IEN,NAME,NL,NODE,NOUT,TEXT,TEXTOUT,TYPE,SAPCER,X,XMDUZ,XMSUB,XMTEXT,Y
 S CNT=0,XMDUZ="CPRS, SEARCH",XMSUB="DIETETICS QUICK ORDER CONVERSION",XMTEXT="^TMP(""OR MSG"",$J,",XMY(DUZ)="",XMY("G.OR CACS")=""
 S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="The following report lists Dietetics Quick Orders where the expiration date"
 S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="and/or the Cancel Future Tray Order was removed"
 S NAME="" F  S NAME=$O(LIST(NAME)) Q:NAME=""  D
 .S IEN=0 F  S IEN=$O(LIST(NAME,IEN)) Q:IEN'>0  D
 ..S NODE=LIST(NAME,IEN) I '$D(^TMP($J,SUB,IEN)) Q
 ..D QO(SUB,IEN,NODE,NAME,.CNT)
 ..;
 ..I $D(^TMP($J,SUB,IEN,"ORDER MENUS")) D ORDERM(SUB,IEN,.CNT)
 ..;
 ..I $D(^TMP($J,SUB,IEN,"REMINDER DIALOGS")) D REMIND(SUB,IEN,.CNT)
 ..;W !
 ..;S I=0 F  S I=$O(^TMP("OR MSG",$J,I)) Q:I'>0  W !,^TMP("OR MSG",$J,I,0)
 I $D(ERRORS) D
 .S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)=" "
 .S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="The following quick orders had an error."
 .S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="Please inactive and replace the quick order(s) with a new one."
 .S NAME="" F  S NAME=$O(ERRORS(NAME)) Q:NAME=""  D
 ..S IEN=0 F  S IEN=$O(ERRORS(NAME,IEN)) Q:IEN'>0  D
 ...S NODE=ERRORS(NAME,IEN) I '$D(^TMP($J,SUB,IEN)) Q
 ...D QO(SUB,IEN,NODE,NAME,.CNT)
 ...;
 ...I $D(^TMP($J,SUB,IEN,"ORDER MENUS")) D ORDERM(SUB,IEN,.CNT)
 ...;
 ...I $D(^TMP($J,SUB,IEN,"REMINDER DIALOGS")) D REMIND(SUB,IEN,.CNT)
 ;
 I CNT=2 S CNT=CNT+1,^TMP("OR MSG",$J,CNT,0)="None Found"
 D ^XMD
 Q
 ;
UPDATE(IEN,PTR,NUM,NODE,ERRORS) ;
 N ERR,FDA,ID,IENS
 S ID=$O(^ORD(101.41,IEN,6,"D",PTR,"")) Q:ID'>0
 S IENS=ID_","_IEN_","
 S FDA(101.416,IENS,.01)=NUM
 S FDA(101.416,IENS,.02)=PTR
 S FDA(101.416,IENS,.03)=1
 S FDA(101.416,IENS,1)=""
 D FILE^DIE("","FDA","ERR")
 I $D(ERR) S ERRORS($P(NODE,U),IEN)=NODE Q 0
 Q 1
 ;
SETDG ;
 N DA,DIC,ORDG,X,DLAYGO,Y,DTOUT,DUOUT
 S ORDG=$O(^ORD(100.98,"B","ALL SERVICES",0)) Q:'ORDG
 S X=$O(^ORD(100.98,"B","CLINIC SCHEDULING",0)),DA(1)=ORDG I 'X D MES^XPDUTL("  'Clinic Scheduling' display group not found") Q
 I $O(^ORD(100.98,DA(1),1,"B",X,0)) D MES^XPDUTL("  Display group already attached")  Q  ;not first install - done.
 S:'$D(^ORD(100.98,DA(1),1,0)) ^(0)="^100.981P^^"
 S DIC="^ORD(100.98,"_DA(1)_",1,",DIC(0)="NLX",DLAYGO=100.98
 S X="CLINIC SCHEDULING" D ^DIC
 Q
 ;
SETPAR ;
 N X
 I '$D(^ORD(100.98,"B","CLINIC SCHEDULING")) D MES^XPDUTL("  Display group already attached") Q
 S X=0,X=$O(^ORD(100.98,"B","CLINIC SCHEDULING",X)) Q:'X  D
 . D PUT^XPAR("PKG","ORWOR CATEGORY SEQUENCE",135,X)
 ;update scheduling offset parameter
 D PUT^XPAR("SYS","OR SD CIDC STOP OFFSET",1,30)
 Q
 ;
PSOQOUPD ;Clean up any Conjunction entries in Outpatient Med Quick Orders that are set to "X" for Except
 ;
 ; ZEXCEPT: ZTREQ
 N ORARRAY,ORINPUT,ORIEN,ORIEN2,ORNAME,ORPROMPT,ORSUB
 ;
 S ZTREQ="@"
 S ORSUB="OR PSOQOUPD"
 K ^TMP($J,ORSUB)
 I '$D(^XTMP("OR OUTPATIENT MED QO CPRS 31")) D
 . S $P(^XTMP("OR OUTPATIENT MED QO CPRS 31",0),U,2)=$$NOW^XLFDT
 S $P(^XTMP("OR OUTPATIENT MED QO CPRS 31",0),U,1)=$$FMADD^XLFDT($$NOW^XLFDT,90)
 ;
 S ORPROMPT=$O(^ORD(101.41,"B","OR GTX AND/THEN",""))
 I ORPROMPT'>0 Q
 ;
 S ORINPUT("PSO OERR")=""
 D FINDQO^ORQOUTL(.ORARRAY,.ORINPUT,ORSUB,1,1)
 ;
 S ORIEN=""
 F  S ORIEN=$O(^TMP($J,ORSUB,ORIEN)) Q:'ORIEN  D
 . I '$D(^ORD(101.41,ORIEN)) Q
 . I '$D(^TMP($J,ORSUB,ORIEN,"ORDIALOG",ORPROMPT)) Q
 . ;
 . S ORIEN2=0
 . F  S ORIEN2=$O(^ORD(101.41,ORIEN,6,"D",ORPROMPT,ORIEN2)) Q:'ORIEN2  D
 . . I $G(^ORD(101.41,ORIEN,6,ORIEN2,1))'="X" Q
 . . ;
 . . S ORNAME=$P($G(^ORD(101.41,ORIEN,0)),U,1)
 . . I ORNAME="" Q
 . . S ^TMP($J,ORSUB,"B",ORNAME,ORIEN)=""
 . . ;
 . . ; Before QO Capture
 . . I '$D(^TMP($J,ORSUB,ORIEN,"BEFORE")) D
 . . . K ^TMP($J,"OR DESC")
 . . . D EN^ORORDDSC(ORIEN,"OR DESC")
 . . . M ^TMP($J,ORSUB,ORIEN,"BEFORE")=^TMP($J,"OR DESC",ORIEN)
 . . ;
 . . ; Backup QO to XTMP
 . . I '$D(^XTMP("OR OUTPATIENT MED QO CPRS 31",ORIEN)) D
 . . . M ^XTMP("OR OUTPATIENT MED QO CPRS 31",ORIEN)=^ORD(101.41,ORIEN)
 . . ;
 . . ; Remove Except conjunction
 . . S ^ORD(101.41,ORIEN,6,ORIEN2,1)=""
 . . ;
 . . ; After QO Capture
 . . K ^TMP($J,"OR DESC")
 . . D EN^ORORDDSC(ORIEN,"OR DESC")
 . . M ^TMP($J,ORSUB,ORIEN,"AFTER")=^TMP($J,"OR DESC",ORIEN)
 ;
 ; Email report
 D PSOQORPT(ORSUB)
 ;
 K ^TMP($J,"OR DESC")
 K ^TMP($J,ORSUB)
 ;
 Q
 ;
RADQOUPD ; Update Radiology quick orders
 N SUB,ARRAY,INPUT,ORPROMPT,IEN,IDX,VAL
 S ORPROMPT=$O(^ORD(101.41,"B","OR GTX URGENCY",""))
 I ORPROMPT'>0 Q
 S SUB="OR RADQOUPD"
 K ^TMP($J,SUB)
 S INPUT("RA OERR EXAM")=""
 D FINDQO^ORQOUTL(.ARRAY,.INPUT,SUB,0,0)
 S IEN=0 F  S IEN=$O(^TMP($J,SUB,IEN)) Q:IEN'>0  D
 . S IDX=0 F  S IDX=$O(^ORD(101.41,IEN,6,IDX)) Q:IDX'>0  D
 . . I $P($G(^ORD(101.41,IEN,6,IDX,0)),U,2)'=ORPROMPT Q
 . . S VAL=$G(^ORD(101.41,IEN,6,IDX,1))
 . . I "^1^2^9^"[(U_VAL_U) Q  ; Valid Urgencies
 . . S ^ORD(101.41,IEN,6,IDX,1)=9 ; Set to Routine Urgency
 K ^TMP($J,SUB)
 Q
 ;
PSOQORPT(ORSUB) ;Send a mailman message of updated Outpatient Med QOs
 ;
 N ORCNT,ORIEN,ORNAME,ORNODE,XMDUZ,XMSUB,XMTEXT,XMY,XMMG
 ;
 K ^TMP("OR MSG",$J)
 S ORCNT=0
 ;
 S ORCNT=ORCNT+1,^TMP("OR MSG",$J,ORCNT,0)="The following report lists Outpatient Medication Quick Orders where the "
 S ORCNT=ORCNT+1,^TMP("OR MSG",$J,ORCNT,0)="conjunction was set to EXCEPT. These Quick Orders have had the and/then "
 S ORCNT=ORCNT+1,^TMP("OR MSG",$J,ORCNT,0)="prompt cleared of this value."
 S ORCNT=ORCNT+1,^TMP("OR MSG",$J,ORCNT,0)=""
 ;
 S ORNAME=""
 F  S ORNAME=$O(^TMP($J,ORSUB,"B",ORNAME)) Q:ORNAME=""  D
 . S ORIEN=0
 . F  S ORIEN=$O(^TMP($J,ORSUB,"B",ORNAME,ORIEN)) Q:ORIEN'>0  D
 . . I '$D(^TMP($J,ORSUB,ORIEN)) Q
 . . S ORNODE=$G(^TMP($J,ORSUB,ORIEN))
 . . D QO(ORSUB,ORIEN,ORNODE,ORNAME,.ORCNT)
 . . ;
 . . I $D(^TMP($J,ORSUB,ORIEN,"ORDER MENUS")) D ORDERM(ORSUB,ORIEN,.ORCNT)
 . . ;
 . . I $D(^TMP($J,ORSUB,ORIEN,"REMINDER DIALOGS")) D REMIND(ORSUB,ORIEN,.ORCNT)
 ;
 I ORCNT=4 D
 . S ORCNT=ORCNT+1,^TMP("OR MSG",$J,ORCNT,0)="None Found"
 ;
 S XMDUZ="CPRS, SEARCH"
 S XMSUB="OUTPATIENT MED QUICK ORDER CONVERSION"
 S XMTEXT="^TMP(""OR MSG"",$J,"
 S XMY(DUZ)=""
 S XMY("G.OR CACS")=""
 D ^XMD
 ;
 Q
