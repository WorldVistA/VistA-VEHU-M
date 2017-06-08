DSIFRPT3 ;DSS/AMC - RPC VERSION OF FBPAY ;7/9/2001
 ;;3.2;FEE BASIS CLAIMS SYSTEM;;Jun 05, 2009;Build 38
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;   2056  GETS^DIQ
 ;   5090  $$DATX^FBAAUTL,$$SSN^FBAAUTL
 ;
EN(AXY,FBSORT,FBIEN,FBBDATE,FBEDATE,FB1725R,PROGS) ;RPC - DSIF PAT/VEN PAYMENT REPORT
 ;Input Parameters:
 ;    FBSORT - Sort Indicator (1 = Patient, 0 = Vendor - Default = 0)
 ;    FBIEN - Patient/Vendor Internal Entry Number (File 161/161.2 respectively)
 ;    FBBDATE - Begining Date for report (FileMan Format)
 ;    FBEDATE - Ending Date for report (FileMan Format)
 ;    FB1725R - Mill-Bill indicator only used if PROGS passes in Fee Programs with internal numbers 2, 3 or 6
 ;              (M - include only 38 U.S.C. 1725 claims, N - exclude 38 U.S.C. 1725 claims, A - All)
 ;    PROGS - List of Fee Programs to include on report (Multi-piece IEN ^ Name)
 ;            (IEN is pointer to file 161.8 FEE PROGRAMS, the user should only be allowed to select active programs.)
 ;    
 ;Return Array:
 ;    -1 ^ Invalid Input!
 ;    -1 ^ Invalid Input! Mill-Bill!  (This is if program 2, 3 or 6 is passed and FB1725 is null)
 ;    User readable report in return array
 ;
 S AXY=$NA(^TMP("DSIFRPT3",$J)) K @AXY N FBPROG
 S FBSORT=+$G(FBSORT),FBIEN=+$G(FBIEN),FBBDATE=+$G(FBBDATE),FBEDATE=+$G(FBEDATE),FB1725R=+$G(FB1725R) D LDPROG
 I 'FBIEN!'FBBDATE!'FBEDATE S @AXY@(0)="-1^Invalid Input!" Q
 I $D(FBPROG(2))!$D(FBPROG(3))!$D(FBPROG(6)) I FB1725R="" S @AXY@(0)="-1^Invalid Input! Mill-Bill!" Q
 N A1,A2,A3,BEGDATE,B3,C,C3,D,D2,DFN,DIC,DIR,DTOUT,DUOUT,ENDDATE,FBPROG,XX,YY
 N FBAACPTC,FBAC,FBAP,FBBATCH,FBBEG,FBBN,FBCNT,FBCP,FBCRT,FBDA1,FBDASH,FBDASH1,FBDATA,FBDOB,FBDRUG,FBDT,FBDT1,FBDOS,FBEND,FBERR,FBFD,FBFD1,FBHEAD,FBMOD
 N FBI,FBID,FBIN,FBINVN,FBIX,FBLOC,FBM,FBNAME,FBOB,FBOPI,FBOUT,FBOV,FBP,FBPAT,FBPD,FBPDX,FBPG,FBPI,FBPID,FBPIFLG,FBPIN,FBPISV,FBPNAME,FBPT,FBPV,FBQTY,FBREIM,FBR,FBRX,FBTRCK
 N FBADJLA,FBADJLR,FBFPPSC,FBFPPSL,TAMT,FBRRMKL,FBADJ,FBINV
 N FBSC,FBSL,FBSTR,FBSUSP,FBTA,FBTRDT,FBTRX,FBTYPE,FBV,FBVCHAIN,FBVNAME,FBVI,FBVID,FBVP,FBXPROG,FBY,FBZ,I,J,K,L,M,PGM,T,V,VA,VAERR,VAL,VAR,VAUTNI,VAUTSTR,VAUTVB,X,Y,Z
 S YY=0
 D GETVET:FBSORT,GETVEN:'FBSORT
 S Z=9999999.9999,FBBEG=Z-FBEDATE,FBEND=Z-FBBDATE
 S $P(FBDASH,"=",80)="",$P(FBDASH1,"-",80)="",FBPG=0,(FBCRT,FBOUT)=0,FBBEG=FBBEG-.9
SORT ;sort driver for payment output(s)
 S FBPI=0 F  S FBPI=$O(FBPROG(FBPI)) Q:'FBPI  S FBXPROG=FBPROG(FBPI) D
 .I FBPI=2 D EN^DSIFRPT4 ;D EN^FBPAY2 ;outpatient payments
 .I FBPI=3 D EN^DSIFRPT5 ;D EN^FBPAY3 ;pharmacy payments
 .I FBPI=6!(FBPI=7) S:FBPI=6&$D(FBPROG(7)) FBPIFLG=67 D EN^DSIFRPT6 S:$D(FBPIFLG) FBPI=7 K FBPIFLG ;civil hospital/cnh payments
PRINT ;print driver for payment output(s)
 S FBPI=$O(^TMP($J,"FB",0)) I FBPI']"" D WMSG G OUT
 S (FBOUT,FBPI)=0 F  S FBPI=$O(FBPROG(FBPI)) Q:'FBPI  S FBXPROG=FBPROG(FBPI) D  Q:FBOUT
 .I FBPI=2,$D(^TMP($J,"FB",FBPI)) D PRINT^DSIFRP41 Q:$G(FBOUT)  D:$D(^TMP($J,"FB",FBPI_"O")) OTH Q
 .I FBPI=3 D:$D(^TMP($J,"FB",FBPI)) PRINT^DSIFRPT5 Q:$G(FBOUT)  D:$D(^TMP($J,"FB",FBPI_"O")) OTH Q
 .I FBPI=6!(FBPI=7) D:$D(^TMP($J,"FB",FBPI)) PRINT^DSIFRP67 Q:$G(FBOUT)  D:$D(^TMP($J,"FB",FBPI_"O")) OTH Q
OUT ;
 Q
 ;I FBOUT!$D(ZTQUEUED) G EXIT
 ;D KILL G GETVET:FBX,GETVEN
 ;Q
EXIT ;kill and quit
 K FBX
KILL ;kill all variables set in the FBPAY* routines, other than fbx
 K ^TMP($J,"FB"),^TMP($J,"FBTR")
 Q
ARRAY ;set array if all programs are selected
 S FBPI=0 F  S FBPI=$O(^FBAA(161.8,FBPI)) Q:'FBPI  S FBPIN=$G(^(FBPI,0)) I $P(FBPIN,U,3) S FBPROG(FBPI)=$P(FBPIN,U)
 I '$D(FBPROG) S FBERR=1
 Q
WMSG ;write message if no matches found
 S FBPG=FBPG+1 I $G(FBCRT) S XX="" D LN
 S $E(XX,25)=$S($G(FBSORT):"VETERAN",1:"VENDOR")_" PAYMENT HISTORY"
 ;W !?25,$S($G(FBSORT):"VETERAN",1:"VENDOR")," PAYMENT HISTORY"
 I $G(FB1725R)]"",FB1725R'="A" S XX=XX_" "_$S(FB1725R="M":"for 38 U.S.C. 1725 Claims",1:"excluding 38 U.S.C. 1725 Claims")
 D LN
 ;I $G(FB1725R)]"",FB1725R'="A" W " ",$S(FB1725R="M":"for 38 U.S.C. 1725 Claims",1:"excluding 38 U.S.C. 1725 Claims")
 S $E(XX,24)=$E(FBDASH,1,24),$E(XX,71)="Page: "_FBPG D LN
 ;W !?24,$E(FBDASH,1,24),?71,"Page: ",FBPG
 I FBSORT S XX="Patient: "_FBNAME,$E(XX,41)="Patient ID:"_FBID D LN
 ;I FBSORT W !,"Patient: ",FBNAME,?41,"Patient ID:",FBID
 I 'FBSORT S XX="Vendor: "_FBNAME,$E(XX,41)="Vendor ID:"_FBID D LN
 ;I 'FBSORT W !,"Vendor: ",FBNAME,?41,"Vendor ID:",FBID
 ;W !?(IOM-12/2),"FEE PROGRAM:"
 S $E(XX,3)="('*' Reimb. to Patient   '+' Cancel. Activity   '#' Voided Payment)" D LN
 D LN,LN S XX=FBDASH D LN
 ;W !!!,FBDASH
 D LN S XX="There are no payments on file for "_$S(FBSORT:"Veteran",1:"Vendor")_" "_FBNAME D LN S $E(XX,3)="for specified date range: "_$$DATX^FBAAUTL(FBBDATE)_" through "_$$DATX^FBAAUTL(FBEDATE)
 ;W !!,"There are no payments on file for "_$S(FBSORT:"Veteran",1:"Vendor")_" ",FBNAME,!?3,"for specified date range: ",$$DATX^FBAAUTL(FBBDATE)," through ",$$DATX^FBAAUTL(FBEDATE)
 I 'FBPROG D
 .S $E(XX,3)="and selected Fee Program(s):" D LN
 .S FBPI=0 F  S FBPI=$O(FBPROG(FBPI)) Q:'FBPI  S $E(XX,30)=FBPROG(FBPI) D LN
 I FBPROG S $E(XX,3)="and ALL Fee programs."
 ;W ".",*7,!!
 Q
OTH ;other fee basis programs
 I '$D(^TMP($J,"FB",FBPI_"O")) Q
 S FBZ=FBPI,FBPI=FBPI_"O",FBPROG(FBPI)="**OUTPATIENT** "_FBXPROG
 D PRINT^DSIFRP41
 K FBPROG(FBPI) S FBPI=FBZ K FBZ
 Q
LDPROG ;Load the FBPROG array
 N X,Y S X=""
 F Y=0:1 S X=$O(PROGS(X)) Q:X=""  S FBPROG(+PROGS(X))=$P(PROGS(X),U,2)
 S FBPROG=$S(Y:0,1:1)
 D ARRAY:FBPROG
 Q
LN ;
 S YY=YY+1,@AXY@(YY)=XX,XX=""
 Q
GETVEN ;
 N GET,IENS,FIL
 S FIL=161.2,IENS=FBIEN_"," D GETS^DIQ(FIL,IENS,".01;1","IE","GET")
 S FBNAME=$S($G(GET(FIL,IENS,.01,"E"))]"":GET(FIL,IENS,.01,"E"),1:"UNKNOWN")
 S FBID=$S($G(GET(FIL,IENS,1,"E"))]"":GET(FIL,IENS,1,"E"),1:"UNKNOWN")
 Q
GETVET ;
 N GET,IENS,FIL
 S FIL=161,IENS=FBIEN_"," D GETS^DIQ(FIL,IENS,".01","E","GET")
 S FBNAME=$G(GET(FIL,IENS,.01,"E")),FBID=$$SSN^FBAAUTL(FBIEN)
 Q
 ;GETVEN ;select vendor
 ; K FBX S FBSORT=0 ;FBSORT=1 for patient, = 0 for vendor
 ; S DIC="^FBAAV(",DIC(0)="AEQMZ",DIC("A")="Select Fee Vendor: " W !! D ^DIC K DIC("A") G EXIT:$D(DTOUT)!($D(DUOUT))!(X=""),GETVEN:Y<0
 ; S FBIEN=+Y,FBNAME=$S(Y(0,0)]"":Y(0,0),1:"UNKNOWN"),FBID=$S($P(Y(0),U,2)]"":$P(Y(0),U,2),1:"UNKNOWN") G DATE
 ;GETVET ;select patient
 ; K FBX S FBSORT=1 ;FBSORT=1 for patient, =0 for vendor
 ; S DIC="^FBAAA("
 ; S DIC(0)="AEQMNZ",DIC("A")="Select Fee Patient: " W !! D ^DIC K DIC("A") G EXIT:$D(DTOUT)!($D(DUOUT))!(X=""),GETVET:Y<0
 ; S FBIEN=+Y,FBNAME=Y(0,0),FBID=$$SSN^FBAAUTL(FBIEN)
 ;DATE ;select date range
 ; D DATE^FBAAUTL I FBPOP G GETVET:FBSORT,GETVEN
 ; S FBBDATE=BEGDATE,FBEDATE=ENDDATE
 ; S Z=9999999.9999,FBBEG=Z-FBEDATE,FBEND=Z-FBBDATE
 ;PROG ;select one/many/all fee programs
 ; I '$G(FBCHK) S DIC="^FBAA(161.8,",DIC("S")="I $P(^(0),U,3)",VAUTSTR="FEE Program",VAUTNI=2,VAUTVB="FBPROG" D FIRST^VAUTOMA I 'FBPROG&('$O(FBPROG(0))) G GETVET:FBSORT,GETVEN
 ; I FBPROG S FBERR=0 D ARRAY G EXIT:FBERR
 ;ASKMB ; if outpatient or civil hospital or pharmacy selected then ask if
 ;;   report for just mill-bill (1725) or just non-mill bill claims
 ; I $D(FBPROG(2))!$D(FBPROG(3))!$D(FBPROG(6)) S FB1725R=$$ASKMB^FBUCUTL9 I FB1725R="" G EXIT
 ;Q K ^TMP($J,"FB"),^TMP($J,"FBTR"),DIC S FBX=FBSORT
 ; S VAR="FBNAME^FBIEN^FBID^FBBEG^FBEND^FBBDATE^FBEDATE^FBPROG^FBPROG(^FBSORT^FB1725R",VAL=VAR,PGM="DQ^FBPAY" D ZIS^FBAAUTL G:FBPOP EXIT
