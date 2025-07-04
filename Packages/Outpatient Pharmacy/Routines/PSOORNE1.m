PSOORNE1 ;BIR/SAB - Display new orders from backdoor ;Jun 09, 2021@15:24:21
 ;;7.0;OUTPATIENT PHARMACY;**11,21,27,32,37,46,71,94,104,117,133,148,279,251,372,313,422,441,787**;DEC 1997;Build 3
 ;External reference to ^PS(55 is supported by DBIA 2228
EN(PSONEW) D DSPL^PSOORNE3,^PSOLMPO2
 Q
EDT N FLD,FIELDLST K DIR,DUOUT,DIRUT S DIR("A")="Select Field to Edit by number",DIR(0)="LO^1:14" D ^DIR I $D(DTOUT)!($D(DUOUT)) K DIR,DIRUT,DTOUT,DTOUT S VALMBCK="" Q
EDTSEL S:'$G(COPY) PSOEDIT=1 S (PSONEW("DFLG"),PSONEW("FIELD"),PSONEW3)=0
 I +Y S FIELDLST=Y D HLDHDR^PSOLMUTL D  Q:$G(PSORX("DFLG"))!($G(PSORX("QFLG")))  S VALMBCK="R" G DSPL^PSOORNE3
 .F FLD=1:1:$L(FIELDLST,",") Q:$P(FIELDLST,",",FLD)']""  D @(+$P(FIELDLST,",",FLD)) Q:$G(PSODIR("DFLG"))!($G(PSODIR("QFLG")))
 E  S VALMBCK="" D FULL^VALM1
 D RDSPL G DSPL^PSOORNE3
 Q
ACP K VALMSG,DIR,PSORX("DFLG") D VER I $G(PSONEW2("QFLG"))!($G(PSORX("DFLG"))) S VALMBCK="Q" K PSONEW2 Q
 N PSONOBCK S PSONOBCK=$S($G(PSOSIGFL):1,1:0)
 D NOOR^PSONEW I $D(DIRUT) S PSONEW("DFLG")=1 K DIR,X,Y,DIRUT,DUOUT,DTOUT Q
 D RXNCHK,RDSPL
 I $G(PSONEW("QFLG")) S PSONEW("DFLG")=1 K DIR,X,Y,DIRUT,DUOUT,DTOUT Q
 D DISPLAY^PSONEW2
 D ^PSONEWG I $G(PSOCPZ("DFLG")) S PSONEW("DFLG")=1 K PSOANSQ,DIR,X,Y,DIRUT,DUOUT,DTOUT,PSOCPZ("DFLG"),PSOANSQD Q
 K PSOCPZ("DFLG")
 K DIR,DIRUT,X,Y S DIR(0)="Y",DIR("B")="YES",DIR("A")="Is this correct" D ^DIR
 I $D(DIRUT) S PSONEW("DFLG")=1 K PSOANSQ,PSOANSQD,DIR,X,Y,DIRUT,DUOUT,DTOUT Q
 I 'Y S VALMBCK="R" K PSOANSQ,DIR,X,Y,DIRUT,DUOUT,DTOUT D DSPL^PSOORNE3 Q
 W "..." K PSOANSQD,DIR,X,Y,DIRUT,DUOUT,DTOUT D DCORD^PSONEW2
 I $G(NCPDPFLG) D NCPDP^PSOORED6
 K:$G(COPY)!($G(PSOSIGFL)) PRC,PHI
 S:'$G(PSOID) PSOID=DT S (PSORX("FN"),PSONEW("POE"))=1 D EN^PSON52(.PSONEW) ; Files entry in File 52
 ;
 ; - Possible Titration prescription
 I $G(PSONEW("IRXN")) D MARK^PSOOTMRX(PSONEW("IRXN"),0)
 ;
 I $G(PSOBEDT) D
 .I '$D(^TMP("PSOBEDT",$J,PSODFN,0)) S ^TMP("PSOBEDT",$J,PSODFN,0)=PSORXED("IRXN") S:$G(PSONEW("MAIL/WINDOW"))["W" ^TMP("PSOBEDT",$J,PSODFN,1)=1 Q
 .S ^TMP("PSOBEDT",$J,PSODFN,0)=^TMP("PSOBEDT",$J,PSODFN,0)_","_PSORXED("IRXN")
 .I $G(PSONEW("MAIL/WINDOW"))["W" S ^TMP("PSOBEDT",$J,PSODFN,1)=1
 D NPSOSD^PSOUTIL(.PSONEW) ; Adds newly added rx to PSOSD array
 D ^PSOBUILD S VALMBCK="Q"
 K PSONEW("# OF REFILLS"),PSONEW("DAYS SUPPLY"),SDA,SEG1,SSN1,STA,Z4,ZDA
 Q:$G(COPY)  S PSONEW("DFLG")=0
 Q
VER I $G(PSOAC),$G(PSODRUG("NAME"))']"" D FULL^VALM1,2^PSOORNW1
 I $G(PSODRUG("NAME"))']"" S VALMSG="A Dispense Drug Must be Chosen!" S PSONEW2("QFLG")=1 Q
 I '$G(PSONEW("ENT")) W !,"Dosing Instruction Missing!!",! D  I PSONEW("DFLG")=1 S PSONEW2("QFLG")=1 Q
 .S PSOORRNW=1
 .K VALMSG D FULL^VALM1 W !,"Drug: "_PSODRUG("NAME")
 .I $O(SIG(0)) F I=1:1 Q:$G(SIG(I))']""  W !,SIG(I)
 .E   I $G(^PSRX(PSONEW("OIRXN"),"SIG"))]"" S X=$P(^PSRX(PSONEW("OIRXN"),"SIG"),"^") D SIGONE^PSOHELP W !,$E($G(INS1),2,250)
 .W ! D 5 K PSOORRNW I PSONEW("DFLG")=1 D M3 Q
 .D 6 D:PSONEW("DFLG")=1 M3
 D:$G(COPY) PROV^PSOUTIL(.PSORENW) I $G(PSONEW("DFLG"))=1 S PSONEW2("QFLG")=1 Q
 N PSODOSD D FULL^VALM1,POST^PSODRG:'$G(PSOSIGFL)
 I $G(POERR("DFLG"))=1 S (PSONEW("DFLG"),PSONEW2("QFLG"))=1 Q
 I $G(PSODOSD) S (PSONEW("DFLG"),PSONEW2("QFLG"))=1 Q
 D:'$G(PSORX("DFLG")) DOSCK^PSODOSUT("N") K PSONOOR I $G(PSORX("DFLG")) S VALMBCK="Q" Q
 I +$G(PSEXDT) D
 .D FULL^VALM1 S:$G(PSONEW("MAIL/WINDOW"))["W" BINGCRT="Y",BINGRTE="W"
 .D:+$G(PSEXDT)
 ..S Y=PSONEW("FILL DATE") X ^DD("DD") W !!,$C(7),Y_" fill date is greater than possible expiration date of " S Y=$P(PSEXDT,"^",2) X ^DD("DD") W Y_"."
 .S PSONEW2("QFLG")=1,VALMBCK="R" D PAUSE^VALM1
 Q
1 I $G(PSOSIGFL)!$G(PSOMTFLG) D  Q
 . S PSOAC=1 D 2^PSOORNW1 D:'$G(PSORX("DFLG")) 10^PSOBKDED,MW K PSOAC Q:$G(PSORX("DFLG"))  D RDSPL D DSPL^PSOORNE3
 . I $G(PSOMTFLG),$G(PSORXED("DRUG IEN"))'=$G(PSODRUG("IEN")) D
 . . I FIELDLST'["5," D 5 Q:$G(PSODIR("DFLG"))!($G(PSODIR("QFLG")))
 . . I FIELDLST'["6," D 6 Q:$G(PSODIR("DFLG"))!($G(PSODIR("QFLG")))
 . . I FIELDLST'["8," D 8 Q:$G(PSODIR("DFLG"))!($G(PSODIR("QFLG")))
 ;
 D 6^PSOBKDED,MW
 D RDSPL G DSPL^PSOORNE3 Q
 ;
MW I PSONEW("MAIL/WINDOW")="P",$G(PSODRUG("DEA"))["D" D
 .W !!,"This drug cannot be Parked! You must select a different routing!"
 .D 12^PSOBKDED
 Q
 ;
2 D 3^PSOBKDED Q
 ;
3 D 1^PSOBKDED Q
 ;
4 D 2^PSOBKDED Q
 ;
5 I '$G(PSODRUG("IEN")) W !,"DRUG NAME REQUIRED!" D 2^PSOORNW1 I '$G(PSODRUG("IEN")) S VALMSG="No Dispense Drug Selected" Q
 ;PSO787 only go into 10^PSOBKDED if editing field 5
 I FIELDLST["5," W !!,"Drug: "_PSODRUG("NAME") D 10^PSOBKDED Q
 Q
 ;
6 ;D INS^PSOBKDED Q:$G(PSONEW("DFLG"))  I $P($G(^PS(55,PSODFN,"LAN")),"^") D SINS^PSODIR(.PSONEW)  ;*422
 N PSOINSCH,PSODELINS
 S:'$D(PSOOEINS) PSOOEINS=$G(PSONEW("INS")) S:'$D(PSOOSINS) PSOOSINS=$G(PSONEW("SINS")) S:'$D(PSOOEIND) PSOOEIND=$G(PSONEW("IND")) S:'$D(PSOOINDF) PSOOEINDF=$G(PSONEW("INDF"))
 I '$P($G(^PS(55,PSODFN,"LAN")),"^") D INS^PSOBKDED Q:$G(PSONEW("DFLG"))
 I $P($G(^PS(55,PSODFN,"LAN")),"^") D
 .N PSODONE S (PSODONE,PSODELINS)=0
 .F  D  I PSODONE Q:$G(PSONEW("DFLG"))  D SIND^PSODIR(.PSONEW) Q
 ..K PSONEW("DFLG")
 ..D INS^PSOBKDED
 ..I '$G(PSONEW("DFLG")),'PSODONE,'$G(PSODELINS) D SINS^PSODIR(.PSONEW)
 ..;POSS NOT NEEDED;I $G(PSONEW("DFLG")) S PSODONE=1,(PSONEW("SIG"),PSONEW("INS"))=$G(PSOOEINS),PSONEW("SINS")=$G(PSOOSINS) K PSONEW("SIG") D EN^PSOFSIG(.PSONEW,1) Q
 ..I $G(PSONEW("DFLG")) S (X,Y)=$G(PSONEW("INS")) D SIG^PSOHELP S (PSONEW("SIG",1),PSONEW("SIG"))=$E($G(INS1),2,9999999) K X,Y S PSODONE=1 Q
 ..S PSOINSCH=$$INSCHK^PSOHELP3(.PSONEW)
 ..I '$G(PSOINSCH) S PSODONE=1
 ;
 K PSOOEINS,PSOOSINS,PSOOEIND,PSOOEINDF
 Q
 ;
7 D 8^PSOBKDED Q
 ;
8 D 7^PSOBKDED Q
 ;
9 D 9^PSOBKDED Q
 ;
10 D 12^PSOBKDED Q
 ;
11 D 5^PSOBKDED Q
 ;
12 D 4^PSOBKDED Q
 ;
13 D 11^PSOBKDED Q
 ;
14 D 13^PSOBKDED Q
 ;
15 Q
 ;D 14^PSOBKDED Q
 ;
SUMM ;print break down of orders to be finished
 K ^TMP($J,"PSOCZT"),^TMP($J,"PSODPAT"),PAT,RT,DIR,DUOUT,DIRUT,PSZLQUIT
 S DIR("A")="Do you want an Order Summary",DIR(0)="Y",DIR("B")="No"
 D ^DIR K DIR I 'Y!($D(DIRUT)) K Y,X,DIRUT Q
 K PSOINPRT,DIQ,^UTILITY("DIQ1",$J) I $G(PSOPINST) S DA=PSOPINST,DIC=4,DIQ(0)="E",DR=".01" D EN^DIQ1 S PSOINPRT=$G(^UTILITY("DIQ1",$J,4,DA,.01,"E")) K ^UTILITY("DIQ1",$J),DA,DR,DIC,DIQ
 I $D(^PS(52.41,"ACL")) N PSOCLSUM D SUMMCL I $G(PSOCLSUM) K PSOINPRT Q
 F PSI=0:0 S PSI=$O(^PS(52.41,"AOR",PSI)) Q:'PSI  F PSID=0:0 S PSID=$O(^PS(52.41,"AOR",PSI,PSID)) Q:'PSID  F PIN=0:0 S PIN=$O(^PS(52.41,"AOR",PSI,PSID,PIN)) Q:'PIN  D
 .I '$D(^TMP($J,"PSOCZT",PSID,"PAT")) F PZA="PAT","WIN","MAIL","CLIN","PARK" S ^TMP($J,"PSOCZT",PSID,PZA)=0  ;441 PAPI
 .I '$D(^TMP($J,"PSODPAT",PSID,PSI)) S ^TMP($J,"PSODPAT",PSID,PSI)=1,^TMP($J,"PSOCZT",PSID,"PAT")=^TMP($J,"PSOCZT",PSID,"PAT")+1
 .;441 PAPI
 .S PZROUT=$P($G(^PS(52.41,PIN,0)),"^",17) I PZROUT'="" S ^TMP($J,"PSOCZT",PSID,$S(PZROUT="C":"CLIN",PZROUT="M":"MAIL",PZROUT="P":"PARK",1:"WIN"))=^TMP($J,"PSOCZT",PSID,$S(PZROUT="C":"CLIN",PZROUT="M":"MAIL",PZROUT="P":"PARK",1:"WIN"))+1
 W @IOF W !?20,"Pending Outpatient Medication Orders",! I $G(PSZCNT)>1 W ?20,"(signed in under "_$G(PSOINPRT)_")",!
 F PSOINL=0:0 S PSOINL=$O(^TMP($J,"PSOCZT",PSOINL)) Q:'PSOINL!($G(PSZLQUIT))  D
 .I ($Y+6)>IOSL K DIR S DIR(0)="E" D ^DIR K DIR D:$G(Y)  I '$G(Y) S PSZLQUIT=1 W ! Q
 ..W @IOF W !?20,"Pending Outpatient Medication Orders",! I $G(PSZCNT)>1 W ?20,"(signed in under "_$G(PSOINPRT)_")",!
 .K ^UTILITY("DIQ1",$J),DIQ,PSOINPRX S DA=$G(PSOINL),DIC=4,DIQ(0)="E",DR=".01" D EN^DIQ1 S PSOINPRX=$G(^UTILITY("DIQ1",$J,4,DA,.01,"E")) K ^UTILITY("DIQ1",$J),DA,DR,DIC,DIQ
 .;PSO*7*279 Change division to Institution
 .W !,"Institution: ",$G(PSOINPRX)
 .W !,"Patients: "_$G(^TMP($J,"PSOCZT",PSOINL,"PAT"))_"  Window: "_$G(^("WIN"))_"  Mail: "_$G(^("MAIL"))_"  Clinic: "_$G(^("CLIN"))_"  Park: "_$G(^("PARK")),!  ;441 PAPI
 K DIR S DIR(0)="E",(DIR("A"),DIR("?"))="Press Return to Continue" D ^DIR K DIR
 K ^TMP($J,"PSOCZT"),^TMP($J,"PSODPAT"),RT,PSOINPRT,PSOINPRX,PSI,PSID,PIN,PZA,PZROUT,PSOINL,PSZLQUIT
 Q
SUMMCL ;
 ;PSO*7*279 Change Division to Institution
 W ! K DIR S DIR(0)="SMB^I:INSTITUTION;C:CLINIC",DIR("A")="Do you want the summary by Institution or Clinic",DIR("B")="Institution",DIR("?")=" "
 S DIR("?",1)="Enter 'I' to see the summary by Institution, and within Institution the orders",DIR("?",2)="shown by Mail, Window, or Administered in Clinic.",DIR("?",3)="Enter 'C' to see the summary by Clinic, along with Clinic Sort Groups."
 D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S PSOCLSUM=1 Q
 Q:$G(Y)="I"
 S PSOCLSUM=1
 K ^TMP($J,"PSOLOC"),^TMP($J,"PSOLOCP") N PSCX,PSCXL,PSLX,PSCIN,PSCPT,PSCNDE,PSNCL,PSNPAT,PSCLOUT,PSCSFLAG,PCCNT,PSOCAG
 F PSCX=0:0 S PSCX=$O(^PS(52.41,"ACL",PSCX)) Q:'PSCX  F PSLX=0:0 S PSLX=$O(^PS(52.41,"ACL",PSCX,PSLX)) Q:'PSLX  F PSCIN=0:0 S PSCIN=$O(^PS(52.41,"ACL",PSCX,PSLX,PSCIN)) Q:'PSCIN  S PSCPT=+$P($G(^PS(52.41,PSCIN,0)),"^",2) D:PSCPT
 .S PSCNDE=$G(^PS(52.41,PSCIN,0))
 .I $P(PSCNDE,"^",3)'="NW",$P(PSCNDE,"^",3)'="RNW",$P(PSCNDE,"^",3)'="RF" Q
 .I $P(PSCNDE,"^",13)="" Q
 .S PSNCL=+$P(PSCNDE,"^",13),PSNPAT=+$P(PSCNDE,"^",2)
 .I '$D(^TMP($J,"PSOLOC",PSNCL)) S ^TMP($J,"PSOLOC",PSNCL)="1^1",^TMP($J,"PSOLOCP",PSNCL,PSNPAT)="" Q
 .S $P(^TMP($J,"PSOLOC",PSNCL),"^",2)=$P(^TMP($J,"PSOLOC",PSNCL),"^",2)+1
 .I '$D(^TMP($J,"PSOLOCP",PSNCL,PSNPAT)) S $P(^TMP($J,"PSOLOC",PSNCL),"^")=$P(^TMP($J,"PSOLOC",PSNCL),"^")+1
 .S ^TMP($J,"PSOLOCP",PSNCL,PSNPAT)=""
 I '$O(^TMP($J,"PSOLOC",0)) G SUMMQ
 W @IOF W !?20,"Pending Outpatient Medication Orders" I $G(PSZCNT)>1 W !?20,"(signed in under "_$G(PSOINPRT)_")"
 F PSCXL=0:0 S PSCXL=$O(^TMP($J,"PSOLOC",PSCXL)) Q:'PSCXL!($G(PSCLOUT))  D
 .I ($Y+7)>IOSL D CLDIR Q:$G(PSCLOUT)
 .W !!,"Clinic:   ",$P($G(^SC(+PSCXL,0)),"^")
 .W !,"Patients: ",$P($G(^TMP($J,"PSOLOC",PSCXL)),"^"),?16,"Orders: ",$P($G(^TMP($J,"PSOLOC",PSCXL)),"^",2)
 .W !,"In Sort Groups:"
 .S (PCCNT,PSCSFLAG)=0 F PSCSORT=0:0 S PSCSORT=$O(^PS(59.8,PSCSORT)) Q:'PSCSORT!($G(PSCLOUT))  I $D(^PS(59.8,PSCSORT,1,"B",PSCXL)) S PSOCAG=0 D
 ..S PSCSFLAG=1 S:($Y+5)>IOSL&(PCCNT) PSOCAG=1 D:($Y+5)>IOSL&(PCCNT) CLDIR Q:$G(PSCLOUT)  W:$G(PSOCAG) !,"Clinic: "_$P($G(^SC(PSCXL,0)),"^")_"   cont." W:$G(PCCNT)>0 ! W ?16,$P($G(^PS(59.8,PSCSORT,0)),"^") S PCCNT=1
 .I '$G(PSCSFLAG) W ?16,"*** NO CLINIC SORT GROUPS ***"
 I '$G(PSCLOUT) K DIR S DIR(0)="E",(DIR("A"),DIR("?"))="Press Return to continue"  D ^DIR K DIR
SUMMQ K ^TMP($J,"PSOLOC"),^TMP($J,"PSOLOCP")
 Q
CLDIR K DIR S DIR(0)="E",(DIR("A"),DIR("?"))="Press Return to continue, '^' to exit" D ^DIR K DIR I Y'=1 S PSCLOUT=1 Q
 W @IOF
 Q
RXNCHK I $G(PSONEW("RX #"))']"" D RXNCHK^PSOORNE5
 Q
RDSPL D RDSPL^PSOORNE5
 Q
M3 D M3^PSOOREDX
 Q
