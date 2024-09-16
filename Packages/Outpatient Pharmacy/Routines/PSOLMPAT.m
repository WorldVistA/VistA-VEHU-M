PSOLMPAT ;BIR/SAB - update pharmacy patient data using listman ;Dec 09, 2021@14:00
 ;;7.0;OUTPATIENT PHARMACY;**15,117,149,233,268,468,622,441,753**;DEC 1997;Build 53
 ;External reference ^PS(55 supported by DBIA 2228
 ;
EN I '$D(PSOPAR) D ^PSOLSET I '$D(PSOPAR) S VALMSG="Site Parameters must be Defined!" G EX
 D HLDHDR^PSOLMUTL S DA=DFN,PI=""
 I '$P($G(PSOPAR),"^",22),'$D(^XUSEC("PSO ADDRESS UPDATE",+$G(DUZ))) G P55
 L +^PS(55,DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T D MSG G EX
 S PSODFN=DA D UPDATE^PSOBAI S DA=PSODFN
 W !
 L +^DPT(DA):$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T D MSG G EX
 S DIE="^DPT(",DR="[PSO OUTPT]"
 D FULL^VALM1,^DIE L -^DPT(DA)
P55 ;
 N MAIL55BF
 S MAIL55BF=$$GET1^DIQ(55,PSODFN,.03,"I")
 I '$D(^PS(55,PSODFN)) K DIC S DIC="^PS(55,",DIC(0)="LZ",(X,DINUM)=DFN K DD,DO D FILE^DICN K DIC
 I $G(DFN),$P($G(^PS(55,DFN,0)),"^")="" S $P(^PS(55,DFN,0),"^")=DFN K DIK S DA=DFN,DIK="^PS(55,",DIK(1)=.01 D EN^DIK K DIK S DA=DFN
 S DIE="^PS(55,",DR=".02;.03" W !!?5,">>PHARMACY PATIENT DATA<<",! D ^DIE
 D MAIL55(PSODFN,MAIL55BF) ;display prescriptions with deleted exemptions
 S DIE="^PS(55,",DR=".05;.04;1;3;40:41.1;106;106.1" D ^DIE
 I $D(PSORX("PATIENT STATUS")) D   ;468 Update PSORX with the current status
 . S PSORX("PATIENT STATUS")=$P($G(^PS(55,DA,"PS")),"^")
 . I PSORX("PATIENT STATUS")]"" S PSORX("PATIENT STATUS")=$P($G(^PS(53,PSORX("PATIENT STATUS"),0)),"^")
EX L -^PS(55,DA),-^DPT(DA)
 D ^PSOORUT2 S VALMBCK="R"
 K DIC,X,Y,DIE,D0,DA,DFN,PI,DR,%,%Y,%X,C,DI,DIPGM,DQ,PSOFROM
 Q
MSG S VALMSG="Patient Data is Being Edited by Another User!" Q
PLST ;PREGNANCY & LACTATION STATUS DISPLAY
 N PSOVAL,PSOHSTYPE,PSOTYPE
 S PSOVAL=$G(^TMP("PSOHDR",$J,14,0))
 I PSOVAL="" D  Q
 .W !!,"This patient is not pregnant and is not lactating."
 .D WAIT^VALM1
 K ^TMP("DIERR",$J)
 S PSOTYPE("P")="VA-WH PREGNANCY STATUS",PSOTYPE("L")="VA-WH LACTATION STATUS"
 S PSOTYPE("PL")="VA-WH PREG & LAC STATUS",PSOTYPE("LP")=PSOTYPE("PL")
 I $D(PSOTYPE(PSOVAL)) D
 .S PSOHSTYPE=$$FIND1^DIC(142,,"X",PSOTYPE(PSOVAL))
 .I +PSOHSTYPE=0 D  Q
 ..W !!,"Could not find the "_PSOTYPE(PSOTYPE)_" health summary type."
 ..I $D(^TMP("DIERR",$J)) W ! D MSG^DIALOG() K ^TMP("DIERR",$J)
 ..D WAIT^VALM1
 .D ENX^GMTSDVR(PSODFN,PSOHSTYPE)
 Q
 ;
MAIL55(PSODFN,MAIL55BF) ;entry for mail exemption delete
 ;called from the screen of the PHARMACY PATIENT file (#55), MAIL field (#.03)
 ;PSODFN - Patient IEN
 ;MAIL55BF - Old value of the PHARMACY PATIENT file (#55) field MAIL (#.03)
 I '$D(PSODFN) Q
 N RXIEN,STA,DRUG,X1,X2,PSODTCUT,MAIL55EX,MAIL55AF,FLG,X,Y,%E
 S MAIL55AF=$$GET1^DIQ(55,PSODFN,.03,"I")
 I MAIL55BF=MAIL55AF Q
 S FLG=0
 S X2=-120,X1=DT D C^%DTC S PSODTCUT=X ;date cutoff for prescriptions
 S MAIL55EX=$S(MAIL55AF="":"REGULAR MAIL",MAIL55AF=0:"REGULAR MAIL",MAIL55AF=1:"CERTIFIED MAIL",MAIL55AF=2:"DO NOT MAIL",MAIL55AF=3:"LOCAL - REGULAR",MAIL55AF=4:"LOCAL - CERTIFIED",1:"")
 S STA="" F  S STA=$O(PSOSD(STA)) Q:STA=""  I "^ACTIVE^NON-VERIFIED^REFILL^HOLD^DRUG INTERACTIONS^SUSPENDED^"[STA D
 .S DRUG="" F  S DRUG=$O(PSOSD(STA,DRUG)) Q:DRUG=""  D
 ..S RXIEN=+PSOSD(STA,DRUG)
 ..I $$GET1^DIQ(52,RXIEN,100.2)']"" Q
 ..I FLG=0 D  S FLG=1
 ...D FULL^VALM1
 ...W !!,"The patient-level MAIL preference has been changed to "_$S(MAIL55EX="":"NULL",1:MAIL55EX)_"."
 ...W !,"Exemptions set on the following prescriptions will be removed."
 ...W !,"Edit these prescriptions to reinstate the exemptions if necessary."
 ...W !
 ..W !,"   ",$$GET1^DIQ(52,RXIEN,.01),?16,$$GET1^DIQ(52,RXIEN,6),?60,$$GET1^DIQ(52,RXIEN,100.2)
 ..S FDA(52,RXIEN_",",100.2)="" D FILE^DIE(,"FDA","MSG") ;delete mail exemption
 ..D RXACT^PSOBPSU2(RXIEN,,"Mail Exemption automatically deleted with patient level preference update.","E") ;file activity log
 D ^PSOBUILD,BLD^PSOORUT1
 W ! K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to Continue"
 D ^DIR K DIR,X,Y
 Q
 ;
