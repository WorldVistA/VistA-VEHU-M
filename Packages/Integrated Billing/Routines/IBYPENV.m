IBYPENV ; ALB/TMP - PATCH IB*2*52 ENVIRONMENT CHECK ; 20-AUG-96
 ;;Version 2.0 ; INTEGRATED BILLING ;**52**; 21-MAR-94
 ;
 Q:$G(XPDENV)'=1
 N CNT,PATCH,Z,Z0
 ;
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,1:0) W !!,*7,">> DUZ and DUZ(0) must be defined as an active user",! S XPDQUIT=2
 ;
 ;Check for existence of prerequisite IB patches 8,17,27,33,41,43,54,55
 S Z="**8"
 I $T(+2^IBCF2P)'[Z!($T(+2^IBCF3P)'[Z)!($T(+2^IBCSC3)'[Z)!($T(+2^IBCF3)'[Z) D NOPTCH(8,.CNT)
 ;
 I $T(+2^IBCF2)'["**17"!($T(+2^IBCF31)'["**17") D NOPTCH(17,.CNT)
 ;
 I $T(+2^IBCU1)'["**27" D NOPTCH(27,.CNT)
 ;
 I $T(+2^IBCF)'["**33" D NOPTCH(33,.CNT)
 ;
 I $P($T(+2^IBCFP),"**",2)'["41" D NOPTCH(41,.CNT)
 ;
 I $P($T(+2^IBCSC3),"**",2)'["43" D NOPTCH(43,.CNT)
 ;
 I $P($T(+2^IBCFP),"**",2)'["54"!($P($T(+2^IBCFP1),"**",2)'["54") D NOPTCH(54,.CNT)
 ;
 I $P($T(+2^IBCCPT),"**",2)'["55" D NOPTCH(55,.CNT)
 ;
 ;
 ; - also check that IB patches 14, 23, 34, and 62 are installed
 I $T(+2^IBCU6)'["**14" D NOPTCH(14,.CNT)
 I $T(+2^IBTOSUM1)'["**23" D NOPTCH(23,.CNT)
 I $T(+2^IBAMTC)'["**34" D NOPTCH(34,.CNT)
 I $T(+2^IBCU7)'["62" D NOPTCH(62,.CNT)
 ;
 ;
 ; - make sure that PRCA*4.5*48 is installed
 ; - (commented out due to distributing *48 with *52, and forcing
 ;    *48 to be installed first...  cm, 1/9/97)
 ; I $P($T(+2^PRCABJV),";",5)'["48" S CNT=$G(CNT)+1 W !!,*7,"Patch PRCA*4.5*48 is required, but is not installed on your system!"
 ;
 I $G(CNT) W !!,"Please install th",$S(CNT>1:"ese patches",1:"is patch")," first and then restart this install.",! S XPDQUIT=2
 ;
CHKBS ; check standard bedsections are defined, abort install if not
 N IBI,IBBS,IBDEF,IBJ,IBABORT S IBABORT=0
 F IBI=1:1 S IBBS=$P($T(BS+IBI),";;",2) Q:IBBS'?1A.AP  D
 . S (IBDEF,IBJ)=0 F  S IBJ=$O(^DGCR(399.1,"B",IBBS,IBJ)) Q:'IBJ  I +$P($G(^DGCR(399.1,IBJ,0)),U,5) S IBDEF=1 Q
 . I 'IBDEF W !,?10,">> Standard Bedsection '",IBBS,"' Not Defined" S IBABORT=IBABORT+1
 ;
 I +IBABORT W !!,IBABORT," standard bedsections are not defined on your system but are required before",!,"this patch can be installed.  Please return the bedsections to their original",!,"names then restart this install.",! S XPDQUIT=2
 ;
CHKRV ; check that the two required revenue codes are active
 S IBABORT=0
 I '$P($G(^DGCR(399.2,101,0)),U,3) S IBABORT=IBABORT+1 W !,?10,">> Revenue Code 101 is Inactive"
 ;
 I '$P($G(^DGCR(399.2,240,0)),U,3) S IBABORT=IBABORT+1 W !,?10,">> Revenue code 240 is Inactive"
 ;
 I +IBABORT W !!,IBABORT," standard Revenue Codes are Inactive but are required before this patch can be",!,"installed.  Please activate these then restart this install.",! S XPDQUIT=2
 ;
 Q
 ;
 ;
NOPTCH(PATCH,CNT) ; Writes patch not installed messsage
 ;PATCH = patch number not found
 ;CNT = # of patches missing ... passed by reference ... running count
 W !!,*7,"PATCH #: IB*2.0*",PATCH," does not appear to be installed on your system and is",!,"  required before this patch can be installed."
 S CNT=$G(CNT)+1
 Q
 ;
BS ; standard bedsections
 ;;ALCOHOL AND DRUG TREATMENT
 ;;BLIND REHABILITATION
 ;;GENERAL MEDICAL CARE
 ;;INTERMEDIATE CARE
 ;;NEUROLOGY
 ;;NURSING HOME CARE
 ;;OUTPATIENT DENTAL
 ;;OUTPATIENT VISIT
 ;;PRESCRIPTION
 ;;PSYCHIATRIC CARE
 ;;REHABILITATION MEDICINE
 ;;SPINAL CORD INJURY CARE
 ;;SURGICAL CARE
 ;;1
 Q
