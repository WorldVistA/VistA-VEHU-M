ALPBPALL ;OIFO-DALLAS MW,SED,KC-PRINT 3-DAY MAR BCMA BACLUP REPORT FOR ALL WARDS ;2/13/13 13:13pm
 ;;3.0;BAR CODE MED ADMIN;**8,29,48,59,73**;Mar 2004;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; based on original code by FD@NJHCS, May 2002
 ; 
 ;*73 Add Clinic Order (CO) identification and clinic name print with 
 ;    CO's sorting after IM meds.
 ;
 W !,"Inpatient Pharmacy Orders for all wards"
 ;
 ; get all or just current orders?...
 S DIR(0)="SA^A:ALL;C:CURRENT"
 S DIR("A")="Report [A]LL or [C]URRENT orders? "
 S DIR("B")="CURRENT"
 S DIR("?")="[A]LL=all orders in the file, [C]URRENT=orders not yet expired."
 W ! D ^DIR K DIR
 I $D(DIRUT) K DIRUT,DTOUT,X,Y Q
 S ALPBOTYP=Y
 ;
 ;added in PSB*3*59 to benefit users located at the long term care and domiciliary sites
 ;include patients without active medications?...  
 I ALPBOTYP="A" S ALPBWOMED=""
 I ALPBOTYP="C" D
 .S DIR(0)="SA^Y:YES;N:NO"
 .S DIR("A")="Include Patients Without Active Medications? "
 .S DIR("B")="YES"
 .S DIR("?",1)="[Y]es=include patients without active medication orders,"
 .S DIR("?",2)="[N]o=do not include patients without active medication orders."
 .W ! D ^DIR K DIR
 .I $D(DIRUT) K ALPBOTYP,DIRUT,DTOUT,X,Y Q
 .S ALPBWOMED=Y
 ;
 ; print how many days MAR?...
 S DIR(0)="NA^1:7"
 S DIR("A")="Print how many days MAR? "
 S DIR("B")=$$DEFDAYS^ALPBUTL()
 S DIR("?")="The default is shown; please select a number 1 to 7."
 W ! D ^DIR K DIR
 I $D(DIRUT) K ALPBOTYP,DIRUT,DTOUT,X,Y Q
 S ALPBDAYS=+Y
 ;
 ; BCMA Med Log info for how many ?...
 S DIR(0)="NA^1:99"
 S DIR("B")=$$DEFML^ALPBUTL3()
 S DIR("A")="Select how many BCMA Medication Log history: "
 S DIR("A",1)=" "
 S DIR("?",1)="Select a number of BCMA Medication log entries"
 S DIR("?",2)="for each of the patient's orders"
 S DIR("?")="They are listed by the most current entry first"
 D ^DIR K DIR
 I $D(DIRUT) K ALPBOTYP,ALPBWARD,DIRUT,DTOUT,X,Y Q
 S ALPBMLOG=Y
 ;
 S %ZIS="Q"
 S %ZIS("B")=$$DEFPRT^ALPBUTL()
 I %ZIS("B")="" K %ZIS("B")
 W ! D ^%ZIS K %ZIS
 I POP K POP Q
 ;
 ; output not queued...
 I '$D(IO("Q")) D
 .U IO
 .D DQ
 .I IO'=IO(0) D ^%ZISC
 ;
 ; set up the task...
 I $D(IO("Q")) D
 .S ZTRTN="DQ^ALPBPALL"
 .S ZTDESC="PSB INPT PHARM ORDER FOR ALL WARDS"
 .S ZTIO=ION
 .S ZTSAVE("ALPBMLOG")=""
 .S ZTSAVE("ALPBOTYP")=""
 .S ZTSAVE("ALPBDAYS")=""
 .S ZTSAVE("ALPBWOMED")=""
 .D ^%ZTLOAD
 .D HOME^%ZIS
 .W !,$S($G(ZTSK):"Task number "_ZTSK_" queued.",1:"ERROR -- NOT QUEUED!")
 .K IO("Q"),ZTSK
 K ALPBDAYS,ALPBMLOG,ALPBOTYP,ALPBWOMED
 Q
 ;
DQ ; output entry point...
 K ^TMP($J)
 N ALPBCLIN,ALPBDAT0
 ;
 ; set report date...MOD 11/03/03 SED
 S ALPBRDAT=$S(ALPBOTYP="C":$$NOW^XLFDT(),1:"")
 ;
 ; loop through ward cross reference in 53.7...
 N ALPBDRGNAME
 S ALPBWARD=""
 F  S ALPBWARD=$O(^ALPB(53.7,"AW",ALPBWARD)) Q:ALPBWARD=""  D
 .S ALPBPTN=""
 .F  S ALPBPTN=$O(^ALPB(53.7,"AW",ALPBWARD,ALPBPTN)) Q:ALPBPTN=""  D
 ..S ALPBIEN=0
 ..F  S ALPBIEN=$O(^ALPB(53.7,"AW",ALPBWARD,ALPBPTN,ALPBIEN)) Q:'ALPBIEN  D
 ...D ORDS^ALPBUTL(ALPBIEN,ALPBRDAT,.ALPBORDS)
 ...I +ALPBORDS(0)'>0&(ALPBWOMED="Y") D  Q
 ....S ^TMP($J,ALPBWARD,ALPBPTN)=ALPBIEN
 ....K ALPBORDS
 ...S ALPBOIEN=0
 ...F  S ALPBOIEN=$O(ALPBORDS(ALPBOIEN)) Q:'ALPBOIEN  D
 ....S ALPBDAT0=$G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,0))
 ....S ALPBDATA=$G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,1))
 ....I ALPBOTYP="C"&($P(ALPBDATA,U,2)<ALPBRDAT) K ALPBDATA Q
 ....S ALPBOCT=$P($G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,3)),U,1)
 ....S:$P($G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,4)),U,3)["PRN" ALPBOCT=ALPBOCT_"P"
 ....S ALPBDRGNAME=$P($G(^ALPB(53.7,ALPBIEN,2,ALPBOIEN,7,1,0)),U,2)
 ....S ALPBCLIN=$P(ALPBDAT0,U,5) S:ALPBCLIN="" ALPBCLIN=0        ;*73
 ....S ALPBORDN=ALPBORDS(ALPBOIEN)
 ....S ALPBOST=$$STAT2^ALPBUTL1(ALPBORDS(ALPBOIEN,2))
 ....I '$D(^TMP($J,ALPBWARD,ALPBPTN)) S ^TMP($J,ALPBWARD,ALPBPTN)=ALPBIEN
 ....S ^TMP($J,ALPBWARD,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST,ALPBORDN)=ALPBOIEN
 ....K ALPBDATA,ALPBORDN,ALPBOST,ALPBOCT,ALPBDRGNAME
 ...K ALPBOIEN,ALPBORDS
 ..K ALPBIEN
 .K ALPBPTN
 K ALPBWARD
 ;
 ; process through our sorted list...
 S ALPBPG=0
 S ALPBWARD=""
 F  S ALPBWARD=$O(^TMP($J,ALPBWARD)) Q:ALPBWARD=""  D
 .S ALPBPTN=""
 .F  S ALPBPTN=$O(^TMP($J,ALPBWARD,ALPBPTN)) Q:ALPBPTN=""  D
 ..S ALPBIEN=+^TMP($J,ALPBWARD,ALPBPTN)
 ..S ALPBPDAT(0)=$G(^ALPB(53.7,ALPBIEN,0))
 ..M ALPBPDAT(1)=^ALPB(53.7,ALPBIEN,1)
 ..N ALPBNOMEDS2
 ..S ALPBNOMEDS2=""
 ..S:$D(^TMP($J,ALPBWARD,ALPBPTN))=1 ALPBNOMEDS2=1
 ..; paginate between patients...
 ..I ALPBPG=0 D PAGE
 ..S ALPBCLIN=""
 ..F  S ALPBCLIN=$O(^TMP($J,ALPBWARD,ALPBPTN,ALPBCLIN)) Q:ALPBCLIN=""  D
 ...S ALPBOCT=""
 ...F  S ALPBOCT=$O(^TMP($J,ALPBWARD,ALPBPTN,ALPBCLIN,ALPBOCT)) Q:ALPBOCT=""  D
 ....S ALPBDRGNAME=""
 ....F  S ALPBDRGNAME=$O(^TMP($J,ALPBWARD,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME)) Q:ALPBDRGNAME=""  D
 .....S ALPBOST=""
 .....F  S ALPBOST=$O(^TMP($J,ALPBWARD,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST)) Q:ALPBOST=""  D
 ......S ALPBORDN=""
 ......F  S ALPBORDN=$O(^TMP($J,ALPBWARD,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST,ALPBORDN)) Q:ALPBORDN=""  D
 .......S ALPBOIEN=^TMP($J,ALPBWARD,ALPBPTN,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST,ALPBORDN)
 .......; get and print this order's data...
 .......M ALPBDATA=^ALPB(53.7,ALPBIEN,2,ALPBOIEN)
 .......D F132^ALPBFRM1(.ALPBDATA,ALPBDAYS,ALPBMLOG,.ALPBFORM,ALPBIEN)
 .......I $Y+ALPBFORM(0)>IOSL D PAGE
 .......S ALPBX=0
 .......F  S ALPBX=$O(ALPBFORM(ALPBX)) Q:'ALPBX  W !,ALPBFORM(ALPBX)
 .......K ALPBDATA,ALPBFORM,ALPBOIEN,ALPBX
 ......K ALPBORDN
 .....K ALPBOST
 ....K ALPBDRGNAME
 ..K ALPBIEN,ALPBPDAT,ALPBOCT
 ..S ALPBPG=0
 ..;notification message displays one line below header info if patient has no med orders when the report is generated
 ..I ALPBNOMEDS2 D
 ...W !!,"No Active Medication Orders were reported to the Contingency at the time the MAR was printed ",!!!
 ...;additional blank lines added to separate footer from header and allow room for notes
 ...I $E(IOST)="P" F  Q:$Y>=(IOSL-6)  W !
 ..; print footer at end of this patient's record...
 ..D FOOT^ALPBFRMU
 ..;Print a blank page between patient (this was removed by PSB*3*59 - the BCMA Workgroup agreed to condense the report)
 ..;W @IOF
 .K ALPBPTN
 ;
 K ALPBDAYS,ALPBMLOG,ALPBOTYP,ALPBPG,ALPBRDAT,ALPBWARD,^TMP($J),ALPBNOMEDS2
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
PAGE ; paginate and print header for a patient...
 W @IOF
 ; increment page count...
 S ALPBPG=ALPBPG+1
 D HDR^ALPBFRMU(.ALPBPDAT,ALPBPG,.ALPBHDR)
 S ALPBX=0
 F  S ALPBX=$O(ALPBHDR(ALPBX)) Q:'ALPBX  W !,ALPBHDR(ALPBX)
 K ALPBHDR,ALPBX
 Q
