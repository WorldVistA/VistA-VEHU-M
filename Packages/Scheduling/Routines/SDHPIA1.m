SDHPIA1 ;MTC,PKE/ALB - Health Promotion initiative Scan Routine; 3/12/96 [ 10/21/96   8:19 AM ]
 ;;5.3;Scheduling;**58,81,133,152**;March 12, 1996
 ;
BLD(SDHPBG,SDHPED,SDHPSCS) ;-- Function loops through the OutPatient
 ; Encounter file and build ^TMP array of patients that meet the
 ; specified criteria.
 ;
 ; Input : SDHPBG  - Start date
 ;       : SDHPED  - End date
 ;       : SDHPSCS - DSS Identifiers (Stop Codes) String ,101,201,301,
 ;
 ; OutPut: ^TMP("SDHP-HPI",$J,DFN)= Date of last visit.
 ;         X = FEMALE TOTAL^MALE TOTAL
 ;
 N SDHPX,SDHPY,SDHPZ,SDHPCNT,SDHPEMP,SDHPINP
 N STOP,GLB,Q
 ;
 S SDHPEMP=$O(^DIC(8,"B","EMPLOYEE",0))
 S SDHPINP=$O(^SD(409.63,"B","INPATIENT APPOINTMENT",0))
 ;
 S SDHPX=SDHPBG,(SDHPFCNT,SDHPMCNT)=0,GLB="^SCE(""B"","_SDHPX_")",Q=""""
 F  S GLB=$Q(@GLB) Q:GLB'[("""B"",")  S SDHPX=+$P(GLB,",",2),SDHPY=+$P(GLB,",",3) Q:(SDHPX>SDHPED)!('SDHPX)  I SDHPY D
 . ;
 . S SDHPZ=$G(^SCE(SDHPY,0)),DFN=+$P(SDHPZ,U,2)
 .; S SDHPSEX=$P($G(^DPT(DFN,0)),U,2)
 .; I $$CRITERIA(DFN,SDHPZ,SDHPSCS,SDHPEMP,SDHPINP),(SDHPSEX]"") D
 .;. S SDHPZ=$O(^TMP("SDHP-HPI",$J,DFN,0))
 .;. I SDHPZ S ^TMP("SDHP-HPI",$J,SDHPSEX,SDHPZ,DFN)=SDHPX Q
 .; save stop codes by dfn
 . S STOP=$$CRITERIA(DFN,SDHPZ,SDHPSCS,SDHPEMP,SDHPINP)
 . Q:'STOP  S SDHPSEX=$P($G(^DPT(DFN,0)),U,2) Q:($F("MF",SDHPSEX)<2)
 . I '$D(^TMP("SDHP-HPI",$J,"DT",DFN,$E(SDHPX,1,7))) S ^($E(SDHPX,1,7))=1,^("TOT")=$G(^("TOT"))+1 D
 .. S SDTV(SDHPSEX)=$G(SDTV(SDHPSEX))+1
 . S SDHPZ=$O(^TMP("SDHP-HPI",$J,DFN,0))
 . I SDHPZ DO  Q
 .. S ^TMP("SDHP-HPI",$J,SDHPSEX,SDHPZ,DFN)=SDHPX
 .. I ^TMP("SDHP-HPI",$J,DFN,SDHPZ)[STOP Q
 .. E  S ^(SDHPZ)=$G(^TMP("SDHP-HPI",$J,DFN,SDHPZ))_STOP_"^"
 ..;
 . I SDHPSEX="F" DO  Q
 .. S SDHPFCNT=SDHPFCNT+1
 .. S ^TMP("SDHP-HPI",$J,SDHPSEX,SDHPFCNT,DFN)=SDHPX
 .. S ^TMP("SDHP-HPI",$J,DFN,SDHPFCNT)="^"_STOP_"^"
 ..;
 . I SDHPSEX="M" DO  Q
 .. S SDHPMCNT=SDHPMCNT+1
 .. S ^TMP("SDHP-HPI",$J,SDHPSEX,SDHPMCNT,DFN)=SDHPX
 .. S ^TMP("SDHP-HPI",$J,DFN,SDHPMCNT)="^"_STOP_"^"
 ;
 Q SDHPFCNT_U_SDHPMCNT
 ;
CRITERIA(DFN,SCE0,SDHPSCS,SDHPEMP,SDHPINP) ;-- This function will evaluate the patient identified
 ; by DFN and return a DSS IDENTIFIER if yes and 0 if no.
 ;
 S STOP=$P($G(^DIC(40.7,+$P(SCE0,U,3),0)),U,2)
 ;
 I 'STOP Q 0
 ;
 ;--check if test patient
 I $P($G(^DPT(DFN,0)),U,21) Q 0
 I $E($P($G(^DPT(DFN,0)),U,9),1,5)?5"0" Q 0
 ;-- check for inpatient status (no NH or hosp patients)
 I $P(SCE0,U,12)=SDHPINP Q 0
 ;-- check for stop codes
 I SDHPSCS'="",SDHPSCS'[STOP Q 0
 ;-- is patient dead
 I $D(^DPT(DFN,.35)) Q 0
 ;-- is not a vet
 I $G(^DPT(DFN,"VET"))'="Y" Q 0
 ;-- patient an employee 
 I $D(^DPT(DFN,"E",SDHPEMP)) Q 0
 ;
 Q STOP
