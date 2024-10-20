DGPT601 ;ALB/MTC,HIOFO/FT - Process 601 transmission ;3/23/2015 5:19pm
 ;;5.3;Registration;**64,164,729,850,884,1057**;Aug 13, 1993;Build 17
 ;
 ;no external references
 ;
 ;called from RTE^DGPTAE
EN ; Process 601 transmission
 N ERROR
 K DGPTPAR
 S DGPTSTR=^TMP("AEDIT",$J,NODE,SEQ),DGPTEDFL=0,DGPTERP=7
 S:$E(DGPTSTR,37,40)="2400" DGPTSTR=$E(DGPTSTR,1,36)_"2359"_$E(DGPTSTR,41,125)
SET ;parse data string and set variables
 D:DGPTFMT=2 SET9
 D:DGPTFMT=3 SET10
DATE ;date/time of procedure
 ; DGPTDDS - discharge DT
 ; DGPTDTS - admission DT
 ; DGPTPDTS - procedure DT
 ;
 S (X,DGPTPDTS)=$$FMDT^DGPT101($E(DGPTPDT,1,6))_"."_$E(DGPTPDT,7,10),%DT="XT" D ^%DT I Y<0 S DGPTERC=601 D ERR G:DGPTEDFL EXIT G TSPEC
 D DD^%DT S DGPTPDT=$E(Y,5,6)_"-"_$E(Y,1,3)_"-"_$E(Y,9,12)_" "_$S($P(Y,"@",2)]"":$E($P(Y,"@",2),1,5),1:"00:00")
 I DGPTPDT'?1.2N1"-"3U1"-"4N1" "2N1":"2N S DGPTERC=601 D ERR G:DGPTEDFL EXIT
 I $$FMDIFF^XLFDT(DGPTDDS,DGPTPDTS,2)<0 S DGPTERC=640 D ERR G:DGPTEDFL EXIT  ; DG*5.3*1057
 I $$FMDIFF^XLFDT(DGPTPDTS,$$FMADD^XLFDT(DGPTDTS,,-72),2)<0 S DGPTERC=637 D ERR G:DGPTEDFL EXIT  ; DG*5.3*1057
 ;
TSPEC ;treating specialty
 N DGPTPSC1
 I DGPTPSC'?2AN S DGPTERC=602 D ERR G:DGPTEDFL EXIT
 S DGPTSP1=$E(DGPTPSC,1),DGPTSP2=$E(DGPTPSC,2),DGPTERC=0
 D CHECK^DGPTAE02 I DGPTERC S DGPTERC=602 D ERR G:DGPTEDFL EXIT G DIAL
 ;-- Active treating specialty edit check
 I $E(DGPTPSC,1)=0!($E(DGPTPSC,1)=" ") S DGPTPSC=$E(DGPTPSC,2)
 ; DGPTPSC  := ptf code (alpha-numeric) value (file:42.4, field:7)
 ; DGPTPSC1 := dinum value (ien, file:42.4, field:.001)
 S DGPTPSC1=+$O(^DIC(42.4,"C",DGPTPSC,0))
 ;-- If not active treat spec, set 601 flag to print error msg during
 ;-- PTF close-out error display at WRER^DGPTAEE
 I '$$ACTIVE^DGACT(42.4,DGPTPSC1,DGPTPDTS) S DGPTERC=602,DGPTSER(DGPTPDTS_601)=1 D ERR G:DGPTEDFL EXIT
DIAL ;dialysis
 N DGLOOP,DGPTPCODE
 I DGPTPNT="   "!(+DGPTPNT'>0) D  G:DGPTEDFL EXIT
 .F DGLOOP=1:1:$S(DGPTFMT=3:25,1:5) S DGPTPCODE=@("DGPTPC"_DGLOOP) D
 ..I DGPTPCODE="3995   "!(DGPTPCODE="5498   ")!(DGPTPCODE="5092   ") S DGPTERC=604 D ERR
 ..I DGPTPCODE="5A1C00Z"!(DGPTPCODE="5A1C60Z")!(DGPTPCODE="5A1D00Z")!(DGPTPCODE="5A1D60Z")!(DGPTPCODE="3E1M39Z") S DGPTERC=604 D ERR
 ;
OPS ;operation codes
 S DGPTERC=0 D ^DGPT60PR G:DGPTEDFL EXIT
 ;
OPDUP ;--check for duplicate procedure codes
 I DGPTFMT=2 I ((DGPTPDY=" ")&(DGPTPNT="   "))&($E(DGPTSTR,47,81)?1.35" ") S DGPTERC="605Z" D ERR G EXIT
 ;I DGPTFMT=3 I ((DGPTPDY=" ")&(DGPTPNT="   "))&($E(DGPTSTR,47,245)?1.199" ") S DGPTERC="605Z" D ERR G EXIT
 ;commenting out duplicate check with dg*5.3*884 ft 11/5/14
 ;F DGPTL4=1:1:5 I $E(@("DGPTPC"_DGPTL4),1)'=" " S DGPTPAR(@("DGPTPC"_DGPTL4),DGPTL4)=""
 ;S DGPTPAR1=0 F DGPTL4=1:1:5 S DGPTPAR1=$O(DGPTPAR(DGPTPAR1)) Q:DGPTPAR1=""  D  G:DGPTEDFL EXIT
 ;. S DGPTPRA2=$O(DGPTPAR(DGPTPAR1,0))
 ;. I DGPTPRA2'="" S DGPTPRA3=$O(DGPTPAR(DGPTPAR1,DGPTPRA2))
 ;. I DGPTPRA3'="" S DGPTERC=657 D ERR
 K DGPTPAR
GOOD ;
 W:'$D(ERROR) "."
 ;
EXIT ;
 K DGPTERC,DGPTL3,DGPTL4,DGPTOP,DGPTOP1,DGPTP1,DGPTP2,DGPTPAR1
 K DGPTPC1,DGPTPC2,DGPTPC3,DGPTPC4,DGPTPC5,DGPTPC6,DGPTPC7,DGPTPC8,DGPTPC9,DGPTPC10,DGPTPC11,DGPTPC12,DGPTPC13,DGPTPC14,DGPTPC15
 K DGPTPC16,DGPTPC17,DGPTPC18,DGPTPC19,DGPTPC20,DGPTPC21,DGPTPC22,DGPTPC23,DGPTPC24,DGPTPC25
 K DGPTPDT,DGPTPDTS,DGPTPDY,DGPTPFL,DGPTPNT,DGPTPP,DGPTPRA2,DGPTPRA3,DGPTPSC,DGPTSTR,DGPTXX
 K X,X1,X2,Y
 Q
ERR ;
 D WRTERR^DGPTAE(DGPTERC,NODE,SEQ)
 S ERROR=1
 Q
DIALE ;dialysis type
 I "12345678"'[DGPTPDY S DGPTERC=603 D ERR G:DGPTEDFL EXIT
 I DGPTPNT="   "!(+DGPTPNT'>0) S DGPTERC=604 D ERR G:DGPTEDFL EXIT
 Q
SET9 ;record layout before icd10 turned on
 S DGPTPDT=$E(DGPTSTR,31,40) ;date/time of procedure
 S DGPTPSC=$E(DGPTSTR,41,42) ;specialty
 S DGPTPDY=$E(DGPTSTR,43)    ;dialysis type
 S DGPTPNT=$E(DGPTSTR,44,46) ;number of dialysis treatments
 S DGPTPC1=$E(DGPTSTR,47,53) ;procedure codes 1-5
 S DGPTPC2=$E(DGPTSTR,54,60)
 S DGPTPC3=$E(DGPTSTR,61,67)
 S DGPTPC4=$E(DGPTSTR,68,74)
 S DGPTPC5=$E(DGPTSTR,75,81)
 Q
SET10 ;record layout after icd10 turned on
 S DGPTPDT=$E(DGPTSTR,31,40) ;date/time of procedure
 S DGPTPSC=$E(DGPTSTR,41,42) ;specialty
 S DGPTPDY=$E(DGPTSTR,43)    ;dialysis type
 S DGPTPNT=$E(DGPTSTR,44,46) ;number of dialysis treatments
 S DGPTPC1=$E(DGPTSTR,47,53) ;procedure codes 1-25. 7 characters long (padded with a space when transmitting)
 S DGPTPC2=$E(DGPTSTR,55,61)
 S DGPTPC3=$E(DGPTSTR,63,69)
 S DGPTPC4=$E(DGPTSTR,71,77)
 S DGPTPC5=$E(DGPTSTR,79,85)
 S DGPTPC6=$E(DGPTSTR,87,93)
 S DGPTPC7=$E(DGPTSTR,95,101)
 S DGPTPC8=$E(DGPTSTR,103,109)
 S DGPTPC9=$E(DGPTSTR,111,117)
 S DGPTPC10=$E(DGPTSTR,119,125)
 S DGPTPC11=$E(DGPTSTR,127,133)
 S DGPTPC12=$E(DGPTSTR,135,141)
 S DGPTPC13=$E(DGPTSTR,143,149)
 S DGPTPC14=$E(DGPTSTR,151,157)
 S DGPTPC15=$E(DGPTSTR,159,165)
 S DGPTPC16=$E(DGPTSTR,167,173)
 S DGPTPC17=$E(DGPTSTR,175,181)
 S DGPTPC18=$E(DGPTSTR,183,189)
 S DGPTPC19=$E(DGPTSTR,191,197)
 S DGPTPC20=$E(DGPTSTR,199,205)
 S DGPTPC21=$E(DGPTSTR,207,213)
 S DGPTPC22=$E(DGPTSTR,215,221)
 S DGPTPC23=$E(DGPTSTR,223,229)
 S DGPTPC24=$E(DGPTSTR,231,237)
 S DGPTPC25=$E(DGPTSTR,239,245)
 Q
