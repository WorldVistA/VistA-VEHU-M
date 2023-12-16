MAGJMN3 ;WIRMFO/JHC - VRad Maint functions ; 10/17/2022
 ;;3.0;IMAGING;**18,120,341**;Dec 21, 2022;Build 28
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;; ISI IMAGING;**99**
 Q
 ;
YN(MSG,DFLT) ; get Yes/No reply
 N X I $G(DFLT)="" S DFLT="N"
 W !
 S DFLT=$E(DFLT),DFLT=$S(DFLT="N":"NO",1:"YES")
YN1 W !,MSG_" "_DFLT_"// "
 R X:DTIME S:X="" X=DFLT S X=$E(X),X=$TR(X,"ynYN","YNYN")
 I "YN"'[X W "  ??? Enter YES or NO",! G YN1
 Q X
 ;
EECPT ;Enter/Edit CPT MATCHING SET
 W @IOF,!!?10,"** Enter/Edit ISI Rad RAD CPT MATCHING CPT CODE **",!!  ; ISI
 N MAGIEN
 K DIC S (DIC,DLAYGO)=2006.67,DIC(0)="ALMEQN"
 D ^DIC I Y=-1 K DIC,DIE,DR,DLAYGO Q
 S DIE=2006.67,DA=+Y,DR="1;3;4;5"
 S MAGIEN=DA
 D ^DIE I '$D(DA) G EECPT
 G EECPT
 Q
INCPT ; Inquire MAG RAD CPT MATCHING
 W @IOF,!!?10,"** Inquire ISI Rad CPT MATCHING CPT CODE **",!!  ; ISI
 N DATA,I,ZJ
INC1 W !! S DIC=2006.67,DIC(0)="AMEQ"
 D ^DIC I Y=-1 K DIC Q
 S DA=+Y,DATA=$P(Y,U,2)
 S DATA="CPT^"_DATA_"|"
 D DATADUMP^MAGJUTL4(.ZJ,DATA)
 W ! S T=+$G(@ZJ@(0)) F I=1:1:T S X=$G(^(I)) W !,X
 G INC1
 Q
PRCPT ;Print MAG RAD CPT MATCHING LOGIC
 N FLDS
 W @IOF,!!?10,"** Print ISI Rad CPT MATCHING CPT CODE **",!!  ; ISI
 W !! S DIC=2006.67,L=0,FLDS="[MAGJ CPT MATCH PRT]"
 D EN1^DIP
 R !,"Enter RETURN to continue: ",X:DTIME W !
 Q
 ;
END ;
