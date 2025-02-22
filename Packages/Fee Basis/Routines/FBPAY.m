FBPAY ;AISC/DMK,GRR,TET-PATIENT/VENDOR PAYMENT OUTPUT DRIVER ;6/14/93  09:29
 ;;3.0;FEE BASIS;**1,12**;NOV 26, 1993
GETVEN ;select vendor
 K FBX S FBSORT=0 ;FBSORT=1 for patient, = 0 for vendor
 S DIC="^FBAAV(",DIC(0)="AEQMZ",DIC("A")="Select Fee Vendor: " W !! D ^DIC K DIC("A") G EXIT:$D(DTOUT)!($D(DUOUT))!(X=""),GETVEN:Y<0
 S FBIEN=+Y,FBNAME=$S(Y(0,0)]"":Y(0,0),1:"UNKNOWN"),FBID=$S($P(Y(0),U,2)]"":$P(Y(0),U,2),1:"UNKNOWN") G DATE
GETVET ;select patient
 K FBX S FBSORT=1 ;FBSORT=1 for patient, =0 for vendor
 S DIC="^FBAAA("
 S DIC(0)="AEQMNZ",DIC("A")="Select Fee Patient: " W !! D ^DIC K DIC("A") G EXIT:$D(DTOUT)!($D(DUOUT))!(X=""),GETVET:Y<0
 S FBIEN=+Y,FBNAME=Y(0,0),FBID=$$SSN^FBAAUTL(FBIEN)
DATE ;select date range
 D DATE^FBAAUTL I FBPOP G GETVET:FBSORT,GETVEN
 S FBBDATE=BEGDATE,FBEDATE=ENDDATE
 S Z=9999999.9999,FBBEG=Z-FBEDATE,FBEND=Z-FBBDATE
PROG ;select one/many/all fee programs
 I '$G(FBCHK) S DIC="^FBAA(161.8,",DIC("S")="I $P(^(0),U,3)",VAUTSTR="FEE Program",VAUTNI=2,VAUTVB="FBPROG" D FIRST^VAUTOMA I 'FBPROG&('$O(FBPROG(0))) G GETVET:FBSORT,GETVEN
 I FBPROG S FBERR=0 D ARRAY G EXIT:FBERR
Q K ^TMP($J,"FB"),^TMP($J,"FBTR"),DIC S FBX=FBSORT
 S VAR="FBNAME^FBIEN^FBID^FBBEG^FBEND^FBBDATE^FBEDATE^FBPROG^FBPROG(^FBSORT",VAL=VAR,PGM="DQ^FBPAY" D ZIS^FBAAUTL G:FBPOP EXIT
DQ S $P(FBDASH,"=",80)="",$P(FBDASH1,"-",80)="",FBPG=0,FBCRT=$S($E(IOST,1,2)="C-":1,1:0),FBOUT=0,FBBEG=FBBEG-.9 U IO
SORT ;sort driver for payment output(s)
 S FBPI=0 F  S FBPI=$O(FBPROG(FBPI)) Q:'FBPI  S FBXPROG=FBPROG(FBPI) D
 .I FBPI=2 D EN^FBPAY2 ;outpatient payments
 .I FBPI=3 D EN^FBPAY3 ;pharmacy payments
 .I FBPI=6!(FBPI=7) S:FBPI=6&$D(FBPROG(7)) FBPIFLG=67 D EN^FBPAY67 S:$D(FBPIFLG) FBPI=7 K FBPIFLG ;civil hospital/cnh payments
PRINT ;print driver for payment output(s)
 S FBPI=$O(^TMP($J,"FB",0)) I FBPI']"" D WMSG G OUT
 S (FBOUT,FBPI)=0 F  S FBPI=$O(FBPROG(FBPI)) Q:'FBPI  S FBXPROG=FBPROG(FBPI) D  Q:FBOUT
 .I FBPI=2,$D(^TMP($J,"FB",FBPI)) D PRINT^FBPAY2 D:$D(^TMP($J,"FB",FBPI_"O")) OTH Q
 .I FBPI=3 D:$D(^TMP($J,"FB",FBPI)) PRINT^FBPAY3 D:$D(^TMP($J,"FB",FBPI_"O")) OTH Q
 .I FBPI=6!(FBPI=7) D:$D(^TMP($J,"FB",FBPI)) PRINT^FBPAY671 D:$D(^TMP($J,"FB",FBPI_"O")) OTH Q
OUT I FBOUT!$D(ZTQUEUED) G EXIT
 I FBSORT=0,(FBPI]"") W !!,"Total paid to vendor:  ",$J(FBTVPAY,10,2)
 D KILL G GETVET:FBX,GETVEN
 Q
EXIT ;kill and quit
 K FBX
KILL ;kill all variables set in the FBPAY* routines, other than fbx
 D CLOSE^FBAAUTL K ^TMP($J,"FB"),^TMP($J,"FBTR")
 K A1,A2,A3,BEGDATE,B3,C,C3,D,D2,DFN,DIC,DIR,DTOUT,DUOUT,ENDDATE
 K FBAACPTC,FBAC,FBAP,FBBATCH,FBBDATE,FBBEG,FBBN,FBCNT,FBCP,FBCRT,FBDA1,FBDASH,FBDASH1,FBDATA,FBDOB,FBDRUG,FBDT,FBDT1,FBDOS,FBEDATE,FBEND,FBERR,FBFD,FBFD1,FBHEAD
 K FBI,FBID,FBIEN,FBIN,FBINVN,FBIX,FBLOC,FBM,FBNAME,FBOB,FBOPI,FBOUT,FBOV,FBP,FBPAT,FBPD,FBPDX,FBPG,FBPI,FBPID,FBPIFLG,FBPIN,FBPISV,FBPNAME,FBPROG,FBPT,FBPV,FBQTY,FBREIM,FBRX,FBTRCK
 K FBSC,FBSL,FBSORT,FBSTR,FBSUSP,FBTA,FBTRDT,FBTRX,FBTYPE,FBV,FBVCHAIN,FBVNAME,FBVI,FBVID,FBVP,FBXPROG,FBY,FBZ,I,J,K,L,M,PGM,T,V,VA,VAERR,VAL,VAR,VAUTNI,VAUTSTR,VAUTVB,X,Y,Z,FBTVPAY
 Q
ARRAY ;set array if all programs are selected
 S FBPI=0 F  S FBPI=$O(^FBAA(161.8,FBPI)) Q:'FBPI  S FBPIN=$G(^(FBPI,0)) I $P(FBPIN,U,3) S FBPROG(FBPI)=$P(FBPIN,U)
 I '$D(FBPROG) S FBERR=1
 Q
WMSG ;write message if no matches found
 S FBPG=FBPG+1 W:$G(FBCRT) @IOF W !
 W !?25,$S($G(FBSORT):"VETERAN",1:"VENDOR")," PAYMENT HISTORY",!?24,$E(FBDASH,1,24),?71,"Page: ",FBPG
 I FBSORT W !,"Patient: ",FBNAME,?41,"Patient ID:",FBID
 I 'FBSORT W !,"Vendor: ",FBNAME,?41,"Vendor ID:",FBID
 ;W !?(IOM-12/2),"FEE PROGRAM:"
 W !?3,"('*' Represents Reimbursement to Patient",?50,"'#' Represents Voided Payment)"
 W !!!,FBDASH
 W !!,"There are no payments on file for "_$S(FBSORT:"Veteran",1:"Vendor")_" ",FBNAME,!?3,"for specified date range: ",$$DATX^FBAAUTL(FBBDATE)," through ",$$DATX^FBAAUTL(FBEDATE)
 I 'FBPROG D
 .W !?3,"and selected Fee Program(s):"
 .S FBPI=0 F  S FBPI=$O(FBPROG(FBPI)) Q:'FBPI  W !?30,FBPROG(FBPI)
 I FBPROG W !?3,"and ALL Fee programs"
 W ".",*7,!!
 Q
OTH ;other fee basis programs
 I '$D(^TMP($J,"FB",FBPI_"O")) Q
 S FBZ=FBPI,FBPI=FBPI_"O",FBPROG(FBPI)="**OUTPATIENT** "_FBXPROG
 D PRINT^FBPAY2
 K FBPROG(FBPI) S FBPI=FBZ K FBZ
 Q
