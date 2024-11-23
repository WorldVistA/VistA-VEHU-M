ECXDRG ;ALB/TJL - DRG Report ;4/2/24  15:12
 ;;3.0;DSS EXTRACTS;**190**;Dec 22, 1997;Build 36
 ;
EN ; Entry point from menu option
 N I,X,Y,DIR,ECXPORT
 ;S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  I ECXPORT D  Q ; The output can only be exported, 
 S ECXPORT=1 D  Q  ; but code to send output to the screen is retained - tjl FY25 - 190
 . K ^TMP($J,"ECXPORT")
 . S ^TMP($J,"ECXPORT",0)="DRG^EFFECTIVE DATE^STATUS^INACTIVE DATE^DRG DESCRIPTION"
 . D EN1
 . M ^TMP($J,"ECXPORT")=^TMP("ECXDRG",$J)
 . D EXPDISP^ECXUTL1
 ;
 ; Queue Report
 W !!,"** Report requires 132 columns to print correctly **",!!
 N ZTDESC,ZTIO,ZTSAVE
 S ZTIO=""
 S ZTDESC="Diagnosis Related Group"
 F I="NAME","EFF DATE","STATUS","INACT DATE" D
 . S ZTSAVE(I)=""
 D EN^XUTMDEVQ("EN1^ECXDRG",ZTDESC,.ZTSAVE)
 Q
EN1 ; Tasked entry point
 ; Declare variables
 N U,DA,LN,DESC,NAME,STAT,INACT,LINEDA,LINECT,NODE0,PAGENUM,NESI
 N DIC,DR,DIQ,CNT,STOP,QFLG,RUNDATE
 K ^TMP("ECXDRG",$J)
 S U="^",$P(LN,"-",132)=""
 S (CNT,QFLG,PAGENUM,STOP)=0
 D NOW^%DTC S Y=$E(%,1,12) S RUNDATE=$$FMTE^XLFDT(Y)
 I '$G(ECXPORT) D HEADER I STOP D EXIT Q
 D GETDATA I $G(ECXPORT) Q  ;Have data, no need to print.
 I '$D(^TMP("ECXDRG",$J)) D  Q
 .W !
 . W !,"+=========================+"
 . W !,"|  No DRG data available  |"
 . W !,"+=========================+"
 . D WAIT
 D DETAIL I STOP D EXIT Q
 K ^TMP("ECXDRG",$J)
 Q
 ;
GETDATA ;
 S DA=0 F  S DA=$O(^ICD(DA)) Q:(+DA=0)  D
 . S CNT=CNT+1
 . S NAME=$P(^ICD(DA,0),U,1)
 . S EFFDA=$O(^ICD(DA,66,9999999),-1)
 . S NODE0=$G(^ICD(DA,66,EFFDA,0))
 . S EFFDT=$$FMTE^XLFDT($P(NODE0,U,1))
 . S STAT=$P(NODE0,U,3)
 . S INACT=$S(STAT=0:EFFDT,1:"")
 . S STAT=$S(STAT=0:"Inactive",1:"Active")
 . S NESI=NAME_U_EFFDT_U_STAT_U_INACT
 . S ^TMP("ECXDRG",$J,CNT)=NESI
 . ; Get description (which may be multiple lines)
 . S DESCDA=$O(^ICD(DA,68,999999),-1)
 . S NODE0=$G(^ICD(DA,68,DESCDA,0))
 . S (LINECT,LINEDA)=0 F  S LINEDA=$O(^ICD(DA,68,DESCDA,1,LINEDA)) Q:'LINEDA  D
 . . I $G(ECXPORT) S:LINEDA>1 CNT=CNT+1 S ^TMP("ECXDRG",$J,CNT)=NESI_U_^ICD(DA,68,DESCDA,1,LINEDA,0) Q
 . . S LINECT=LINECT+1
 . . S ^TMP("ECXDRG",$J,CNT,LINECT)=^ICD(DA,68,DESCDA,1,LINEDA,0)
 . Q
 Q
HEADER ;print header
 S PAGENUM=PAGENUM+1
 W @IOF
 W !,?45,"Diagnosis Related Group (DRG) Report",?120,"Page: ",PAGENUM
 W !,?43,"Report Run Date/Time: "_RUNDATE
 W !!!,"DRG NAME",?35,"EFFECTIVE DATE",?56,"STATUS",?68,"INACTIVATION DATE",!,LN,!
 Q
 ;
DETAIL ;Print detailed line
 ; Input  :  ^TMP("ECXDRG",$J) full global reference
 ; Output :  None
 N RECORD,NODE,DLINE,BLANK
 S RECORD=0 F  S RECORD=$O(^TMP("ECXDRG",$J,RECORD)) Q:'RECORD!(STOP)  D
 . S BLANK=1 S NODE=^TMP("ECXDRG",$J,RECORD)
 . W !,$P(NODE,U,1),?36,$P(NODE,U,2),?56,$P(NODE,U,3),?70,$P(NODE,U,4)
 . W !,"DESCRIPTION:"
 . S DLINE=0 F  S DLINE=$O(^TMP("ECXDRG",$J,RECORD,DLINE)) Q:'DLINE  S BLANK=0 W ?14,^TMP("ECXDRG",$J,RECORD,DLINE),!
 . W:BLANK !
 . I $Y>(IOSL-5) D WAIT Q:STOP  D HEADER
 Q
 ;
WAIT ;End of page logic
 ;Input   ; None
 ;Output  ; STOP - Flag inidcating if printing should continue
 ;                 1 = Stop     0 = Continue
 S STOP=0
 I $E(IOST,1,2)="C-" D  Q    ; CRT - Prompt for continue
 . F  Q:$Y>(IOSL-3)  W !
 . N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 . S DIR(0)="E"
 . D ^DIR
 . S STOP=$S(Y'=1:1,1:0)
 S STOP=$$S^%ZTLOAD()   ; Background task - check TaskMan
 I STOP D
 . W !,"**************************************************"
 . W !,"*  Printing of DRG report stopped, as requested  *"
 . W !,"**************************************************"
 Q
EXIT ;Kill temp global
 K ^TMP("ECXDRG",$J)
 Q
 ;
