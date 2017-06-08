SDZSCECU ;ALB/MLI - SCE global cleanup for duplicates - 3/7/96
 ;;version 1 - 3/7/96
 ;
 ; This routine is designed to run through the OUTPATIENT ENCOUNTER
 ; file and look for duplicates.  It can be run for a date range that
 ; could include all dates.  If run from the top (line tag EN), it
 ; will develop a report of findings.  If run from line tag KILL, it
 ; will cause the dups to be killed and generate a report.
 ;
 ; This should only be run with assistance of IRMFO CS staff.  It
 ; should only be distributed to sites where this problem has been
 ; discovered.
 ;
 ; DON'T RUN IT WITH KILLS UNTIL YOU'VE RUN IT WITHOUT AND GONE OVER
 ; THE REPORT TO ENSURE IT IS GOING TO DO WHAT YOU EXPECT!!
 ;
 ; here endeth the sermon...  ;)
 ;
EN ; prompt for date range, device
 S SDKILL=+$G(SDKILL)
 D DATE^SDUTL I POP G ENQ
 W !!,"This output requires 132 columns.",!!
 S %ZIS="PMQ" D ^%ZIS I POP G ENQ
 I '$D(IO("Q")) D DQ
 I $D(IO("Q")) S Y=$$QUE()
ENQ K SDBD,SDED,SDKILL
 D CLOSE^SDUTL
 Q
 ;
 ;
QUE() ; -- que job
 ; return: did job que [ 1|yes   0|no ]
 ;
 K ZTSK,IO("Q")
 S ZTDESC="Outpatient Encounter file Cleanup",ZTRTN="DQ^SDZSCECU"
 F X="SDBD","SDED","SDKILL" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $G(ZTSK)
 ;
 ;
DQ ; dequeue...start processing
 U IO
 D SEARCH
 D PRINT
 K SDBEG,SDEND,SDKILL,^TMP("SCE-CLEANUP",$J)
 D CLOSE^SDUTL
 Q
 ;
 ;
SEARCH ; search through date range to find problem cases...store
 N DFN,I,J,K,X
 S I=SDBD-.1
 F  S I=$O(^SCE("B",I)) Q:'I!(I>(SDED+.9))  D
 . S DA=0
 . F  S DA=$O(^SCE("B",I,DA)) Q:'DA  D
 . . S X=$G(^SCE(DA,0)) I 'X Q
 . . S DFN=$P(X,"^",2) I 'DFN Q
 . . S ^TMP("SCE-CLEANUP-TEMP",$J,DFN,DA)=X
 . S DFN=0
 . F  S DFN=$O(^TMP("SCE-CLEANUP-TEMP",$J,DFN)) Q:'DFN  D DUPCHK
 . K ^TMP("SCE-CLEANUP-TEMP",$J)
 Q
 ;
 ;
DUPCHK ; check for duplicates for same patient/same time
 N DA,FLAG,I,J,P,X
 S DA=0
 F  S DA=$O(^TMP("SCE-CLEANUP-TEMP",$J,DFN,DA)) Q:'DA  S X=^(DA) D
 . I $P(X,"^",12)'=14 Q  ; only look at 'action required'
 . S J=0
 . F  S J=$O(^TMP("SCE-CLEANUP-TEMP",$J,DFN,J)) Q:'J  S X1=^(J) D
 . . I J=DA Q  ; same entry number...ignore
 . . I $P(X1,"^",12)=14 Q  ; ignore if 'action required'
 . . S FLAG=1
 . . F P=1,2,3,4,8,9,10,11,13 I $P(X,"^",P)'=$P(X1,"^",P) S FLAG=0 Q  ; check pieces...set flag to 0 if no match
 . . I FLAG S ^TMP("SCE-CLEANUP",$J,+X,DFN,DA)=J_"^"_X ; store potential duplicates
 . . I FLAG,SDKILL D DIK(DA)
 Q
 ;
 ;
DIK(DA) ; kill entry in SCE with IEN of DA
 ;
 N DIK,I,J
 S DIK="^SCE("
 D ^DIK
 Q
 ;
 ;
PRINT ; print list of potential duplicates
 ;
 I '$D(^TMP("SCE-CLEANUP",$J)) W !,"Encounter file search found no bad entries" Q
 ;
 N IEN,DFN,I,LINE,PAGE,FLAG
 S (FLAG,I,PAGE)=0,$P(LINE,"-",132)=""
 D HDR I FLAG Q
 F  S I=$O(^TMP("SCE-CLEANUP",$J,I)) Q:'I  D  Q:FLAG
 . S DFN=0
 . F  S DFN=$O(^TMP("SCE-CLEANUP",$J,I,DFN)) Q:'DFN  D  Q:FLAG
 . . S IEN=0
 . . F  S IEN=$O(^TMP("SCE-CLEANUP",$J,I,DFN,IEN)) Q:'IEN  S X=^(IEN)  D  Q:FLAG
 . . . I $Y>(IOSL-4) D HDR Q:FLAG
 . . . D PID^VADPT6
 . . . W !,$$FMTE^XLFDT(I),?25,$P($G(^DPT(DFN,0)),"^",1),?60,VA("BID"),?70,$J(IEN,20),?110,$J(+X,15)
 Q
 ;
 ;
HDR ; header for report
 N X
 I PAGE,($E(IOST,1,2)="C-") S DIR(0)="E" D ^DIR I 'Y S FLAG=1 Q
 S PAGE=PAGE+1
 I PAGE>1!($E(IOST,1,2)="C-") W @IOF
 S X=$S(SDKILL:"KILLS WERE PERFORMED!",1:"NO KILLS WERE PERFORMED")
 W !?36,"RESULTS OF SEACH FOR DUPLICATES IN OUTPATIENT ENCOUNTER FILE"
 W !?(66-($L(X)/2)),X
 W !!,?70,"Duplicate/Bad Encounter IEN",?110,"Good Encounter IEN"
 W !,"DATE/TIME",?25,"PATIENT",?60,"ID",?77,"(To be Killed)",?110,"(To Remain in File)"
 W !,LINE
 Q
 ;
 ;
KILL ; call this if you want kills to be executed when run
 S SDKILL=1
 D EN
 Q
