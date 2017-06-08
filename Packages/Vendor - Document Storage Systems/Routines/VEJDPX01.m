VEJDPX01 ; BLJ/DSS ; PCE Routines
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ; (c) 1999 Document Storage Systems, Inc.  Any unauthorized reproduction
 ;          prohibited.
 ;
CREATE(VEJDRSLT,VEJDUSER,VEJDDFN,VEJDVSIT,VEJDARRY) 
 ; INPUT: ARRAY as follows:
 ;       See local array definition in PCE v 1.0 TM pp 49-54
 ;
 ; RETURN:
 ;       1: Information was processed and no errors occurred.
 ;       -1^Error: An error occurred.  Error will be error text.
 ;       -2 : Unable to identify a valid visit. No data was processed.
 ;       -3 : API was called incorrectly.  No data was processed.
 ;
 N PACKAGE,SOURCE,RESULT
 ;M:+VEJDTEST>0 ^TMP("VEJDTEST",$J,"PXAPI")=VEJDARRY
 S PACKAGE=$O(^DIC(9.4,"C","VEJD",0)) I PACKAGE="" S PACKAGE="-1^PACKAGE FILE ENTRY NOT PRESENT" Q
 S SOURCE="VEJD DSS PCE"
 S VEJDRSLT=$$DATA2PCE^PXAPI("VEJDARRY",PACKAGE,SOURCE,.VEJDVSIT,$G(VEJDUSER),"^TMP(""DIERR"",$J)")
 I VEJDRSLT=1 D
 .; Since PCE doesn't return a new Visit IEN, we'll have to do a lookup for the
 .; patient's most recent visit.
 .D SELECTED^VSIT(VEJDDFN,,,,,,,"1")
 .S VEJDRSLT(1)="1^"_$O(^TMP("VSIT",$J,0))
 I VEJDRSLT<0 D
 .D MSG^DIALOG("AE",.RESULT)
 .S RESULT(1)=VEJDRSLT_U_$G(RESULT(1))
 .M VEJDRSLT=RESULT
 Q
 ;
GETINFO(VEJDRSLT,VEJDVIFN) 
 ; INPUT: VEJDVIFN: Visit IFN
 ;
 ; RETURN: Array of:
 ;      Line 1 : Action required | Checked in | Checked out
 ;      Lines 2-N : Type^IFN^Text Desc
 ;      Where:
 ;           Type = exactly one of:
 ;              D : Diagnosis
 ;              C : CPT
 ;              H : Health Factor
 ;              E : Education Topics
 ;              X : Exams
 ;              I : Immunizations
 ;
 N LOOP,INDEX,DIAGIFN,PROCIFN,EXAMIFN,HFIFN,EDIFN,IMMIFN
 ; First, get Check-in/Check-out status
 S ENCNTR=$O(^SCE("AVSIT",VEJDVIFN,0))
 S ENCNTR=$P($G(^SCE(ENCNTR,0)),U,12),VEJDRSLT(1)=$P($G(^SD(409.63,ENCNTR,0)),U)
 ; Now for diagnoses.
 S INDEX=1,LOOP=0
 F  S LOOP=$O(^AUPNVPOV("AD",VEJDVIFN,LOOP)) Q:LOOP=""  D
 .S INDEX=+INDEX+1
 .S DIAGIFN=$P($G(^AUPNVPOV(LOOP,0)),U)
 .S VEJDRSLT(INDEX)="D"_U_$G(DIAGIFN)_U_$P($G(^ICD9(DIAGIFN,0)),U,3)_U_$P($G(^ICD9(DIAGIFN,0)),U)
 ; CPT codes
 S LOOP=0
 F  S LOOP=$O(^AUPNVCPT("AD",VEJDVIFN,LOOP)) Q:LOOP=""  D
 .S INDEX=+INDEX+1
 .S PROCIFN=$P($G(^AUPNVCPT(LOOP,0)),U)
 .S VEJDRSLT(INDEX)="C"_U_$G(PROCIFN)_U_$P($G(^ICPT(PROCIFN,0)),U,2)
 ;Health Factors
 S LOOP=0
 F  S LOOP=$O(^AUPNVHF("AD",VEJDVIFN,LOOP)) Q:LOOP=""  D
 .S INDEX=+INDEX+1
 .S HFIFN=$P($G(^AUPNVHF(LOOP,0)),U)
 .S VEJDRSLT(INDEX)="H"_U_HFIFN_U_$P($G(^AUTTHF(HFIFN,0)),U)
 ; Education Topics
 S LOOP=0
 F  S LOOP=$O(^AUPNVPED("AD",VEJDVIFN,LOOP)) Q:LOOP=""  D
 .S INDEX=+INDEX+1
 .S EDIFN=$P($G(^AUPNVPED(LOOP,0)),U)
 .S VEJDRSLT(INDEX)="E"_U_EDIFN_U_$P($G(^AUTTEDT(DIAGIFN,0)),U)
 ; Exams next.
 S LOOP=0
 F  S LOOP=$O(^AUPNVXAM("AD",VEJDVIFN,LOOP)) Q:LOOP=""  D
 .S INDEX=+INDEX+1
 .S EXAMIFN=$P($G(^AUPNVXAM(LOOP,0)),U)
 .S VEJDRSLT(INDEX)="X"_U_EXAMIFN_U_$P($G(^AUTTEXAM(DIAGIFN,0)),U)
 ; Last, we do immunizations.
 S LOOP=0
 F  S LOOP=$O(^AUPNVIMM("AD",VEJDVIFN,LOOP)) Q:LOOP=""  D
 .S INDEX=+INDEX+1
 .S IMMIFN=$P($G(^AUPNVIMM(LOOP,0)),U)
 .S VEJDRSLT(INDEX)="I"_U_IMMIFN_U_$P($G(^AUTTIMM(IMMIFN,0)),U)
 Q
 
 
