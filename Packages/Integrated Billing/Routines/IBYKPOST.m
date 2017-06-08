IBYKPOST ;WAS/RFJ - post init for patch ib*2*56 ; 28 Feb 96
 ;;Version 2.0 ; INTEGRATED BILLING ;**56**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 I '$G(DUZ)!($G(DUZ(0))'="@") W !!,"DUZ OR DUZ(0) NOT DEFINED." Q
 D ^IBYKONIT
 D START
 Q
 ;
 ;
START ;  start post init
 ;;This is the post init for patch IB*2*56.  When an admission is
 ;;deleted from the movement file (405), it leaves invalid admission
 ;;pointers in the claims tracking files (356, 356.9, 356.91, 356.93,
 ;;and 356.94).  This patch will remove the invalid admission pointers
 ;;from the files by looping through all the entries and inactivating
 ;;the claims tracking entries (in file 356).  Future admissions which
 ;;are deleted will be removed from the files using the functionality
 ;;contained within this patch.
 N %,ADMTDATA,DA,DATA,DFN,FILE,LINE,LINESET1,LINESET2,LINESET3,PATIENT,SET,VA,VAERR,X,Y
 K ^TMP($J,"IBYKPOST")
 ;
 S LINE=0
 W ! F %=1:1 S X=$P($T(START+%),";",3,99) Q:X=""  W !,X D SETMSG(X)
 W !!,"A mail message will be generated to the DGPM UR ADMISSION mail"
 W !,"group when the post init finishes.  It will contain specific"
 W !,"information regarding inactivated entries and invalid admission"
 W !,"pointers."
 ;
 S Y=$$NOW^XLFDT D DD^%DT S X="Start Time: "_Y W !!,X D SETMSG(X)
 ;
 S X="    Cleaning up file 356 ..." W !!,X D SETMSG(X)
 S (LINESET1,LINESET2,LINESET3)=0
 S DA=0 F  S DA=$O(^IBT(356,DA)) Q:'DA  S DATA=$G(^(DA,0)) D
 .   ;  if no admission ptr, do nothing
 .   I '$P(DATA,"^",5) Q
 .   ;
 .   S DFN=$P(DATA,"^",2) I 'DFN Q
 .   D PID^VADPT I $G(VA("BID"))="" S VA("BID")="????"
 .   S PATIENT=$E($P($G(^DPT(DFN,0)),"^")_"                   ",1,15)_"("_VA("BID")_")"
 .   ;
 .   ;  if entry is inactive, delete admission ptr
 .   I '$P(DATA,"^",20) D  Q
 .   .   D SET1
 .   .   D INACTIVE^IBTRKRU(DA)
 .   ;
 .   ;  active entries
 .   S ADMTDATA=$G(^DGPM(+$P(DATA,"^",5),0))
 .   ;
 .   ;  if admission ptr dangling, inactivate and delete admission ptr
 .   I ADMTDATA="" D  Q
 .   .   D SET2
 .   .   D INACTIVE^IBTRKRU(DA)
 .   ;
 .   ;  if the movement is not for the same patient on the same date,
 .   ;  inactivate entry and delete the admission ptr
 .   I $P(DATA,"^",2)'=$P(ADMTDATA,"^",3)!($P($P(DATA,"^",6),".")'=$P($P(ADMTDATA,"^"),".")) D  Q
 .   .   D SET3
 .   .   D INACTIVE^IBTRKRU(DA)
 ;
 F FILE=356.9,356.91,356.93,356.94 D
 .   S X="    Cleaning up file "_FILE_" ..." W !!,X D SETMSG(X)
 .   S DA=0 F  S DA=$O(^IBT(FILE,DA)) Q:'DA  S DATA=$G(^(DA,0)) D
 .   .   ;  no admission ptr, delete the record
 .   .   I '$D(^DGPM(+$P(DATA,"^",2),0)) D DELETE^IBTRKRU(FILE,DA) Q
 .   .   ;  no entry in claims tracking for admission
 .   .   I '$D(^IBT(356,"AD",+$P(DATA,"^",2))) D DELETE^IBTRKRU(FILE,DA) Q
 ;
 S Y=$$NOW^XLFDT D DD^%DT S X="End   Time: "_Y W !!,X,! D SETMSG(X)
 ;
 ;  build mail message
 F SET="SET3","SET2","SET1" I $D(^TMP($J,"IBYKPOST",SET)) D
 .   D SETMSG(" "),SETMSG(" "),SETMSG($TR($J("",75)," ","="))
 .   F %=1:1 S X=$P($T(@SET+%),";",3,99) Q:X=""  D SETMSG(X)
 .   S %=0 F  S %=$O(^TMP($J,"IBYKPOST",SET,%)) Q:'%  D SETMSG(^(%))
 D SEND
 K ^TMP($J,"IBYKPOST")
 Q
 ;
 ;
SET1 ;  text for bulletin
 ;;The following claims tracking entries in file 356 are inactive.
 ;;The admission movement pointer has been removed by the post
 ;;initialization routine.
 S LINESET1=LINESET1+1
 S ^TMP($J,"IBYKPOST","SET1",LINESET1)="entry "_$E(DA_"       ",1,7)_"  patient: "_PATIENT_"  admission ptr"_$J($P(DATA,"^",5),8)_" removed"
 Q
 ;
 ;
SET2 ;  text for bulletin
 ;;The following ACTIVE claims tracking entries in file 356 have
 ;;patients with missing admission pointers to the movement file 405.
 ;;The claims tracking entries will be set to INACTIVE and the missing
 ;;admission pointers will be removed.
 S LINESET2=LINESET2+1
 S ^TMP($J,"IBYKPOST","SET2",LINESET2)="entry "_$E(DA_"       ",1,7)_"  patient: "_PATIENT_"  admission ptr"_$J($P(DATA,"^",5),8)_" removed"
 Q
 ;
 ;
SET3 ;  text for bulletin
 ;;The following ACTIVE claims tracking entries in file 356 have
 ;;been entered for the wrong patient or admission date.
 ;;The claims tracking entries will be set to INACTIVE and the wrong
 ;;admission pointers will be removed.
 S LINESET3=LINESET3+1
 S Y=$P(DATA,"^",6) D DD^%DT
 S ^TMP($J,"IBYKPOST","SET3",LINESET3)="entry "_$E(DA_"       ",1,7)_"  patient: "_PATIENT_"    episode date: "_$P(Y,"@")
 ;  build 2nd line of bulletin with admission patient
 S DFN=$P(ADMTDATA,"^",3) I 'DFN Q
 D PID^VADPT I $G(VA("BID"))="" S VA("BID")="????"
 S PATIENT=$E($P($G(^DPT(DFN,0)),"^")_"                   ",1,15)_"("_VA("BID")_")"
 S Y=$P(ADMTDATA,"^") D DD^%DT
 S LINESET3=LINESET3+1
 S ^TMP($J,"IBYKPOST","SET3",LINESET3)="     admission patient: "_PATIENT_"  admission date: "_$P(Y,"@")
 Q
 ;
 ;
SETMSG(TEXT) ;  set text in tmp global for mail message
 S LINE=LINE+1,^TMP($J,"IBYKPOST","MSG",LINE)=TEXT
 Q
 ;
 ;
SEND ;  send bulletin 
 N %X,DIFROM,XCNP,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 S XMSUB="Claims Tracking Patch IB*2*56 Clean Up Routine"
 S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="^TMP($J,""IBYKPOST"",""MSG"","
 S XMY("G.DGPM UR ADMISSION")=""
 S XMY(DUZ)=""
 D ^XMD
 Q
