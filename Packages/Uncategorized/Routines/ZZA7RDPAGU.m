ZZA7RDPAGU ;HCIOFO/CAH -PATIENT SELECTION ACTION FOR GUI ;12/01/99 [4/6/07 3:06pm]
 ;;1.0;NDBI-MAS 5.3;;JAN 01, 1997
 ;02-04-00 MODIFIED AT HINES VAH BY RMS FOR DDTC FUNCTIONALITY
 ;This routine is called from the GUI version of CPRS to display
 ;a message upon patient look-up for legacy patients after
 ;database integration.
HXDATA(LST,DFN)        ; return text to display if historical data
 Q:$D(ZTQUEUED)
 Q:$D(A7RQUIET)
 N A7R,ILST,AJEYIEN
 S A7R=1,ILST=0
 ;I '$L($T(OLD^A7RCP)) G DDTC  ; NOT INTEGRATION SITE
 ;I $$TS^A7RU0002'="P" G DDTC  ; Not on primary system if integration site
 ;F  S A7R=$O(^A7RCP("B",A7R)) Q:'A7R  I $$OLD^A7RCP(2,+DFN,A7R) D
 S ILST=ILST+1
 S LST(ILST)="You are expected to refrain from entering any information that may be deemed as obscene, offensive or inappropriate."
 S ILST=ILST+1
 S LST(ILST)="If you have problems or questions, please go to www.va.gov/cprsdemo and click on the Contact Us link."
 S ILST=ILST+1
    S LST(ILST)="MISUSE of this system constitutes a Federal Crime."
 Q
DDTC D  ;
 .Q:'$D(^AJEY(578160,"B",+DFN))
 .S AJEYIEN=$O(^AJEY(578160,"B",+DFN,0)),ILST=ILST+1
 .Q:$P($G(^AJEY(578160,AJEYIEN,2)),U,3)<DT
 .S LST(ILST)="This patient has a local notice with the following text:"
 .S ILST=ILST+1,LST(ILST)=" -->  "_$G(^AJEY(578160,AJEYIEN,1))
 .Q
ENR ;
 S ENR=$$GET^DGENA($$FINDCUR^DGENA(DFN),.DGENR) I $G(DGENR("STATUS"))=22 D
 .S ILST=ILST+1,LST(ILST)="---> INELIGIBLE VETERAN - CONTACT EXT. 6816/6726 GV; 2059 LC."
 .Q
OPT ;For opt out patients
 S OPTOUT=$P($G(^DPT(DFN,.109)),U) I OPTOUT=1 D
 .S ILST=ILST+1,LST(ILST)="--->  **Patient chose not to be included in the Facility Directory for this admission"
 .Q
RSH D  ;
 .N AJEY,AJEYIEN,AJEYST,AJEYSTN,AJEYNM,AJEYPH,AJEYPI,AJEYPN,AJEYMFLG
 .N AJEYN2,AJEYN3
 .Q:'$D(^AJEY(578163,"B",+DFN))
 .S AJEYIEN=$O(^AJEY(578163,"B",+DFN,0))
 .S AJEYST=0 F  S AJEYST=$O(^AJEY(578163,AJEYIEN,1,AJEYST)) Q:AJEYST'=+AJEYST  D  ;
 ..S AJEYN3=$G(^AJEY(578163,AJEYIEN,1,AJEYST,0))
 ..Q:+$P(AJEYN3,"^",4)
 ..S AJEYSTN=$P(AJEYN3,"^",1)
 ..S AJEYN2=$G(^AJEY(578162,AJEYSTN,0))
 ..Q:+$P(AJEYN2,"^",5)
 ..D NULL,INC S:'$G(AJEYMFLG) LST(ILST)="This patient is enrolled in a RESEARCH STUDY."
 ..S AJEYNM=$P(AJEYN2,"^",1)
 ..S AJEYPI=$P($G(^VA(200,+$P(AJEYN2,"^",2),0)),"^",1)
 ..S AJEYPH=$P(AJEYN2,"^",3)
 ..S AJEYPN=$P($G(^TIU(8925.1,+$P(AJEYN2,"^",4),0)),"^",1)
 ..D INC S LST(ILST)=$$STNM
 ..D INC S LST(ILST)="*** DO NOT WRITE OR CHANGE ANY MEDICATIONS PRIOR TO"
 ..D INC S LST(ILST)="DISCUSSION WITH DR. AINSLIE OR PAM MULLEN ***"
 ..D INC S LST(ILST)="Principal Investigator: "_AJEYPI
 ..D INC S LST(ILST)="Call "_AJEYPH_" if there are questions"
 ..I $G(AJEYPN)]"" D INC S LST(ILST)="See progress note "_$E(AJEYPN,1,39)_" for study information."
 ..D INC S LST(ILST)="Enrollment date: "_$$FMTE^XLFDT($P(AJEYN3,"^",2))
 ..I $P(AJEYN3,"^",3) D INC S LST(ILST)="Completion date: "_$$FMTE^XLFDT($P(AJEYN3,"^",3))
 ..S AJEYMFLG=1
 .Q
 Q
INC S ILST=$G(ILST)+1
 Q
NULL S LST(ILST)=" "
 Q
STNM() N AJEYERR
 Q $S($$ISA^USRLM(DUZ,"PROVIDER",.AJEYERR):AJEYNM,1:"STUDY NAME WITHHELD")
