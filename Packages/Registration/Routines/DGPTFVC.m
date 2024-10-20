DGPTFVC ;ALB/MTC - PTF VALIDITY CHECK ;01 MAY 91 @0800
 ;;5.3;Registration;**37,234,850**;Aug 13, 1993;Build 172
PTF S DIC="^DGPT(",DIC(0)="MAQE",DIC("S")="I $P(^(0),U,11)=1" D ^DIC K DIC Q:Y'>0  S DGERR=-1,(PTF,J)=+Y D LOG^DGPTFTR W:DGERR'>0 !," NO ERRORS"
 K DGLOGIC,DGDD,DGERR G PTF
 Q
EN ;entry point from menu option DG PTF VALIDITY CHECK
 ;--setup vars for Austin Edits
 K ^TMP("AEDIT",$J),^TMP("AERROR",$J) S DGACNT=0
 ;
 S DIC="^DGPT(",DIC(0)="MAQE",DIC("S")="I $P(^(0),U,11)=1" D ^DIC K DIC I Y'>0 K DGACNT Q
 N DGSDFN S DGSDFN=$P(Y,U,2)
 S PTF=+Y,Y=$S($D(^DGPT(+Y,70)):+^(70),1:0) D FMT^DGPTUTL
 S:DT<2901001 DGPTFMT=1 ; needed so test sites can still validate 80col.
 S Y=1 D RTY^DGPTUTL
 S DGERR=0,DGCNT=1,J=PTF
 D SETTRAN G:DGOUT Q
 D LOG^DGPTFTR G Q:DGERR>0
 D VERCHK^DGPTRI3(PTF) G Q:DGERR>0 ; for ICD-10 validate that record is all of correct type
 W !,"Performing Additional Edits..." D ^DGPTAE G Q:DGERR>0
XMIT K XMY S XMZ=DGXMZ,XMDUZ=.5,XMY(DUZ)="",DGJ=J,^XMB(3.9,XMZ,2,0)="3.92A^"_DGCNT-1_"^"_DGCNT-1_"^"_DT
 D ENT1^XMD
 W !,"Message Sent"
 ;
Q K DGXMZ,XMZ,XMDUN,XMY,DGOUT,DGLOGIC,DGERR,XMDUZ,DGRTY,DGRTY0,DGPTFMT,XMSUB,XMTEXT,Y,J,PTF,DGJ,DGCNT,DGACNT G EN
SETTRAN ;-- setup mailman transmission
 S DGOUT=0
 S Y=$P(^DPT(+^DGPT(+J,0),0),U,1),XMSUB=Y_"  PTF TRANSMISSION ",XMDUZ=DUZ,XMDUN=$P(^VA(200,DUZ,0),U)
 D GET^XMA2
 I $D(XMZ),(XMZ>0) S DGXMZ=XMZ K XMZ G SETQ
 W !,"*** ERROR *** Unable to create MailMan message... Try again later"
 S DGOUT=1
SETQ ;
 Q
