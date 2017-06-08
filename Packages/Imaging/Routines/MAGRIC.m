MAGRIC ;HISC/FPT AISC/SAW-Radiologic Image Display Routine [ 18-AUG-2000 14:47:56 ]
 ;;2.5T11;MAG;;18-Aug-2000
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a Class II medical device.  As such, it may not be changed    |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 ;;
 ; **Only for use by the Imaging package**
 ;
DISPF ;Display Full Radiologic Image
 ; Called from RART
 N X,Y ;enable going back to report SRR 10/02/94
 Q:'$G(RARPT)  ;MOD RED 9/24/91, 4/8/92
 S X="MAGRDSP" X ^%ZOSF("TEST") I $T Q:'$O(^RARPT(RARPT,2005,0))
 S MAGFL=74,MAGIN=RARPT
 D ^MAGRDSP,ERASE^MAGCALL ;SRR 10/4/94
 K MAGFL,MAGIN Q  ;SRR 8/5/92 Remove RAI,X
DISPA ;Display Radiologic Image Abstracts
 ; Called from RACNLU & RAPTLU
 N X,Y
 Q:'$G(RARPT)  ; MOD PMK 3/31/92
 S X="MAGRSUM" X ^%ZOSF("TEST") I $T Q:'$O(^RARPT(RARPT,2005,0))
 S MAGFL=74,MAGIN=RARPT
 S MAGCASE=$P(^RARPT(MAGIN,0),"^",4)
 D ^MAGRSUM
 K MAGCASE Q
EN ;Menu Option Entry Point to Capture Radiologic Image
 N X K MAG
 S X="MAGMIM" X ^%ZOSF("TEST") I '$T K X Q
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
EN1 D ^RACNLU G EXIT:X="^"!(X="") I $D(^RA(72,"AA",RAIMGTY,0,+RAST)) W !!?3,*7,"This exam has been cancelled.  You cannot add images to a cancelled exam." G EN1 ; MOD RED 10/3/91
 S RAPRI=+$P(Y(0),"^",2)
IC S DFN=RADFN,MAGFLN=74,MAGFLT2="XRAY",MAGIN=RARPT,I=0 F  S I=$O(^RAMIS(71,RAPRI,2,I)) Q:I'>0!(MAGFLT2'="XRAY")  I $D(^(I,0)) S X=+^(0) S MAGFLT2=$S(X=21:"CT",X=23:"US",X=16!(X=17)!(X=18):"ANGIO",1:"XRAY")
 ; I 'RARPT D CREATE^RARIC
VAR S MAGPARNT="^RARPT("_$G(RARPT),MAGD0=RARPT ;,MAGPXDT=$P(^RARPT(RARPT,0),U,3)
 ; Q:$D(MAGEDIT)  ;EDIT FUNCTION
TYP ;SELECT TYPE INPUT
 S DIR("A")="TYPE OF INPUT",DIR(0)="S^X:XRAY SCANNER;N:NUCLEAR MEDICINE;U:ULTRASOUND (B/W);M:ULTRASOUND AND OTHER (COLOR);C:CT;A:ANGIO;B:BARIUM SWALLOW;O:OTHER (B&W)"
 S DIR("B")="XRAY SCANNER" D ^DIR S MAGTYP=Y G EXIT:Y["^"!(Y=""),X:Y="X"
 S (MAGFLT2,MAGPROC)=$S(Y="N":"NUCMED",Y="U":"ULTSND",Y="O":"RAD",Y="C":"CT",Y="A":"ANGIO",Y="B":"BSW",Y="M":"RADC",Y="O":"RAD",1:"")
 S MAGMODE="BW" I MAGPROC="N"!(MAGPROC="NUCMED")!(MAGPROC="RADC") S MAGMODE="MED"
 D DPT^MAGMCPT G MAG2
X ;Xray Scanner
 S MAGMODE="XRAY",MAGPARNT="^RARPT("_$G(RARPT)
 D DPT^MAGMCPT
MAG2 G EN1:$D(MAG)<10
 I 'RARPT D CREATE^RARIC S MAGPARNT="^RARPT("_RARPT
 S MAGGP=0,MAGD0=RARPT,MAGPXDT=$P(^RARPT(RARPT,0),U,3)
 F  S MAGGP=$O(MAG(MAGGP)) Q:MAGGP=""  S X=MAGGP I '$D(^RARPT(RARPT,2005,"B",X)) D PTR^RARIC S MAGIFN=MAGGP,MAGD0=RARPT D SCAN3^MAGUFILR
 K MAG G EN1 ; MOD RED 10/26/94
EN2 ;Routine Entry Point to Capture Radiologic Image
 ;The variables RADFN, RADTI, RACNI and RAPRI must be defined when
 ;calling this entry point
 N X
 S X="MAGMIM" X ^%ZOSF("TEST") I '$T K X Q
 Q:'$D(RADFN)!('$D(RADTI))!('$D(RACNI))!('$D(RAPRI))
 S DIR(0)="Y",DIR("A")="Do you want to perform an image capture",DIR("B")="NO" D ^DIR G EXIT:'Y,IC
EXIT K DFN,DIC,DIR,I,MAGFL,MAGFLT2,MAGGP,MAGIN,MAGSCN,RACN,RACNI,RADFN,RADTE,RADTI,RAFS,RAPRI,RARIC,RARPT,X,Y,MAGMODE Q  ; MOD RED 11/1/94 ADDED MAGMODE
