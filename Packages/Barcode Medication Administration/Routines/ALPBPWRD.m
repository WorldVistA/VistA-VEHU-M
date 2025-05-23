ALPBPWRD ;OIFO-DALLAS MW,SED,KC-PRINT 3-DAY MAR BCMA BCBU REPORT FOR A SELECTED WARD ; 2/27/13 2:24pm
 ;;3.0;BAR CODE MED ADMIN;**8,37,48,59,73**;Mar 2004;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; 
 ; NOTE: this routine is designed for hard-copy output.
 ;      Output is formatted for 132-column printing.
 ; 
 ;*73 Add Clinic Order (CO) identification and clinic name print with 
 ;    CO's sorting after IM meds.
 ;
 F  D  Q:$D(DIRUT)
 .W !,"Inpatient Pharmacy Orders for a selected ward"
 .S DIR(0)="FAO^2:10"
 .S DIR("A")="Select WARD: "
 .S DIR("?")="^D WARDLIST^ALPBUTL(""C"")"
 .D ^DIR K DIR
 .I $D(DIRUT) Q
 .D WARDSEL^ALPBUTL(Y,.ALPBSEL)
 .I +$G(ALPBSEL(0))=0 D  Q
 ..W $C(7)
 ..W "  ??"
 ..D WARDLIST^ALPBUTL("C")
 ..K ALPBSEL
 .I +$G(ALPBSEL(0))=1 D
 ..S ALPBWARD=ALPBSEL(1)
 ..W "   ",ALPBWARD
 ..K ALPBSEL
 .I +$G(ALPBSEL(0))>1 D  I $D(DIRUT) K DIRUT,DTOUT,X,Y Q
 ..S ALPBX=0
 ..F  S ALPBX=$O(ALPBSEL(ALPBX)) Q:'ALPBX  W !?2,$J(ALPBX,2),"  ",ALPBSEL(ALPBX)
 ..K ALPBX
 ..S DIR(0)="NA^1:"_ALPBSEL(0)
 ..S DIR("A")="Select Ward from the list (1-"_ALPBSEL(0)_"): "
 ..W ! D ^DIR K DIR
 ..I $D(DIRUT) K ALPBSEL Q
 ..S ALPBWARD=ALPBSEL(+Y)
 ..K ALPBSEL
 .;
 .; get all or just current orders?...
 .S DIR(0)="SA^A:ALL;C:CURRENT"
 .S DIR("A")="Report [A]LL or [C]URRENT orders? "
 .S DIR("B")="CURRENT"
 .S DIR("?")="[A]LL=all orders in the file, [C]URRENT=orders not yet expired."
 .W ! D ^DIR K DIR
 .I $D(DIRUT) K ALPBWARD,DIRUT,DTOUT,X,Y Q
 .S ALPBOTYP=Y
 .;
 .;added in PSB*3*59 to benefit users located at the long term care and domiciliary sites.
 .;include patients without active medications?...
 .S ALPBWOMD=""
 .I ALPBOTYP="C" D
 ..S DIR(0)="SA^Y:YES;N:NO"
 ..S DIR("A")="Include Patients Without Active Medications? "
 ..S DIR("B")="YES"
 ..S DIR("?",1)="[Y]es=include patients without active medication orders,"
 ..S DIR("?",2)="[N]o=do not include patients without active medication orders."
 ..W ! D ^DIR K DIR
 ..I $D(DIRUT) K ALPBOTYP,DIRUT,DTOUT,X,Y Q
 ..S ALPBWOMD=Y
 .;
 .;SORT BY NAME OR ROOM/BED     added 6/23/05
 .S DIR(0)="SA^N:Name;R:Room/Bed"
 .S DIR("A")="Sort Patients by [N]ame or [R]oom/Bed? "
 .S DIR("B")="Room/bed"
 .S DIR("?")="Sort by [N]ame or [R]oom Bed"
 .W ! D ^DIR K DIR
 .I $D(DIRUT) K ALPBWARD,ALPBWOMD,DIRUT,DTOUT,X,Y Q
 .S ALPBSORT=Y
 .;
 .; print how many days MAR?...
 .S DIR(0)="NA^1:7"
 .S DIR("A")="Print how many days MAR? "
 .S DIR("B")=$$DEFDAYS^ALPBUTL()
 .S DIR("?")="The default is shown; please select a number 1 to 7."
 .W ! D ^DIR K DIR
 .I $D(DIRUT) K ALPBOTYP,DIRUT,DTOUT,X,Y Q
 .S ALPBDAYS=+Y
 .;
 .; BCMA Med Log info for how many ?...
 .S DIR(0)="NA^1:99"
 .S DIR("B")=$$DEFML^ALPBUTL3()
 .S DIR("A")="Select how many BCMA Medication Log history: "
 .S DIR("A",1)=" "
 .S DIR("?",1)="Select a number of BCMA Medication log entries"
 .S DIR("?",2)="for each of the patient's orders"
 .S DIR("?")="They are listed by the most current entry first"
 .D ^DIR K DIR
 .I $D(DIRUT) K ALPBOTYP,ALPBWARD,DIRUT,DTOUT,X,Y Q
 .S ALPBMLOG=Y
 .;
 .S %ZIS="Q"
 .S %ZIS("B")=$$DEFPRT^ALPBUTL()
 .I %ZIS("B")="" K %ZIS("B")
 .W ! D ^%ZIS K %ZIS
 .I POP D  Q
 ..W $C(7)
 ..K ALPBMLOG,ALPBOTYP,ALPBWARD,POP,ALPBWOMD
 .;
 .; output not queued...
 .I '$D(IO("Q")) D
 ..U IO
 ..D DQ
 ..I IO'=IO(0) D ^%ZISC
 .;
 .; set up the Task...
 .I $D(IO("Q")) D
 ..S ZTRTN="DQ^ALPBPWRD"
 ..S ZTDESC="PSB INPT PHARM ORDERS FOR WARD "_ALPBWARD
 ..S ZTSAVE("ALPBDAYS")=""
 ..S ZTSAVE("ALPBWARD")=""
 ..S ZTSAVE("ALPBMLOG")=""
 ..S ZTSAVE("ALPBOTYP")=""
 ..S ZTSAVE("ALPBSORT")=""
 ..S ZTSAVE("ALPBWOMD")=""
 ..S ZTIO=ION
 ..D ^%ZTLOAD
 ..D HOME^%ZIS
 ..W !,$S($G(ZTSK):"Task number "_ZTSK_" queued.",1:"ERROR -- NOT QUEUED!")
 ..K IO("Q"),ZTSK
 .K ALPBDAYS,ALPBMLOG,ALPBOTYP,ALPBWARD,ALPBWOMD
 K DIRUT,DTOUT,X,Y
 Q
 ;
DQ ; output entry point...
 K ^TMP($J)
 N ALPBCLIN                                                       ;*73
 ;
 ; set report date...  SED 11/4/03
 S ALPBRDAT=$S(ALPBOTYP="C":$$NOW^XLFDT(),1:"")
 ;
 ; loop through ward cross reference in 53.7...
 N ALPBDRGNAME
 S ALPBPTN=""
 F  S ALPBPTN=$O(^ALPB(53.7,"AW",ALPBWARD,ALPBPTN)) Q:ALPBPTN=""  D
 .S ALPBIEN=0
 .F  S ALPBIEN=$O(^ALPB(53.7,"AW",ALPBWARD,ALPBPTN,ALPBIEN)) Q:'ALPBIEN  D
 ..D ORDS^ALPBUTL(ALPBIEN,ALPBRDAT,.ALPBORDS)
 ..I $G(ALPBPDAT(0))="" S ALPBPDAT(0)=$G(^ALPB(53.7,ALPBIEN,0))
 ..I +ALPBORDS(0)'>0&(ALPBWOMD="Y") D  Q
 ...S ^TMP($J,ALPBPTN)=ALPBIEN
 ...K ALPBORDS
 ..S ALPBOIEN=0
 ..F  S ALPBOIEN=$O(ALPBORDS(ALPBOIEN)) Q:'ALPBOIEN  D
 ...S ALPBDATA=$G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,1))
 ...S ALPBDAT0=$G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,0))               ;*73
 ...S ALPBCLIN=$P(ALPBDAT0,U,5) S:ALPBCLIN="" ALPBCLIN=0          ;*73
 ...S ALPBOCT=$P($G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,3)),U,1)
 ...S:$P($G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,4)),U,3)["PRN" ALPBOCT=ALPBOCT_"P"
 ...;drug name being used for alpha-sorting medications within order types (unit dose, unit dose-PRN, intravenous, intravenous-PRN)
 ...S ALPBDRGNAME=$P($G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,7,1,0)),U,2)
 ...S:ALPBDRGNAME="" ALPBDRGNAME="NOT FOUND"   ;*73
 ...; if report is for "C"urrent, check stop date and quit if
 ...; stop date is less than report date
 ...I ALPBOTYP="C"&($P(ALPBDATA,U,2)<ALPBRDAT) K ALPBDATA Q
 ...S ALPBORDN=ALPBORDS(ALPBOIEN)
 ...S ALPBOST=$$STAT2^ALPBUTL1(ALPBORDS(ALPBOIEN,2))
 ...I '$D(^TMP($J,ALPBPTN)) S ^TMP($J,ALPBPTN)=ALPBIEN
 ...S ^TMP($J,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST,ALPBORDN)=ALPBOIEN  ;*73
 ...K ALPBDATA,ALPBDAT0,ALPBORDN,ALPBOST,ALPBDRGNAME
 ..K ALPBOIEN,ALPBORDS,ALPBPDAT
 .K ALPBIEN
 K ALPBPTN
 ;
 ; Sort by Patient Name or room/bed capability added 6/23/05 KFOX
 S ALPBPG=0
 S ALPBPTN=""
 I ALPBSORT="N" D
 .F  S ALPBPTN=$O(^TMP($J,ALPBPTN)) Q:ALPBPTN=""  S ALPBIEN=^TMP($J,ALPBPTN) D PRT
 ;SORT BY ROOM/BED
 I ALPBSORT="R" D
 .S ALPBD="",ALPRM=""
 .F  S ALPBPTN=$O(^TMP($J,ALPBPTN)) Q:ALPBPTN=""  D  Q:ALPBPTN=""
 ..I ALPBPTN="BCBU" S ALPBPTN=$O(^TMP($J,ALPBPTN)) ;SKIP "BCBU" SUBSCRIBE
 ..I ALPBPTN="" Q  ;PSB*3*37 Stop null subscript when "BCBU" is the last entry in ^TMP
 ..S ALPBIEN=^TMP($J,ALPBPTN) S ALPRM=$P($G(^ALPB(53.7,ALPBIEN,0)),"^",6),ALPBD=$P($G(^ALPB(53.7,ALPBIEN,0)),"^",7)
 ..S:$TR(ALPBD,"""","")="" ALPBD="NONE" S:$TR(ALPRM,"""","")="" ALPRM="NONE" ;INCASE NO ROOM AND BED YET
 ..S ^TMP($J,"BCBU",ALPRM,ALPRM,ALPBD,ALPBPTN)=ALPBIEN
 .S ALPRM1="" F  S ALPRM1=$O(^TMP($J,"BCBU",ALPRM1)) Q:ALPRM1=""  D
 ..S ALPRM="" F  S ALPRM=$O(^TMP($J,"BCBU",ALPRM1,ALPRM)) Q:ALPRM=""  D
 ...S ALPBD="" F  S ALPBD=$O(^TMP($J,"BCBU",ALPRM1,ALPRM,ALPBD)) Q:ALPBD=""  D
 ....S ALPBPTN="" F  S ALPBPTN=$O(^TMP($J,"BCBU",ALPRM1,ALPRM,ALPBD,ALPBPTN)) Q:ALPBPTN=""  D
 .....S ALPBIEN=$G(^TMP($J,"BCBU",ALPRM1,ALPRM,ALPBD,ALPBPTN))  D PRT
 D DONE
 Q
PRT S ALPBPDAT(0)=$G(^ALPB(53.7,ALPBIEN,0))
 M ALPBPDAT(1)=^ALPB(53.7,ALPBIEN,1)
 I ALPBPG=0 D PAGE
 N ALPBNOMDS
 S ALPBNOMDS=""
 S:$D(^TMP($J,ALPBPTN))=1 ALPBNOMDS=1
 S ALPBCLIN=""     ;*73
 F  S ALPBCLIN=$O(^TMP($J,ALPBPTN,ALPBCLIN)) Q:ALPBCLIN=""  D     ;*73
 .S ALPBOCT=""
 .F  S ALPBOCT=$O(^TMP($J,ALPBPTN,ALPBCLIN,ALPBOCT)) Q:ALPBOCT=""  D
 ..S ALPBDRGNAME=""
 ..F  S ALPBDRGNAME=$O(^TMP($J,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME)) Q:ALPBDRGNAME=""  D
 ...S ALPBOST=""
 ...F  S ALPBOST=$O(^TMP($J,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST)) Q:ALPBOST=""  D
 ....S ALPBORDN=""
 ....F  S ALPBORDN=$O(^TMP($J,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST,ALPBORDN)) Q:ALPBORDN=""  D
 .....S ALPBOIEN=^TMP($J,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST,ALPBORDN)
 .....; get and print this order's data...
 .....M ALPBDATA=^ALPB(53.7,ALPBIEN,2,ALPBOIEN)
 .....D F132^ALPBFRM1(.ALPBDATA,ALPBDAYS,ALPBMLOG,.ALPBFORM,ALPBIEN)
 .....;D F132^ALPBFRM1(.ALPBDATA,ALPBDAYS,.ALPBFORM)
 .....I $Y+ALPBFORM(0)=IOSL!($Y+ALPBFORM(0)>IOSL) D PAGE
 .....F ALPBX=1:1:ALPBFORM(0) W !,ALPBFORM(ALPBX)
 .....K ALPBDATA,ALPBFORM,ALPBOIEN,ALPBX
 ....K ALPBORDN
 ...K ALPBOST
 ..K ALPBDRGNAME
 .K ALPBOCT
 ; print footer at end of this patient's record...
 I $Y+10>IOSL D PAGE
 ;notification message displays one line below header info if patient has no med orders when the report is generated
 I ALPBNOMDS D
 .W !!,"No Active Medication Orders were reported to the Contingency at the time the MAR was printed ",!!!
 .;additional blank lines added to separate footer from header and allow room for notes
 .I $E(IOST)="P" F  Q:$Y>=(IOSL-6)  W !
 ;
 D FOOT^ALPBFRMU
 ;Print a blank page between patient (this was removed by PSB*3*59 - the BCMA Workgroup agreed to condense the report)
 ;W @IOF 
 S ALPBPG=0
 K ALPBPDAT
 Q
 ;K ALPBIEN,ALPBPDAT KILLING ALPBIEN WILL BREAK SORT BY ROOM/BED
 ;
DONE ;   
 K ALPBDAYS,ALPBMLOG,ALPBOTYP,ALPBPG,ALPBPTN,ALPBRDAT,ALPBWARD,^TMP($J),ALPRM,ALPRM1,ALPBD,ALPBIEN,ALPBSORT,ALPBNOMDS
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
PAGE ; print page header for patient...
 W @IOF
 S ALPBPG=ALPBPG+1
 D HDR^ALPBFRMU(.ALPBPDAT,ALPBPG,.ALPBHDR)
 F ALPBX=1:1:ALPBHDR(0) W !,ALPBHDR(ALPBX)
 K ALPBHDR,ALPBX
 Q
