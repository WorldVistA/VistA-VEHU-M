ECXFMTR  ;ORL/NJW - MAS MOVEMENT TYPE REPORT ; Apr 08, 2024@15:13:43
 ;;3.0;DSS EXTRACTS;**190**;Dec 22, 1997;Build 36
 ;
 ;
 ;Loop through 405.2, pull fields and display
 ;Current fields
 ;  405.2/.001 - Entry Number
 ;  405.2/.01  - Name
 ;  405.2/.02  - Transaction Type
 ;  405.1/.04  - Active
DSSFILE ; Pull the data from the files
 N CODE,CNT,DESC,ECXPORT,ENTRY,FIELD,FFILE,INDEX,LIST,MFILE,NAME,TFILE,TXN
 ;
 D CLEANUP
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I $G(ECXPORT) D  Q
 . K ^TMP($J,"ECXPORT")
 . S ^TMP($J,"ECXPORT",0)="IEN^NAME^TRANSACTION TYPE",CNT=0
 . D BUILD
 . D PRINT
 . D EXPDISP^ECXUTL1
 . D CLEANUP
 . K ^TMP($J,"ECXPORT")
 ;
 ;Queue Report
 N X,ZTDESC,ZTIO,ZTSAVE
 F X="SDATE","EDATE","ECRUN","STOP" S ZTSAVE(X)=""
 S ZTIO=""
 S ZTDESC="DSS MAS Movement Type List Report"
 D EN^XUTMDEVQ("EN1^ECXFMTR",ZTDESC,.ZTSAVE)
 Q
 ;
EN1 ; Report proper
 D BUILD
 ;
 D PRINT
 ;
 D CLEANUP
 Q
 ;
CLEANUP ; Cleanup TMP
 K ^TMP($J,"FACILITY LIST")
 K ^TMP($J,"MAS MOVEMENT TYPE")
 Q
 ;
ACTIVE ;Build Active List Linking 405.1 and 405.2
 ;S ^TMP($J,"MAS MOVEMENT TYPE",MAS)=ACTIVE
 ;
 N ACTIVE,MAS
 ;
 S INDEX=""
 F  S INDEX=$O(^DG(FFILE,"B",INDEX)) Q:INDEX=""  D
 . S ENTRY=""
 . F  S ENTRY=$O(^DG(FFILE,"B",INDEX,ENTRY)) Q:ENTRY=""  D
 . . ;Field - Active
 . . S FIELD=.04
 . . S ACTIVE=$$GET1^DIQ(FFILE,ENTRY,FIELD)
 . . ;
 . . ;Field - MAS Movement Type - Lookup to 405.2
 . . S FIELD=.03
 . . S MAS=$$GET1^DIQ(FFILE,ENTRY,FIELD,"I")   ;Get MAS internal
 . . ;
 . . I MAS'="" S ^TMP($J,"MAS MOVEMENT TYPE",MAS)=ACTIVE
 Q
BUILD ; Build Report
 S FFILE=405.1  ;FACILITY MOVEMENT TYPE
 S MFILE=405.2  ;MAS MOVEMENT TYPE
 S TFILE=405.3  ;MAS MOVEMENT TRANSACTION TYPE
 ;
 ;D ACTIVE
 ;
 S INDEX=""
 F  S INDEX=$O(^DG(MFILE,"B",INDEX)) Q:INDEX=""  D
 . S ENTRY=""
 . F  S ENTRY=$O(^DG(MFILE,"B",INDEX,ENTRY)) Q:ENTRY=""  D
 . . ;Field - ENTRY NUMBER
 . . S FIELD=.001
 . . S CODE=$$GET1^DIQ(MFILE,ENTRY,FIELD)
 . . ;
 . . ;Field - Name
 . . S FIELD=.01
 . . S NAME=$$GET1^DIQ(MFILE,ENTRY,FIELD)
 . . ;
 . . ;Field - Transaction Type - Lookup to 405.3 = field .01 (30)
 . . ;DA is the ENTRY in 405.3
 . . S FIELD=.02
 . . S TXN=$$GET1^DIQ(MFILE,ENTRY,FIELD,"I")       ;Get TXN internal
 . . S FIELD=.01
 . . I TXN'="" S TXN=$$GET1^DIQ(TFILE,TXN,FIELD)   ;TXN File lookup
 . . ;
 . . I CODE'="" S ^TMP($J,"FACILITY LIST",CODE,ENTRY)=NAME_"^"_TXN
 Q
 ;
PRINT ; Loop throught the list and display
 N CODE,DATA,ECXTMP,ENTRY,I,LN,OK,PAGE
 S PAGE=1
 S OK=1
 S $P(LN,"-",81)=""  ;80 Character Line --- Can change to IOM
 ;
 D HEADER
 I '$G(ECXPORT),'$D(^TMP($J,"FACILITY LIST")) W !!,"No Movement Types to display" Q
 ;
 ;Loop on TMP for entries, handle paging, calls to HEADER and CONTINUE
 S CODE=""
 F  S CODE=$O(^TMP($J,"FACILITY LIST",CODE)) Q:CODE=""  D  Q:'OK
 . S ENTRY=""
 . F  S ENTRY=$O(^TMP($J,"FACILITY LIST",CODE,ENTRY)) Q:ENTRY=""  D  Q:'OK
 . . I $G(ECXPORT) D  Q
 . . . S CNT=$G(CNT)+1,^TMP($J,"ECXPORT",CNT)=CODE_U_^TMP($J,"FACILITY LIST",CODE,ENTRY)
 . . I ($Y+4)>$G(IOSL) D PAUSE I OK D HEADER
 . . I 'OK Q
 . . K ECXTMP
 . . S ECXTMP=0
 . . S DATA=^TMP($J,"FACILITY LIST",CODE,ENTRY)
 . . W !,CODE,?7,$P(DATA,"^"),?49,$P(DATA,"^",2)
 ;
 ;I 'ECXPORT,OK D PAUSE
 ; 
 Q
 ;
HEADER ; Write out the display header
 Q:$G(ECXPORT)  ; Don't print header if export format
 W @IOF
 W "MAS Movement Type List",?35,$$FMTE^XLFDT($$NOW^XLFDT),?72,"Page ",PAGE
 W !,"IEN",?7,"NAME",?49,"TRANSACTION TYPE"
 W !,LN
 S PAGE=PAGE+1
 Q
 ;
PAUSE ; Ask if the user wants to continue [or quit (Set OK=0)]
 N DIR,X,Y
 W !
 S DIR(0)="E" D ^DIR K DIR I 'Y S OK=0 Q
 Q
