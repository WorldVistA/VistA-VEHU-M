DGPMV3 ;ALB/MIR - ENTER TRANSACTION INFORMATION; 8 MAY 89 ; 7/08/24 10:11am
 ;;5.3;Registration;**34,54,62,95,692,715,895,1104**;Aug 13, 1993;Build 59
 K ^UTILITY("DGPM",$J)
 D NOW^%DTC S DGNOW=%,DGPMHY=DGPMY,DGPMOUT=0 G:'DGPMN DT S X=DGPMY
 S DGPM0ND=DGPMY_"^"_DGPMT_"^"_DFN_"^^^^^^^^^^^"_$S("^1^4^"[("^"_DGPMT_"^"):"",1:DGPMCA)
 ;
 I DGPMT=1 S $P(DGPM0ND,"^",25)=$S(DGPMSA:1,1:0)
 ;-- provider change
 I DGPMT=6,$D(DGPMPC) S DGPM0ND=$$PRODAT(DGPM0ND)
 D NEW G Q:Y'>0 S (DA,DGPMDA)=+Y
 S:DGPMT=1!(DGPMT=4) DGPMCA=DA,DGPMAN=^DGPM(DA,0) D VAR G DR
DT D VAR G:DGPM1X DR S (DGPMY,Y)=DGPMHY X ^DD("DD") W !,DGPMUC," DATE: ",Y,"// " R X:DTIME G Q:'$T!(X["^") I X="" G DR
 S %DT="SRXE",%DT(0)="-NOW" I X["?"!(Y<0) D HELP^%DTC G DT
 I X="@",$G(DGPMUC)="ADMISSION" D CPTCK  ; DG*5.3*895 Check for 801 screen data
 I X="@" G OKD
 D ^%DT I Y<0 D HELP^%DTC G DT
 K %DT S DGPMY=Y D CHK^DGPMV30:(X]"")&(DGPMY'=+DGPMP) I $D(DGPME) S DGPMY=DGPMHY W !,DGPME K DGPME G DT
DR ;select input template for transaction type
 S DIE="^DGPM(" I "^1^4^6^"[("^"_DGPMT_"^"),DGPMN S DIE("NO^")=""
 S DGODSPT=$S('$D(^DGPM(DGPMCA,"ODS")):0,^("ODS"):1,1:0)
 S DR=$S(DGPMT=1:"[DGPM ADMIT]",DGPMT=2:"[DGPM TRANSFER]",DGPMT=3:"[DGPM DISCHARGE]",DGPMT=4:"[DGPM CHECK-IN LODGER]",DGPMT=5:"[DGPM LODGER CHECK-OUT]",DGPMT=6:"[DGPM SPECIALTY TRANSFER]",1:"") G Q:DR="" K DQ,DG D ^DIE K DIE
 I $D(^UTILITY($J,"PXCOMPACT")),'$D(^UTILITY("DGPM",$J,1,DGPMDA,"A")),$G(PTF)'="" D EDITADMIT^DGCOMPACT(PTF)
 I $D(Y)#2 S DGPMOUT=1
 ;Modified in patch dg*5.3*692 to include privacy indicator node "DIR"
 K DGZ S (^UTILITY("DGPM",$J,DGPMT,DGPMDA,"A"),DGPMA)=$S($D(^DGPM(DGPMDA,0)):^(0)_$S($G(^("DIR"))'="":U_^("DIR"),1:""),1:"")
 D:DGPMT'=4 @("^DGPMV3"_DGPMT)
 I DGPMT=4,$S('$D(^DGPM(DGPMDA,"LD")):1,'$P(^("LD"),"^",1):1,1:0) S DIK="^DGPM(",DA=DGPMDA W !,"Incomplete check-in...deleted" D ^DIK K DIK S DGPMA=""
 S (^UTILITY("DGPM",$J,DGPMT,DGPMDA,"A"),DGPMA)=$G(^DGPM(DGPMDA,0))_$S($G(^("DIR"))'="":U_^("DIR"),1:"") I DGPMT=6 S Y=DGPMDA D AFTER^DGPMV36
EVENTS ;
 I DGPMT=4!(DGPMT=5) D RESET^DGPMDDLD
 I DGPMT'=4&(DGPMT'=5) D RESET^DGPMDDCN I (DGPMT'=6) D SI^DGPMV33
 D:DGPMA]"" START^DGPWB(DFN)
 D EN^DGPMVBM ;notify building management if room-bed change
 S DGOK=0 F I=0:0 S I=$O(^UTILITY("DGPM",$J,I)) Q:'I  F J=0:0 S J=$O(^UTILITY("DGPM",$J,I,J)) Q:'J  I ^(J,"A")'=^("P") S DGOK=1 Q
 I DGOK D ^DGPMEVT ;Invoke Movement Event Driver
Q S:$D(DGPMBYP) DGPMBYP=DGPMDA
 K DGIDX,DGOWD,DGOTY ;variables set in DGPMGLC - G&L corrections
 K DGODS,DGODSPT ;ods variables
 K %DT,DA,DGER,DGNOW,DGOK,DGPM0,DGPM0ND,DGPM2,DGPMA,DGPMAB,DGPMABL,DGPMDA,DGPMER,DGPMHY,DGPMNI,DGPMOC,DGPMOS,DGPMOUT,DGPMP,DGPMPHY,DGPMPHY0,DGPMPTF,DGPMSP,DGPMTYP,DGPMTN,DGPMWD,DGT,DGSV,DGX,DGX1
 K DIC,DIE,DIK,DR,I,I1,J,K,X,X1,X2,Y,^UTILITY("DGPM",$J) Q
 ;
OKD K %DT W ! S DGPMER=0,(^UTILITY("DGPM",$J,DGPMT,DGPMDA,"P"),DGPMP)=^DGPM(DGPMDA,0),Y=DGPMDA D:DGPMT=6 PRIOR^DGPMV36 D @("D"_DGPMT_"^DGPMVDL"_$S(DGPMT>2:1,1:"")) G Q:DGPMER
 W !,"Are you sure you want to delete this movement" S %=2 D YN^DICN G Q:%<0,DT:%=2 I '% W !?5,"Answer yes to delete this ",DGPMUC," or no to continue" G OKD
 ;delete an admission
 I DGPMT=1 D
 . ; get EOC number
 . N DA,DIK,PXEOCNUM,PXEOCSEQ
 . S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN)
 . ; get EOC sequence number
 . S PXEOCSEQ=$$GETEOCSEQ^PXCOMPACT(DFN)
 . ; delete entire episode if only 1 sequence or just delete latest sequence if >1
 . I PXEOCSEQ=1 D
 . . S DIK="^PXCOMP(818,",DA=PXEOCNUM
 . . D ^DIK
 . . K DA,DIK
 . I PXEOCSEQ>1 D
 . . S DA(1)=PXEOCNUM,DA=PXEOCSEQ,DIK="^PXCOMP(818,"_DA(1)_",10,"
 . . D ^DIK
 . . K DA,DIK
 ;delete a discharge
 I DGPMT=3 D
 . N PXEOCNUM,PXEOCSEQ
 . S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN)
 . S PXEOCSEQ=$$GETEOCSEQ^PXCOMPACT(DFN)
 . I (PXEOCNUM'=""),(PXEOCSEQ'="") D REOPNEOC^PXCOMPACT(PXEOCNUM,PXEOCSEQ)
 ;delete a transfer
 I DGPMT=2 D
 . N DGFOUND,DGMOVSEQ,PXEOCNUM,PXEOCSEQ,PXSTARTDT
 . ;get episode of care start date
 . S PXSTARTDT=$$GETSTDT^PXCOMPACT(DFN),DGFOUND=""
 . I (PXSTARTDT="")!(PXSTARTDT'=$P(DGPMY,".",1)) Q
 . ;loop through "M" levels to see if any match the start date
 . S DGMOVSEQ=0
 . F  S DGMOVSEQ=$O(^DGPT(PTF,"M",DGMOVSEQ)) Q:(DGMOVSEQ="")!(DGFOUND)  D
 . . I $P(^DGPT(PTF,"M",DGMOVSEQ,0),"^",10)'=DGPMY Q
 . . I $P(^DGPT(PTF,"M",DGMOVSEQ,0),"^",33)'="Y" Q
 . . S DGFOUND=1
 . I DGFOUND,$P(^DGPT(PTF,70),"^",33)=1 D
 . . S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN)
 . . ; get EOC sequence number
 . . S PXEOCSEQ=$$GETEOCSEQ^PXCOMPACT(DFN)
 . . I PXEOCSEQ=1 D
 . . . S DIK="^PXCOMP(818,",DA=PXEOCNUM
 . . . D ^DIK
 . . . K DA,DIK
 . . I PXEOCSEQ>1 D
 . . . S DA(1)=PXEOCNUM,DA=PXEOCSEQ,DIK="^PXCOMP(818,"_DA(1)_",10,"
 . . . D ^DIK
 . . . K DA,DIK
 D @(DGPMT_"^DGPMVDL"_$S(DGPMT>2:1,1:""))
 I DGPMT'=3,(DGPMT'=5) S DIK="^DGPM(",DA=DGPMDA D ^DIK:DGPMDA
 S (^UTILITY("DGPM",$J,DGPMT,DGPMDA,"A"),DGPMA)=$S($P(DGPMP,"^",18)'=47:"",1:^DGPM(+DGPMDA,0)) I DGPMT=6 S Y=DGPMDA D AFTER^DGPMV36
 I DGPMDA,$O(^DGPM("APHY",DGPMDA,0)) S DIK="^DGPM(",DA=+$O(^(0)) I $D(^DGPM(+DA,0)) S ^UTILITY("DGPM",$J,6,DA,"P")=^(0),^("A")="",Y=DA D PRIOR^DGPMV36,^DIK S Y=DA D AFTER^DGPMV36
 G EVENTS
VAR ;Set up variables
 ;Modified in patch dg*5.3*692 to include privacy indicator node "DIR"
 S DA=DGPMDA,(^UTILITY("DGPM",$J,DGPMT,DGPMDA,"P"),DGPMP)=$S(DGPMN=1:"",1:$G(^DGPM(DA,0))_$S($G(^("DIR"))'="":U_^("DIR"),1:""),1:"") ;DGPMP=Before edit
 I DGPMT=6 S Y=DGPMDA D PRIOR^DGPMV36
 S DGX=DGPMY+($P(DGPMP,"^",22)/10000000)
 S X=$O(^DGPM("APMV",DFN,DGPMCA,(9999999.9999999-DGX))),X1=$O(^DGPM("APMV",DFN,DGPMCA,+X,0)) S DGPM0=$S($D(^DGPM(+X1,0)):^(0),1:"") ;DGPM0=prior movement
 S X=$O(^DGPM("APCA",DFN,DGPMCA,+DGX)),X=$O(^(+X,0)),DGPM2=$S($D(^DGPM(+X,0)):^(0),1:"") ;DGPM2=next movement
 S DGPMABL=0 I DGPM2,$D(^DG(405.2,+$P(DGPM2,"^",18),"E")) S DGPMABL=+^("E") ;is the next movement an absence?
 I DGPMT=6 S Y=DGPMDA D PRIOR^DGPMV36
 Q
NEW ;Entry point to add a new entry to ^DGPM
 D NEW^DGPMV301 ; continuation of routine DGPMV3 in DGPMV301
 Q
 ;
PRODAT(NODE) ;-- This function will add the ward and other data from the
 ; previous TS movement to the provider TS movement.
 ;
 N X,Y
 S Y=NODE,X=$O(^DGPM("ATS",DFN,DGPMCA,9999999.9999999-$P(NODE,U))) I X S X=$O(^(X,0)) I X S X=$O(^(X,0)) I X S X=^DGPM(X,0)
 S $P(Y,U,4)=$P(X,U,4),$P(Y,U,9)=$P(X,U,9)
 Q Y
 ;
CPTCK ; DG*5.3*895 Admission Deletion - Check to see if there is 801 screen data on file (DGPMFLG = okay to delete)
 N DGPMDA,DGPMI,DGPMFLG
 S DGPMDA=$P($G(DGPMAN),U,16),DGPMI=0,DGPMFLG=1
 Q:DGPMDA=""
 F  S I=$O(^DGCPT(46,"C",DGPMDA,DGPMI)) Q:'DGPMI  I '$G(^DGCPT(46,DGPMI,9)) S DGPMFLG=0
 I DGPMFLG S DGPMI=0 F  S DGPMI=$O(^DGICD9(46.1,"C",DGPMDA,DGPMI)) Q:'DGPMI  I '$G(^DGICD9(46.1,DGPMI,9)) S DGPMFLG=0
 I 'DGPMFLG W !!,"CANNOT DELETE THE ADMISSION. THE PTF HAS ACTIVE ORDERS OR CPT ENTRIES." S X="^" H 2 W !
 Q
 ;
