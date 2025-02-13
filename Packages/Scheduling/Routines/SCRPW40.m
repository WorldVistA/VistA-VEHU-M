SCRPW40 ;RENO/KEITH - Diagnosis/Procedure Frequency Report ;06/22/99
 ;;5.3;Scheduling;**144,180,556,593**;AUG 13, 1993;Build 14
 ;06/22/99 ACS - Added CPT modifiers to the report
 ;06/22/99 ACS - Added CPT modifier API calls
 ;04/13/08 - Updating to replace calls to unsupported/deleted ICD9 fields with API calls
 ;
 N SDDIV,SD,%DT,X,Y,DIR,SDX,LINEFLAG
 D TITL^SCRPW50("Outpatient Diagnosis/Procedure Frequency Report")
 I '$$DIVA^SCRPW17(.SDDIV) S SDOUT=1 G EXIT
 D SUBT^SCRPW50("**** Date Range Selection ****")
 S Y=$$IMP^SCRPWICD(30) S SD("I10DTI")=Y X ^DD("DD") S SD("I10DTE")=Y
BDT W ! S %DT="AEPX",%DT(0)=2961001,%DT("A")="Beginning date: " D ^%DT I Y<1 S SDOUT=1 G EXIT
 S SD("BDT")=Y
EDT S %DT("A")="   Ending date: " W ! D ^%DT I Y<1 S SDOUT=1 G EXIT
 I Y<SD("BDT") W !!,$C(7),"End date cannot be before begin date!",! G EDT
 S SD("EDT")=Y_.999999
 I (SD("BDT")<SD("I10DTI")),(SD("EDT")'<SD("I10DTI")) D  G BDT
 . W !!,$C(7),"Beginning and Ending dates must both be prior to "_SD("I10DTE")_" (ICD-9) or both be on or after "_SD("I10DTE")_" (ICD-10)."
 D SUBT^SCRPW50("**** Report Format Selection ****")
 K DIR S DIR(0)="S^D:DIAGNOSIS FREQUENCY;P:PROCEDURE FREQUENCY;B:BOTH DIAGNOSIS AND PROCEDURE",DIR("A")="Specify the type of report to print",DIR("?")="This determines the type of lists returned by the report."
 D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 G EXIT
 S SD("TYPE")=Y
 K DIR S DIR(0)="N^1:99999:0",DIR("A")="Limit list to most frequent",DIR("B")=50,DIR("?")="Enter the quantity of the most frequent items to list."
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 G EXIT
 S SD("FREQ")=Y
 W ! N ZTSAVE S ZTSAVE("SDDIV")="",ZTSAVE("SDDIV(")="",ZTSAVE("SD(")="" D EN^XUTMDEVQ("START^SCRPW40","Outpatient Diagnosis/Procedure Frequency Report",.ZTSAVE) S SDOUT=1 G EXIT
 ;
START ;Print report
 S (SDOUT,SDSTOP)=0 K ^TMP("SCRPW",$J) S SDI=$O(SDDIV("")),SDI=$O(SDDIV(SDI)) S:$P(SDDIV,U,2)="ALL DIVISIONS" SDI=1 S SDDIV("MULT")=SDI
 S SDT=SD("BDT") F  S SDT=$O(^SCE("B",SDT)) Q:'SDT!(SDT>SD("EDT"))!SDOUT  S SDOE=0 F  S SDOE=$O(^SCE("B",SDT,SDOE)) Q:'SDOE!SDOUT  S SDOE0=$$GETOE^SDOE(SDOE) I '$P(SDOE0,U,6),$P(SDOE0,U,2),$P(SDOE0,U,4),$$DIV() D EVAL
 G:SDOUT EXIT S SDIV="" F  S SDIV=$O(^TMP("SCRPW",$J,SDIV)) Q:SDIV=""  D ORD
 D STOP G:SDOUT EXIT D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2),SDPAGE=1,SDLINE="",$P(SDLINE,"-",(IOM+1))="",SDFF=0
 S Y=SD("BDT") X ^DD("DD") S SDPBDT=Y,Y=$P(SD("EDT"),".") X ^DD("DD") S SDPEDT=Y,SDT(1)="<*>  OUTPATIENT "_$S(SD("TYPE")="D":"DIAGNOSIS",SD("TYPE")="P":"PROCEDURE",1:"DIAGNOSIS/PROCEDURE")_" FREQUENCY REPORT  <*>"
 S SDT(2)="For the "_SD("FREQ")_" most frequent "_$S(SD("TYPE")="D":"diagnoses",SD("TYPE")="P":"procedures",1:"diagnoses and procedures")
 S SDIV="" F  S SDIV=$O(SDDIV(SDIV)) Q:'SDIV  S SDIV(SDDIV(SDIV))=SDIV
 I 'SDDIV,$P(SDDIV,U,2)'="ALL DIVISIONS" S SDIV($P(SDDIV,U,2))=$$PRIM^VASITE()
 I $P(SDDIV,U,2)="ALL DIVISIONS" S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,SDI)) Q:'SDI  S SDX=$P($G(^DG(40.8,SDI,0)),U) S:$L(SDX) SDIV(SDX)=SDI
 D:$E(IOST)="C" DISP0^SCRPW23 I '$O(^TMP("SCRPW",$J,0)) S SDIV=0 D DHDR(2,.SDT) D HDR Q:SDOUT  S SDX="No activity found within selected report parameters!" W !!?(IOM-$L(SDX)\2),SDX G EXIT
 S SDIVN="" F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""!SDOUT  S SDIV=SDIV(SDIVN) D DPRT(.SDIV)
 S SDI=0,SDI=$O(^TMP("SCRPW",$J,SDI)),SDDIV("MULT")=$O(^TMP("SCRPW",$J,SDI))
 G:SDOUT EXIT I SDDIV("MULT") S SDIV=0 D DPRT(.SDIV)
 ;
EXIT I $E(IOST)="C",'$G(SDOUT) N DIR S DIR(0)="E" D ^DIR
 K %,%DT,C,DIR,DIVN,DTOUT,DUOUT,SD,SDCT,SDDIV,SDDX,SDDX0,SDDXC,SDDXN,SDFF,SDI,SDII,SDIV,SDIVN,SDLINE,SDLIST,SDOE,SDOE0
 K SDX,SDORD,SDOUT,SDPAGE,SDPBDT,SDPEDT,SDPNOW,SDPR,SDPR0,SDPRC,SDPRN,SDPROC,SDPS,SDQT,SDSTOP,SDT,SDTOT,X,Y D END^SCRPW50 Q
 ;
DIV() ;Check division
 Q:'SDDIV 1  Q $D(SDDIV(+$P(SDOE0,U,11)))
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
EVAL ;Evaluate encounter
 S SDSTOP=SDSTOP+1 D:SDSTOP#3000=0 STOP Q:SDOUT
 S SDIV=+$P(SDOE0,U,11) D:"DB"[SD("TYPE") DX D:"PB"[SD("TYPE") PROC Q
 ;
DX ;Get diagnoses
 N SDLIST,SDI D GETDX^SDOE(SDOE,"SDLIST")
 S SDI=0 F  S SDI=$O(SDLIST(SDI)) Q:'SDI  D DX1(SDIV) D:SDDIV("MULT") DX1(0)
 Q
 ;
DX1(SDIV) S SDDX=+SDLIST(SDI),SDPS=$S($P(SDLIST(SDI),U,12)="P":"PRI",1:"SEC")
 F SDPS=SDPS,"QTY" S ^TMP("SCRPW",$J,SDIV,"DX",1,SDDX,SDPS)=$G(^TMP("SCRPW",$J,SDIV,"DX",1,SDDX,SDPS))+1
 Q
 ;
PROC ;Get procedures
 N SDLIST,SDI D GETCPT^SDOE(SDOE,"SDLIST")
 S SDI=0 F  S SDI=$O(SDLIST(SDI)) Q:'SDI  D PROC1(SDIV) D:SDDIV("MULT") PROC1(0)
 Q
 ;
PROC1(SDIV) S SDPROC=+SDLIST(SDI),SDQT=$P(SDLIST(SDI),U,16) S:'SDQT SDQT=1
 S ^TMP("SCRPW",$J,SDIV,"PROC",1,SDPROC,"ENC")=$G(^TMP("SCRPW",$J,SDIV,"PROC",1,SDPROC,"ENC"))+1
 S ^TMP("SCRPW",$J,SDIV,"PROC",1,SDPROC,"QTY")=$G(^TMP("SCRPW",$J,SDIV,"PROC",1,SDPROC,"QTY"))+SDQT
 ;
 ;set encounter and modifier quantity
 N SDMOD,SDMODN
 S SDMODN=0
 F  S SDMODN=$O(SDLIST(SDI,1,SDMODN)) Q:SDMODN=""  D
 . S SDMOD=$G(SDLIST(SDI,1,SDMODN,0))
 . Q:SDMOD=""
 . S ^TMP("SCRPW",$J,SDIV,"PROC",1,SDPROC,SDMOD,"ENC")=+1
 . S ^TMP("SCRPW",$J,SDIV,"PROC",1,SDPROC,SDMOD,"QTY")=+SDQT
 . Q
 Q
 ;
ORD ;Determine list order
 S SDI="" F  S SDI=$O(^TMP("SCRPW",$J,SDIV,SDI)) Q:SDI=""  S SDII=0 F  S SDII=$O(^TMP("SCRPW",$J,SDIV,SDI,1,SDII)) Q:'SDII  S ^TMP("SCRPW",$J,SDIV,SDI,2,$$ORDV(),SDII)=""
 Q
 ;
ORDV() Q ^TMP("SCRPW",$J,SDIV,SDI,1,SDII,"QTY")
 ;
DPRT(SDIV) ;Print report for a division
 ;Required input: SDIV=division ifn (or '0' for summary)
 S C=(IOM-80\2) D DHDR(3,.SDT) I '$D(^TMP("SCRPW",$J,SDIV)) S SDPAGE=1 D HDR Q:SDOUT  S SDX="No activity found for this date range!" W !!?(IOM-$L(SDX)\2),SDX Q
 I $D(^TMP("SCRPW",$J,SDIV,"DX")) D DXPRT Q:SDOUT
 I $D(^TMP("SCRPW",$J,SDIV,"PROC")) D PRPRT
 Q
 ;
DXPRT ;Print diagnosis list
 N SDTOT S SDPAGE=1 D HDR Q:SDOUT  D DXHD S (SDCT,SDORD)="" F  S SDORD=$O(^TMP("SCRPW",$J,SDIV,"DX",2,SDORD),-1) Q:SDORD=""!SDOUT!(SDCT>(SD("FREQ")-1))  D DXP1
 Q:SDOUT  D:$Y>(IOSL-4) HDR,DXHD Q:SDOUT
 W !?(C),$E(SDLINE,1,7),?(C+9),$E(SDLINE,1,35),?(C+46),$E(SDLINE,1,10),?(C+58),$E(SDLINE,1,10),?(C+70),$E(SDLINE,1,10)
 W !?(C),"TOTAL:",?(C+46),$J(SDTOT("PRI"),9,0),?(C+58),$J(SDTOT("SEC"),9,0),?(C+70),$J(SDTOT("QTY"),9,0)
 Q
 ;
DXP1 S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,SDIV,"DX",2,SDORD,SDI)) Q:'SDI!SDOUT!(SDCT>(SD("FREQ")-1))  S SDDX0=$$ICDDX^SCRPWICD(SDI) I $L(SDDX0) S SDDXC=$P(SDDX0,U,2),SDDXN=$P(SDDX0,U,4) D DXP2
 Q
 ;
DXP2 N DIWL,DIWF,SDL2 S DIWL=1 S DIWF="C35|"
 F SDII="PRI","SEC","QTY" S SDDX(SDII)=+$G(^TMP("SCRPW",$J,SDIV,"DX",1,SDI,SDII))
 D:$Y>(IOSL-4) HDR,DXHD Q:SDOUT  S SDCT=SDCT+1
 K ^UTILITY($J,"W") S X=SDDXN D ^DIWP
 F SDL2=1:1:^UTILITY($J,"W",DIWL) D
 . I SDL2=1 W !?(C),SDDXC,?(C+9),$E(^UTILITY($J,"W",DIWL,SDL2,0),1,35) I 1
 . E  W !,?(C+9),$E(^UTILITY($J,"W",DIWL,SDL2,0),1,35)
 W ?(C+46),$J(SDDX("PRI"),9,0),?(C+58),$J(SDDX("SEC"),9,0),?(C+70),$J(SDDX("QTY"),9,0)
 F SDII="PRI","SEC","QTY" S SDTOT(SDII)=$G(SDTOT(SDII))+SDDX(SDII)
 Q
 ;
PRPRT N SDTOT S C=(IOM-62\2),SDPAGE=1 D HDR Q:SDOUT  D PRHD S (SDCT,SDORD)="" F  S SDORD=$O(^TMP("SCRPW",$J,SDIV,"PROC",2,SDORD),-1) Q:SDORD=""!SDOUT!(SDCT>(SD("FREQ")-1))  D PRP1
 Q:SDOUT  D:$Y>(IOSL-4) HDR,PRHD Q:SDOUT
 W !?(C),$E(SDLINE,1,6),?(C+8),$E(SDLINE,1,28),?(C+38),$E(SDLINE,1,10),?(C+50),$E(SDLINE,1,10),!?(C),"PROCEDURE TOTAL:",?(C+38),$J(SDTOT("ENC"),9,0),?(C+50),$J(SDTOT("QTY"),9,0)
 Q
 ;
PRP1 ;S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,SDIV,"PROC",2,SDORD,SDI)) Q:'SDI!SDOUT!(SDCT>(SD("FREQ")-1))  S SDPR0=$G(^ICPT(SDI,0)) I $L(SDPR0) S SDPRC=$P(SDPR0,U),SDPRN=$P(SDPR0,U,2) D PRP2
 N CPTINFO
 S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,SDIV,"PROC",2,SDORD,SDI)) Q:'SDI!SDOUT!(SDCT>(SD("FREQ")-1))  D 
 . S CPTINFO=$$CPT^ICPTCOD(SDI,,1)
 . Q:CPTINFO'>0
 . S SDPRC=$P(CPTINFO,U,2)
 . S SDPRN=$P(CPTINFO,U,3)
 . D PRP2
 . Q
 Q
 ;
PRP2 F SDII="ENC","QTY" S SDPR(SDII)=+$G(^TMP("SCRPW",$J,SDIV,"PROC",1,SDI,SDII))
 D:$Y>(IOSL-4) HDR,PRHD Q:SDOUT  S SDCT=SDCT+1
 ; skip a line in the report if printing next cpt code on same page
 I LINEFLAG W !
 W !?(C),SDPRC,?(C+8),SDPRN,?(C+38),$J(SDPR("ENC"),9,0),?(C+50),$J(SDPR("QTY"),9,0)
 S LINEFLAG=1
 F SDII="ENC","QTY" S SDTOT(SDII)=$G(SDTOT(SDII))+SDPR(SDII)
 ;
 ;rank and print the modifiers
 D START^SCRPW401($NA(^TMP("SCRPW",$J,SDIV,"PROC",1,SDI)))
 Q
 ;
PRHD ;Print procedure subheader
 S LINEFLAG=0 Q:SDOUT  W !!?(C),"CODE",!?(C),"NUMBER",?(C+8),"PROCEDURE/MODIFIER",?(C+38),"ENCOUNTERS",?(C+52),"QUANTITY",!?(C),$E(SDLINE,1,6),?(C+8),$E(SDLINE,1,28),?(C+38),$E(SDLINE,1,10),?(C+50),$E(SDLINE,1,10)
 Q
 ;
DXHD ;Print diagnosis subheader
 Q:SDOUT  W !!?(C),"CODE",?(C+49),"PRIMARY",?(C+59),"SECONDARY",?(C+75),"TOTAL",!?(C),"NUMBER",?(C+9),"DIAGNOSIS",?(C+47),"DIAGNOSIS",?(C+59),"DIAGNOSIS",?(C+71),"FREQUENCY"
 W !?(C),$E(SDLINE,1,7),?(C+9),$E(SDLINE,1,35),?(C+46),$E(SDLINE,1,10),?(C+58),$E(SDLINE,1,10),?(C+70),$E(SDLINE,1,10) Q
 ;
HDR ;Print report header
 I $E(IOST)="C",SDFF N DIR S DIR(0)="E" W ! D ^DIR S SDOUT=Y'=1 Q:SDOUT
 D STOP Q:SDOUT
 I SDFF!($E(IOST)="C") W $$XY^SCRPW50(IOF,1,0)
 I $X W $$XY^SCRPW50("",0,0)
 N SDI W SDLINE S SDI=0 F  S SDI=$O(SDT(SDI)) Q:'SDI  W !?(IOM-$L(SDT(SDI))\2),SDT(SDI)
 W !,SDLINE,!,"For date range: ",SDPBDT," to ",SDPEDT,!,"Date printed: ",SDPNOW,?(IOM-6-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE S SDPAGE=SDPAGE+1,SDFF=1 Q
 ;
DHDR(SDI,SDT) ;Set up division subheaders
 ;Required input: SDI=array number to start with
 ;Required input: SDT=array to store subheaders in (pass by reference)
 S SDT(SDI)=$S('SDIV:"Summary for "_$P(SDDIV,U,2),SDDIV!($P(SDDIV,U,2)="ALL DIVISIONS"):"For division: "_SDIVN,1:"For facility: "_SDIVN)
 I 'SDIV,$P(SDDIV,U,2)="SELECTED DIVISIONS" N SDIVN S SDIVN="" D  Q
 .F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""  S SDI=SDI+1,SDT(SDI)="Division: "_SDIVN
 .Q
 I 'SDIV,$P(SDDIV,U,2)="ALL DIVISIONS" D
 .N SDIV S SDIV=0 F  S SDIV=$O(^TMP("SCRPW",$J,SDIV)) Q:'SDIV  S SDI=SDI+1,SDT(SDI)="Division: "_$P($G(^DG(40.8,SDIV,0)),U)
 .Q
 Q
