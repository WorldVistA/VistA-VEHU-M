IBMHSP1 ;EDE/SAB-MENTAL HEALTH VISIT INQUIRY Part 2 ; 29-NOV-19
 ;;2.0;INTEGRATED BILLING;**784**;21-MAR-94;Build 8
 ;; Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
 ; Prints report to the current device
 ;
 ; Input:
 ;   IBDFN - Patient IEN
 ;   IBDT1 - Beginning date
 ;   IBDT2 - Ending date
 ; Output:
 ;   IBQUIT = 1, if user entered "^" (Devices starting with "C-" only)
REPORT ;
 N IBDT,IBVSIEN,IBDATA,IBYR,IBSQNO,IBI
 N IBSITE,IBSTAT,IBBLNO,IBREAS
 S IBQUIT=0
 ;
 ;Gather the visits within the year range into to a sorted temporary array
 S IBVSIEN=0
 F  S IBVSIEN=$O(^IBMH(351.83,"B",IBDFN,IBVSIEN)) Q:'IBVSIEN  D
 . S IBDATA=$G(^IBMH(351.83,IBVSIEN,0)),IBDT=$P(IBDATA,U,3)
 . ;convert date to year format for comparison.
 . S IBYR=$E(IBDT,1,3)+1700
 . Q:IBYR<IBDT1    ; Visit date before year range start
 . Q:IBYR>IBDT2    ; Visit date after year range end
 . ; find visit number so we don't overwrite multiple visits on same day
 . S (IBSQNO,IBI)=0 F  S IBI=$O(^TMP($J,"IBMHSP",IBYR,IBDT,IBI)) Q:'IBI  Q:'$D(^TMP($J,"IBMHSP",IBYR,IBDT,IBI))  S (IBI,IBSQNO)=IBSQNO+1
 . S IBSQNO=IBSQNO+1
 . ;CONVERT THE POINTER AND CODES TO TEXTINFO TO TEXT.
 . S IBSITE=$$GET1^DIQ(351.83,IBVSIEN_",",.02,"E")
 . S IBSTAT=$$GET1^DIQ(351.83,IBVSIEN_",",.04,"E")
 . S IBBLNO=$P(IBDATA,U,5)
 . S IBREAS=$$GET1^DIQ(351.83,IBVSIEN_",",.06,"E")
 . S ^TMP($J,"IBMHSP",IBYR,IBDT,IBSQNO)=IBDT_U_$E(IBSITE,1,18)_U_IBSTAT_U_IBBLNO_U_IBREAS
 ;
 D PRINT
 K ^TMP($J,"IBMHSP")
 S:$D(ZTQUEUED) ZTREQ="@" ; for Taskman
 Q
 ;
PRINT ; Print report from the temp. global  (cONVERT TO EXTERNAL DATA)
 N IBDTH,IBLINE,IBPAG,IBYR,IBDT,IBSQNO,IBDATA,IBH,IBPT
 D NOW^%DTC S IBDTH=$$FMTE^XLFDT($E(%,1,12))
 S IBLINE="",$P(IBLINE,"=",IOM+1)="",(IBPAG,IBQUIT)=0
 S IBPT=$$PT^IBEFUNC(IBDFN)
 S IBH="Mental Health Visit Profile for "_$P(IBPT,U) D HDR
 I '$D(^TMP($J,"IBMHSP")) W !!,"The patient has no Mental Health Visits within the specified period" D PAUSE(1) Q
 S IBYR=0
 F  S IBYR=$O(^TMP($J,"IBMHSP",IBYR)) Q:'IBYR  D  Q:IBQUIT
 . S IBDT=0
 . W !,IBYR,!,"----"
 . F  S IBDT=$O(^TMP($J,"IBMHSP",IBYR,IBDT)) Q:IBDT=""  D  Q:IBQUIT
 . . D CHKSTOP    ; Pause at the end of each screen page.  Allow user to exit.  Returns IBQUIT
 . . Q:IBQUIT
 . . S IBSQNO=0
 . . F  S IBSQNO=$O(^TMP($J,"IBMHSP",IBYR,IBDT,IBSQNO)) Q:IBSQNO=""  D  Q:IBQUIT
 . . . D CHKSTOP    ; Pause at the end of each screen page.  Allow user to exit.  Returns IBQUIT
 . . . Q:IBQUIT
 . . . S IBDATA=$G(^TMP($J,"IBMHSP",IBYR,IBDT,IBSQNO))
 . . . Q:$G(IBDATA)=""
 . . . W !,$$FMTE^XLFDT($P(IBDATA,U,1)),?15,$P(IBDATA,U,2),?35,$P(IBDATA,U,3),?47,$P(IBDATA,U,4),?60,$P(IBDATA,U,5)
 . ; print a separator between years.
 . W !
 Q:IBQUIT
 D PAUSE(1)
 Q
CHKSTOP I $Y>(IOSL-5) D PAUSE(0) Q:IBQUIT  D HDR
 Q
 ;
HDR ; Print header.
 N IBI
 I $E(IOST,1,2)["C-"!(IBPAG) W @IOF,*13
 S IBPAG=IBPAG+1 W ?(80-$L(IBH)\2),IBH
 W !,"From ",IBDT1," through ",IBDT2
 W ?IOM-36,IBDTH,?IOM-9,"Page: ",IBPAG
 W !,"VISIT DATE",?15,"SITE",?35,"STATUS",?47,"BILL NO.",?60,"REASON"
 W ! F IBI=1:1:80 W "-"
 Q
 ;
PAUSE(IBEND) ;
 Q:$E(IOST,1,2)'["C-"
 N IBJ,DIR,DIRUT,DTOUT,DUOUT,DIROUT,Y
 W !! ;F IBJ=$Y:1:(IOSL-4) W !
 S DIR(0)="E"
 I $G(IBEND) S DIR("A")="End of the report. Enter RETURN to continue or '^' to exit"
 D ^DIR K DIR I $G(DUOUT) S IBQUIT=1 W @IOF Q
 I $G(IBEND) W @IOF
 Q
 ;
