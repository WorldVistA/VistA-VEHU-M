ALPBPPAT ;OIFO-DALLAS MW,SED,KC-PRINT 3-DAY MAR BCBU BACKUP REPORT FOR A SELECTED PATIENT ;2/13/13 13:13pm
 ;;3.0;BAR CODE MED ADMIN;**8,48,59,73**;Mar 2004;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; 
 ; NOTE: this routine is designed for hard-copy output. 
 ;  Output is formatted for 132-column printing.
 ;
 ;*73 Add Clinic Order (CO) identification and clinic name print with 
 ;    CO's sorting after IM meds.
 ;
 F  D  Q:$D(DIRUT)
 .W !!,"Inpatient Pharmacy Orders for a selected patient"
 .S DIR(0)="PAO^53.7:QEMZ"
 .S DIR("A")="Select PATIENT NAME: "
 .D ^DIR K DIR
 .I $D(DIRUT) K X,Y Q
 .S ALPBIEN=+Y
 .S ALPBPTN=Y(0,0)
 .; get all or just current orders?...
 .S DIR(0)="SA^A:ALL;C:CURRENT"
 .S DIR("A")="Report [A]LL or [C]URRENT orders? "
 .S DIR("B")="CURRENT"
 .S DIR("?")="[A]LL=all orders in the file, [C]URRENT=orders not yet expired."
 .W ! D ^DIR K DIR
 .I $D(DIRUT) K DIRUT,DTOUT,X,Y Q
 .S ALPBOTYP=Y
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
 ..K ALPBIEN,ALPBPTN,POP
 .;
 .; output not queued...
 .I '$D(IO("Q")) D
 ..U IO
 ..D DQ
 ..I IO'=IO(0) D ^%ZISC
 .;
 .; set up the Task...
 .I $D(IO("Q")) D
 ..S ZTRTN="DQ^ALPBPPAT"
 ..S ZTIO=ION
 ..S ZTDESC="PSB INPT PHARM ORDERS FOR "_ALPBPTN
 ..S ZTSAVE("ALPBDAYS")=""
 ..S ZTSAVE("ALPBIEN")=""
 ..S ZTSAVE("ALPBMLOG")=""
 ..S ZTSAVE("ALPBOTYP")=""
 ..D ^%ZTLOAD
 ..D HOME^%ZIS
 ..W !!,$S(+$G(ZTSK):"Task "_ZTSK_" queued.",1:"ERROR: NOT QUEUED!")
 ..K IO("Q"),ZTSK
 .;
 .K ALPBDAYS,ALPBIEN,ALPBMLOG,ALPBOTYP,ALPBPTN,X,Y
 K DIRUT,DTOUT,X,Y
 Q
 ;
DQ ; output entry point...
 K ^TMP($J)
 N ALPBCLIN                                                   ;*73
 ;
 ; set report date...
 S ALPBRDAT=$$NOW^XLFDT()
 S ALPBPT(0)=$G(^ALPB(53.7,ALPBIEN,0))
 M ALPBPT(1)=^ALPB(53.7,ALPBIEN,1)
 S ALPBPG=1
 D HDR^ALPBFRMU(.ALPBPT,ALPBPG,.ALPBHDR)
 F I=1:1:ALPBHDR(0) W !,ALPBHDR(I)
 K ALPBHDR
 ;
 ; loop through orders and sort by order status...
 N ALPBNOMEDS1,ALPBDRGNAME
 S ALPBOIEN=0,ALPBNOMEDS1=1
 F  S ALPBOIEN=$O(^ALPB(53.7,ALPBIEN,2,ALPBOIEN)) Q:'ALPBOIEN  D
 .M ALPBDATA=^ALPB(53.7,ALPBIEN,2,ALPBOIEN)
 .; if report type is "C"urrent and stop date is less than report date then quit and if status contains 'on hold' do not print and quit...
 .I ALPBOTYP="C" D  Q:'$D(ALPBDATA)
 ..I $$STAT^ALPBUTL1($E($P(ALPBDATA(0),U,3),1,2))["on hold" K ALPBDATA Q
 ..I $G(ALPBDATA(1))="" K ALPBDATA Q
 ..I $P(ALPBDATA(1),U,2)<ALPBRDAT K ALPBDATA
 .S ALPBNOMEDS1=0
 .S ALPBCLIN=$P(ALPBDATA(0),U,5) S:ALPBCLIN="" ALPBCLIN=0       ;*73
 .S ALPBORDN=$P(ALPBDATA(0),U)
 .S ALPBOCT=$P($G(ALPBDATA(3)),U,1)
 .S:$P($G(ALPBDATA(4)),U,3)["PRN" ALPBOCT=ALPBOCT_"P"
 .;drug name being used for alpha-sorting medications within order types (unit dose, unit dose-PRN, intravenous, intravenous-PRN)
 .S ALPBDRGNAME=$P($G(ALPBDATA(7,1,0)),U,2)
 .; gets the medications order status based on the order status code
 .S ALPBOST=$$STAT2^ALPBUTL1($P($P($G(ALPBDATA(0),"XX"),U,3),"~"))
 .S ^TMP($J,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST,ALPBORDN)=ALPBOIEN
 .K ALPBDATA,ALPBOST,ALPBOCT,ALPBDRGNAME
 ;
 ; loop through the sorted orders...
 S ALPBCLIN=""
 F  S ALPBCLIN=$O(^TMP($J,ALPBCLIN)) Q:ALPBCLIN=""  D
 .S ALPBOCT=""
 .F  S ALPBOCT=$O(^TMP($J,ALPBCLIN,ALPBOCT)) Q:ALPBOCT=""  D
 ..S ALPBDRGNAME=""
 ..F  S ALPBDRGNAME=$O(^TMP($J,ALPBCLIN,ALPBOCT,ALPBDRGNAME)) Q:ALPBDRGNAME=""  D
 ...S ALPBOST=""
 ...F  S ALPBOST=$O(^TMP($J,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST)) Q:ALPBOST=""  D
 ....S ALPBORDN=""
 ....F  S ALPBORDN=$O(^TMP($J,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST,ALPBORDN)) Q:ALPBORDN=""  D
 .....S ALPBOIEN=^TMP($J,ALPBCLIN,ALPBOCT,ALPBDRGNAME,ALPBOST,ALPBORDN)
 .....M ALPBDATA=^ALPB(53.7,ALPBIEN,2,ALPBOIEN)
 .....W !
 .....D F132^ALPBFRM1(.ALPBDATA,ALPBDAYS,ALPBMLOG,.ALPBFORM,ALPBIEN)
 .....; paginate?...
 .....I $Y+ALPBFORM(0)=IOSL!($Y+ALPBFORM(0)>IOSL) D
 ......W @IOF
 ......S ALPBPG=ALPBPG+1
 ......D HDR^ALPBFRMU(.ALPBPT,ALPBPG,.ALPBHDR)
 ......F I=1:1:ALPBHDR(0) W !,ALPBHDR(I)
 ......W !
 ......K ALPBHDR
 .....F I=1:1:ALPBFORM(0) W !,ALPBFORM(I)
 .....K ALPBDATA,ALPBFORM
 ....K ALPBORDN
 ...K ALPBOST
 ..K ALPBDRGNAME
 .K ALPBOCT
 ;
 ;notification message displays one line below header info if patient has no med orders when the report is generated
 I ALPBNOMEDS1 D
 .W !!,"No Active Medication Orders were reported to the Contingency at the time the MAR was printed ",!!!
 .;additional blank lines added to separate footer from header and allow room for notes
 .I $E(IOST)="P" F  Q:$Y>=(IOSL-6)  W !
 ;
 ; print footer at end of this patient's record...
 D FOOT^ALPBFRMU
 ;
 K ALPBDAYS,ALPBMLOG,ALPBOIEN,ALPBORDN,ALPBOST,ALPBOTYP,ALPBPG,ALPBPT,ALPBRDAT,^TMP($J),ALPBNOMEDS1
 I $D(ZTQUEUED) S ZTREQ="@"
 ;
 ; write form feed at end if output device is a printer...
 I $E(IOST)="P" W @IOF
 Q
