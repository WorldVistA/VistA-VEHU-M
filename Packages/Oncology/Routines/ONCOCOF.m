ONCOCOF ;HINES OIFO/GWB - [RS Registry Summary Reports - Follow Up] ;06/23/10
 ;;2.2;ONCOLOGY;**1,13,17**;Jul 31, 2013;Build 6
 ;
FR ;[RS Registry Summary Reports - Follow Up]
 N AA,AB,AC,AD,AE,AF,AG,AN,AS,BEH,CC,MO,ONCODF,PA,PB,PC,PD,PE,PL,PP,PSFC
 N SFC,SITECODE,SITENAME,SUMSTG,T,VV,P100,ONCFDT,ROLDT
 S DIC=164.2,DIC(0)="O"
 D ^DIC K DIC,X
 K ^TMP($J)
 S (T,AB,AC,AD,AS,AF,AN,AA,CC,P100,AE)=0
 D TOTCASE
 S CC=AA
 S X0=0 F  S X0=$O(^TMP($J,X0)) Q:X0'>0  D
 .S ST=$P($G(^ONCO(165.5,X0,0)),U)
 .S MO=$$HIST^ONCFUNC(X0)
 .S DATEDX=$P($G(^ONCO(165.5,X0,0)),U,16)
 .D SUB
 S (AB,AC,AE,AF)=0
 S X0=0 F  S X0=$O(^TMP($J,X0)) Q:X0'>0  S PP=$P(^ONCO(165.5,X0,0),U,2),VV=$G(^ONCO(160,PP,1)),ONCODF=$P(VV,U,2),AS=$P(VV,U,7),VV=$P(VV,U) D F
 S T=CC-AF-P100 ;patch #17, total cases minus foreign res minus pat > 100 y/o
 S FR=T_U_AB_U_AC_U_AS
 S SFC=AB+AD,AC=T-AB,AE=AC-AD
 I T S PB=$J(AB/T,0,2)*100,PL=$J(AE/T,0,2)*100
 E  S (PB,PC,PL)="N/A" ;avoid division by zero
 I T S PC=$J(AC/T,0,2)*100
 E  S PC="N/A" ;avoid division by zero
 I T S PA=$J(AE/T,0,2)*100
 E  S PA="N/A"
 ;S AD=AD-AB-AF-P100
 I T S PD=$J(AD/T,0,2)*100
 E  S PD="N/A"
 S SFC=AB+AD
 I T S PSFC=$J(SFC/T,0,2)*100  ;avoid division by zero
 E  S PSFC="N/A"
 S AE=AC-AD
 I T S PE=$J(AE/T,0,2)*100
 E  S PE="N/A"
 S FR=FR_U_AF_U_AN_U_AA_U_AB_U_AC_U_PC_U_PB_U_AD_U_PD_U_AE_U_PE_U_PA_U_PL_U_SFC_U_PSFC_U_CC_U_P100
 S AS=$O(^ONCO(160.1,"C",DUZ(2),0))
 I AS="" S AS=$O(^ONCO(160.1,0))
 S ^ONCO(160.1,AS,"FR")=FR
 N IOPH
 I ONCOS("F")=1 S DIC=160.2,DIC(0)="",X="FOLLOWUP RATE REPORT 1" D ^DIC K DIC,X
 I ONCOS("F")=2 S DIC=160.2,DIC(0)="",X="FOLLOWUP RATE REPORT" D ^DIC K DIC,X
 S IOP=ION
 S DIWF="^ONCO(160.2,"_(+Y)_",1,",DIWF(1)="160.1"
 S BY="NUMBER"
 S (FR,TO)=$O(^ONCO(160.1,"C",DUZ(2),0))
 I FR="" S (FR,TO)=$O(^ONCO(160.1,0))
 W !!
 D EN2^DIWF K DIWF,BY,FR,TO S IOP=ION D ^%ZIS
 I $E(IOST,1,2)="C-" W ! K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue" D ^DIR ; I 'Y S EX=U Q
 K EROLDT,SROLDT,COCDATE,PA,PB,PC,PD,PE,PL,X0
 Q
 ;
TOTCASE ;AA = Analytic (CLASS OF CASE 00-22)
 ;AN = Non-analytic (CLASS OF CASE 23-99)
 N COC,DATEDX,EOF,MINUS5,ONCOPARS,REFDATE,VASITE,XD0,XD1,ONCOCDT,ONCORDT,ONCOCOC,ONCOCDTP,ONCORDTP
 S VASITE=$O(^ONCO(160.1,"C",DUZ(2),0))
 I VASITE="" S VASITE=$O(^ONCO(160.1,0))
 S (ONCOCDT,ONCOCDTP,ONCORDTP,ONCORDT,SROLDT,EROLDT)=""
 S ONCOCOC=$G(^ONCO(160.1,VASITE,7))
 S (ROLDT,ONCOCDT,COCDATE)=$P(ONCOCOC,U,3)
 S:$G(COCDATE) ONCOCDTP=$E(ONCOCDT,4,5)_"/"_$E(ONCOCDT,6,7)_"/"_($E(ONCOCDT,1,3)+1700)
 I COCDATE="" S ONCOPARS=$G(^ONCO(160.1,VASITE,0)),(ROLDT,ONCOCDT,ONCORDT)=$P(ONCOPARS,U,4)
 S:$G(ONCORDT) ONCORDTP=$E(ONCORDT,4,5)_"/"_$E(ONCORDT,6,7)_"/"_($E(ONCORDT,1,3)+1700)
 S ROLDT=$E(ROLDT,1,1)_$E(ROLDT,2,3)_"0000"
 S SROLDT=DT-170000,EROLDT=DT-20000
 S SROLDT=$E(SROLDT,1,1)_$E(SROLDT,2,3)_"0000"
 I ROLDT>SROLDT S SROLDT=ROLDT
 S EROLDT=$E(EROLDT,1,1)_$E(EROLDT,2,3)_"0000"
 I ONCOS("F")=2 D
 .S SROLDT=DT-70000,SROLDT=$E(SROLDT,1,1)_$E(SROLDT,2,3)_"0000"
 .I ROLDT>SROLDT S SROLDT=ROLDT
 S XD0=SROLDT,EOF=0
 ;
 F  D  Q:EOF
 .S XD1=""
 .F  S XD1=$O(^ONCO(165.5,"ADX",XD0,XD1)) Q:'XD1  I $$DIV^ONCFUNC(XD1)=DUZ(2) D
 ..I $P($G(^ONCO(165.5,XD1,7)),U,2)'=3 Q  ;patch #17, only process completed cases.
 ..S DATEDX=$P($G(^ONCO(165.5,XD1,0)),U,16)
 ..I ((DATEDX<SROLDT)!(DATEDX>EROLDT)) Q
 ..S COC=$E($$GET1^DIQ(165.5,XD1,.04),1,2)
 ..I (((COC<10)!((COC>14)&(COC<20)))!(COC>23)) Q  ;P17, only class of case 10-14 and 20-22 included.
 ..E  S AA=AA+1,^TMP($J,XD1)=""
 .S XD0=$O(^ONCO(165.5,"ADX",XD0)),CC=AA
 .I 'XD0 S EOF=1
 Q
 ;
SUB ;Subtract patient > 100 y/o
 ;
 N ONCAGE,ONCPT,LY,L365,IE160
 S (LY,L365)=0
 S IE160=$P(^ONCO(165.5,X0,0),U,2)
 S ONCPT=$P(^ONCO(160,IE160,0),";",1)
 S ONCAGE=$$PTAGE(ONCPT,DT) I ONCAGE>100 S P100=P100+1 D KILL Q
 Q
 ;
PTAGE(DFN,DT) ;get pt age, supported IA=#10061
 N ONCDAY,VADM
 S:DT="" DT=$$DT^XLFDT()
 D DEM^VADPT
 S ONCDAY=$$FMDIFF^XLFDT(DT,$P(VADM(3),"^"),3)
 Q ONCDAY\365.25
 ;
F ;Subtract NEXT FOLLOW-UP SOURCE (160.04,6) = 8
 ;Foreign residents (not followed)
 ;Subtract STATUS = 0 (Dead) and LTF (Lost to follow-up)
 N FS,LC,X1,X2
 I VV&'AS S X1=$O(^ONCO(160,PP,"F","AA",0)) I X1'="" S LC=$O(^(X1,0)),FS=$P(^ONCO(160,PP,"F",LC,0),U,6) I FS=8 S AF=AF+1,AA=AA-1 D KILL Q
 I 'VV S AB=AB+1 D KILL Q
 S IE160=$P(^ONCO(165.5,X0,0),U,2)
 S X1=$O(^ONCO(160,IE160,"F","AA",0)) I X1'="" S LC=$O(^(X1,0)),LY=$P(^ONCO(160,IE160,"F",LC,0),U,1)
 I $G(LY) S X2=LY,X1=DT D ^%DTC S L365=X
 I $G(L365) I (L365<456) S AD=AD+1
 Q
 ;
KILL ;Remove non-reportable entry
 K ^TMP($J,X0)
 Q
 ;
MTS ;MULTIPLE TUMOR STATUS (DEATH) (160,70) 'COMPUTED-FIELD' EXPRESSION
 ;MULTIPLE PRIMARY STATUS (160.04,9) 'COMPUTED-FIELD' EXPRESSION
 ;Displays SITE/GP (165.5,.01): LAST TUMOR STATUS (165.5,95)
 Q:$P($G(^ONCO(160,D0,1)),U,1)
 N PD0,ST,TS
 I '$D(^ONCO(165.5,"C",D0)) W !,"No primaries for this patient" Q
 S PD0=0
 F  S PD0=$O(^ONCO(165.5,"C",D0,PD0)) Q:PD0'>0  I $$DIV^ONCFUNC(PD0)=DUZ(2) D
 .S ST=$P(^ONCO(164.2,$P(^ONCO(165.5,PD0,0),U,1),0),U,1)
 .S TS=+$P($G(^ONCO(165.5,PD0,7)),U,6)
 .S TS=$P($G(^ONCO(164.42,TS,0)),U,1)
 .W !,ST_": "_TS
 Q
 ;
NM ;HOSPITAL NAME (160,1000) 'COMPUTED-FIELD' EXPRESSION
 N XD0
 S XD0=$O(^ONCO(160.1,"C",DUZ(2),0))
 I XD0="" S XD0=$O(^ONCO(160.1,0))
 I XD0'="" S X=$P(^ONCO(160.1,XD0,0),U,1)
 Q
 ;
ADD ;HOSPITAL STREET ADDRESS (160,1001) 'COMPUTED-FIELD' EXPRESSION
 N XD0
 S XD0=$O(^ONCO(160.1,"C",DUZ(2),0))
 I XD0="" S XD0=$O(^ONCO(160.1,0))
 I XD0'="" S X=$P(^ONCO(160.1,XD0,0),U,2)
 Q
 ;
ZIP ;HOSPITAL CITY,ST ZIP (160,1002) 'COMPUTED-FIELD' EXPRESSION
 N CITY,STATE,STP,XD0,ZIP
 S XD0=$O(^ONCO(160.1,"C",DUZ(2),0))
 I XD0="" S XD0=$O(^ONCO(160.1,0))
 I XD0'="" D
 .S ZIP=$P(^ONCO(160.1,XD0,0),U,3)
 .S ZIP1=$$GET1^DIQ(160.1,XD0,.03)
 .S CITY=$$GET1^DIQ(5.11,ZIP,1)
 .S STATE=$$GET1^DIQ(5.11,ZIP,3)
 .S X=CITY_", "_STATE_" "_ZIP1
 Q
 ;
ZIP1 ;CITY,ST ZIP (160.1,.031) 'COMPUTED-FIELD' EXPRESSION
 N CITY,STATE,ZIP,ZIP1
 S ZIP=$P(^ONCO(160.1,D0,0),U,3)
 S ZIP1=$$GET1^DIQ(160.1,D0,.03)
 S CITY=$$GET1^DIQ(5.11,ZIP,1)
 S STATE=$$GET1^DIQ(5.11,ZIP,3)
 S X=CITY_", "_STATE_" "_ZIP1
 Q
 ;
CLEANUP ;Cleanup
 K D0,DATEDX,ONCOS,Y
