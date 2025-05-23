PXBGPOV4 ;ISL/JVS - DOUBLE ?? GATHERING OF FORM DIAGNOSES ;5/7/03 3:31pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**11,28,121,199**;Aug 12, 1996;Build 52
 ;
 ;
 ;
 W !,"THIS IS NOT AN ENTRY POINT" Q
 ;  
 ;
DOUBLE1(FROM) ;--Entry point
 ;
NEW ;
 ;
 N CNT,CODE,CYCLE,FIELD,FILE,HEADING,INDEX,NAME,OK,POVSTR,PRV,PXBPMT
 N PXDXDATE,SCREEN,START,SUB,SUB2,TITLE,TOTAL,VSTIEN
 S VSTIEN=$S($D(PXBVST)=1:PXBVST,$D(VISIT)=1:VISIT,1:"")
 S PXDXDATE=$$CSDATE^PXDXUTL(VSTIEN)
 ;---SETUP VARIABLES
 S BACK="",INDEX=""
 S START=DATA,SUB=0,SUB2=0
 ;
START1 ;--RECYCLE POINT
 S TITLE="- - F O R M    D I A G N O S I S - -"
 ;
 S POVSTR=$P($$ACTDT^PXDXUTL(PXDXDATE),U,1)
 I POVSTR?2N.A S POVSTR=$E(POVSTR,3,99)_$E(POVSTR,1,2) ; turn 10D into D10, etc. to make it a valid line tag
 S POVSTR=POVSTR_"^PXBAICS"
 D GETLST^IBDF18A(CLINIC,$P($T(@POVSTR),";;",2),"PXBPMT",,,,PXDXDATE)
ME ;
 ;--------TEST PURPOSES-------
 ;S PXBPMT(0)=4
 ;S PXBPMT(1)="^TEST"
 ;S PXBPMT(2)="309.0^TEST 1"
 ;S PXBPMT(3)="295.12^TEST 2"
 ;S PXBPMT(4)="V62.2^TEST 3"
 ;---------------------
 S TOTAL=PXBPMT(0)
 I PXBPMT(0)>0 D
 .S (SUB,CNT)=0 F  S SUB=$O(PXBPMT(SUB)) Q:SUB=""  D
 ..Q:$P(PXBPMT(SUB),"^",1)=""
 ..S CODE=$P(PXBPMT(SUB),"^",1)
 ..Q:'$P($$ICDDATA^ICDXCODE("DIAG",CODE,PXDXDATE,"E"),"^",10)
 ..S NAME=$P(PXBPMT(SUB),"^",2)
 ..S CNT=CNT+1
 ..S ^TMP("PXBTOTAL",$J,"DILIST","ID",CNT,.01)=CODE
 ..S ^TMP("PXBTOTAL",$J,"DILIST","ID",CNT,2)=NAME
 I $D(CNT) S TOTAL=CNT
 ;
 ;
 ;--DISPLAY IF NO MATCH FOUND
 I TOTAL=0 W IOCUU,IOCUU,!,IOELEOL D
 .D LOC W !
 .S RESULTS="NO DIAGNOSIS BLOCKS EXIST FOR AN ENCOUNTER FORM" W !!!,?(IOM-$L(RESULTS))\2,RESULTS D HELP1^PXBUTL1("CON") R OK:DTIME
 I TOTAL=0 Q TOTAL
 ;
 ;
 ;----DISPLAY LIST TO THE SCREEN
 S HEADING="W !,""ITEM"",?6,""CODE"",?16,""DESCRIPTION   "",IOINHI,TOTAL,"" ENTRIES"",IOINLOW"
LIST ;-DISPLAY LIST TO THE SCREEN
 D LOC W !
 X HEADING
 S SUB=SUB-1
 S NUM=0 F  S SUB=$O(^TMP("PXBTOTAL",$J,"DILIST","ID",SUB)) S NUM=NUM+1 Q:NUM=11  Q:SUB'>0  S SUB2=SUB2+1 D
 .S CODE=$G(^TMP("PXBTOTAL",$J,"DILIST","ID",SUB,.01))
 .S NAME=$G(^TMP("PXBTOTAL",$J,"DILIST","ID",SUB,2))
 .W !,SUB,?6,CODE,?16,$E(NAME,1,63)
 ;
 ;----If There is only one selection go to proper prompting
 I TOTAL=1 G PRMPT2
 ;
PRMPT ;---WRITE PROMPT HERE
 D WIN17^PXBCC(PXBCNT)
 D LOC^PXBCC(15,1)
 W !
 I SUB>0 W !,"Enter '^' to quit"
 E  I TOTAL>10 W !,"               END OF LIST"
 I SUB>0 S DIR("A")="Select a single 'ITEM NUMBER' or 'RETURN' to continue: "
 E  S DIR("A")="Select a single 'ITEM NUMBER' or 'RETURN' to exit: "
 S DIR("?")="Enter ITEM 'No' to select , '^' to quit"
 S DIR(0)="N,A,O^0:"_SUB2_":0^I X'?.1""^"".N K X"
 D ^DIR
 I X="",SUB>0 G LIST
 I X="",SUB'>0 S X="^"
 I $G(DIRUT) K DIRUT S VAL="^P" G EXITNEW
VAL ;-----Set the VAL equal to the value
 S VAL=$G(^TMP("PXBTOTAL",$J,"DILIST",2,X))_"^"_$G(^TMP("PXBTOTAL",$J,"DILIST","ID",X,.01))
EXITNEW ;--EXIT
 K DIR,^TMP("PXBTANA",$J),^TMP("PXBTOTAL",$J)
 K TANA,TOTAL
 Q VAL
 Q
 ;
 ;-----------------SUBROUTINES--------------
BACK ;
 S START=$G(^TMP("PXBTANA",$J,"DILIST",1,1))
 S START("IEN")=$G(^TMP("PXBTANA",$J,"DILIST",2,1))
 Q
FORWARD ;
 S START=$G(^TMP("PXBTANA",$J,"DILIST",1,10))
 S START("IEN")=$G(^TMP("PXBTANA",$J,"DILIST",2,10))
 Q
LOC ;--LOCATE CURSOR
 D LOC^PXBCC(3,1) ;--LOCATE THE CURSOR
 W IOEDEOP ;--CLEAR THE PAGE
 Q
HEAD ;--HEAD
 W !,IOCUU,IOBON,"HELP SCREEN",IOSGR0,?(IOM-$L(TITLE))\2,IOINHI,TITLE,IOINLOW,IOELEOL
 Q
SUB ;--DISPLAY LIST TO THE SCREEN
 I $P(^TMP("PXBTANA",$J,"DILIST",0),"^",1)=0 W !!,"     E N D  O F  L I S T" Q
 X HEADING
 S SUB=0,CNT=0 F  S SUB=$O(^TMP("PXBTANA",$J,"DILIST","ID",SUB)) Q:SUB'>0  S CNT=CNT+1 D
 .S NAME=$G(^TMP("PXBTANA",$J,"DILIST","ID",SUB,.01))
 .W !,SUB,?6,NAME
 Q
SETUP ;-SETP VARIABLES
 S FILE=200,FIELD=.01
 S HEADING="W !,""ITEM"",?6,""NAME"""
 Q
PRMPT2 ;-----Yes and No prompt if only choice
 D WIN17^PXBCC(PXBCNT)
 D LOC^PXBCC(15,1)
 S DIR("A")="Is this the correct entry "
 S DIR("B")="YES"
 S DIR(0)="Y"
 D ^DIR
 I Y=0 S X="^"
 I Y=1 S X=1
 G VAL
