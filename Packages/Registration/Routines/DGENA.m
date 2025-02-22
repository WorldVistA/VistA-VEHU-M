DGENA ;ALB/CJM,ISA/KWP,Zoltan,LBD,CKN,EG,ERC,TDM,JLS,HM,KUM - Enrollment API - Retrieve Data ;11/16/19 3:34PM
 ;;5.3;Registration;**121,122,147,232,314,564,672,659,653,688,841,909,940,972,952,993**;Aug 13, 1993;Build 92
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
FINDCUR(DFN) ;
 ;Description: Used to find a patient's current enrollment.
 ;Input :
 ; DFN - Patient IEN
 ;Output:
 ; Function Value - returns the internal entry number of the patient's
 ; current enrollment if there is one, NULL otherwise. Checks that
 ; current enrollment actually belongs to the patient.
 ;
 Q:'$G(DFN) ""
 ;
 N CUR
 S CUR=$P($G(^DPT(DFN,"ENR")),"^")
 I CUR,$P($G(^DGEN(27.11,CUR,0)),"^",2)'=DFN S CUR=""
 Q CUR
 ;
FINDPRI(DGENRIEN) ;
 ;Description: Used to obtain a patient's enrollment record that was
 ; prior to the enrollment identified by DGENRIEN.
 ;Input :
 ; DGENRIEN - this is the internal entry number of a PATIENT ENROLLMENT
 ; record
 ;Output:
 ; Function Value - returns the internal entry number of the prior
 ; enrollment for the patient if there is one, NULL otherwise.
 ;
 Q:'$G(DGENRIEN) ""
 Q $P($G(^DGEN(27.11,DGENRIEN,0)),"^",9)
 ;
ENROLLED(DFN) ;
 ;Description: Returns whether the patient is currently enrolled.
 ;Input:
 ; DFN - Patient IEN
 ;Output:
 ; Function Value - returns 1 if the patient is currently enrolled with
 ; a status of VERIFIED, 0 otherwise
 ;
 N STATUS
 S STATUS=$$STATUS($G(DFN))
 I (STATUS=2) Q 1
 Q 0
 ;
STATUS(DFN) ;
 ;Description: Returns ENROLLMENT STATUS from the patient's current
 ; enrollment.
 ;Input:
 ; DFN - Patient IEN
 ;Output:
 ; Function Value - If the patient has a current ENROLLMENT STATUS this
 ; function will return its value, otherwise it returns NULL.
 N DGENRIEN
 S DGENRIEN=$$FINDCUR($G(DFN))
 Q:'DGENRIEN ""
 Q $P($G(^DGEN(27.11,DGENRIEN,0)),"^",4)
 ;
PRIORITY(DFN) ;
 ;Description: Returns ENROLLMENT PRIORITY from the patient's current
 ; enrollment.
 ;Input:
 ; DFN - Patient IEN
 ;Output:
 ; Function Value - If the patient has a current ENROLLMENT PRIORITY
 ; this function will return its value, otherwise it returns NULL.
 N DGENRIEN
 S DGENRIEN=$$FINDCUR($G(DFN))
 Q:'DGENRIEN ""
 Q $P($G(^DGEN(27.11,DGENRIEN,0)),"^",7)
 ;
SOURCE(DFN) ;
 ;Description: Returns SOURCE OF ENROLLMENT from the patient's current
 ; enrollment.
 ;Input:
 ; DFN - Patient IEN
 ;Output:
 ; Function Value - If the patient has a current ENROLLMENT 
 ; this function will return the SOURCE OF ENROLLMENT, otherwise
 ; it returns NULL.
 ;
 N DGENRIEN
 S DGENRIEN=$$FINDCUR($G(DFN))
 Q:'DGENRIEN ""
 Q $P($G(^DGEN(27.11,DGENRIEN,0)),"^",3)
 ;
GET(DGENRIEN,DGENR) ;
 ;Description: Used to obtain a record from the Patient Enrollment file
 ; into the local DGENR array.
 ;Input :
 ; DGENRIEN - this is the internal entry number of a PATIENT ENROLLMENT record
 ;Output:
 ; Function Value - returns 1 on success, 0 on failure.
 ; DGENR - this is the name of a local array, it should be passed by
 ; reference. If the function is successful this array will
 ; contain the enrollment.
 ;
 ; subscript field name
 ; "APP" Enrollment Application Date
 ; "DATE" Enrollment Date
 ; "END" Enrollment End Date
 ; "DFN" Patient IEN
 ; "SOURCE" Enrollment Source
 ; "STATUS" Enrollment Status
 ; "REASON" Reason Canceled/Declined
 ; "REMARKS" Canceled/Declined Remarks
 ; "FACREC" Facility Received
 ; "PRIORITY" Enrollment Priority
 ; "SUBGRP" Enrollment Sub-Group
 ; "RCODE" Reason for Closed Application ;;DJE DG*5.3*940 - Closed Application
 ; "EFFDATE" Effective Date
 ; "PRIORREC" Prior Enrollment Record
 ; "PTAPPLIED" Patient applied for enrollment
 ; "REGCREA" Registration only reason
 ; "REGDATE" Registration only date
 ; "REGSRC" Registration only source
 ; "ELIG","CODE" Primary Eligibility Code
 ; "ELIG","CODE",<code ien> Eligibility Codes
 ; "ELIG","SC" Service Connected
 ; "ELIG","SCPER" Service Connected Percentage
 ; "ELIG","POW" POW Status Indicated
 ; "ELIG","A&A" Receiving A&A Benefits
 ; "ELIG","HB" Receiving Housebound Benefits
 ; "ELIG","VAPEN" Receiving a VA Pension
 ; "ELIG","VACKAMT" Total Annual VA Check Amount
 ; "ELIG","DISRET" Military Disability Retirement
 ; "ELIG","DISLOD" Discharged Due to Disability
 ; "ELIG","MEDICAID" Medicaid
 ; "ELIG","AO" Exposed to Agent Orange
 ; "ELIG","AOEXPLOC" Agent Orange Exposure Location
 ; "ELIG","IR" Radiation Exposure Indicated
 ; "ELIG","RADEXPM" Radiation Exposure Method
 ; "ELIG","EC" SW Asia Cond - was Env Con, DG*5.3*688
 ; "ELIG","MTSTA" Means Test Status
 ; "ELIG","VCD" Veteran Catastrophically Disabled?
 ; "ELIG","PH" Purple Heart Indicated?
 ; "ELIG","UNEMPLOY" Unemployable
 ; "ELIG","CVELEDT" Combat Veteran End Date
 ; "ELIG","SHAD" SHAD Indicated
 ; "ELIG","MOH" Medal of Honor Indicated
 ; "ELIG","MOHAWRDDATE" Medal of Honor Award Date DG*5.3*972
 ; "ELIG","MOHSTATDATE" Medal of Honor Status Date DG*5.3*972
 ; "ELIG","MOHEXEMPDATE" Medal of Honor Copayment Exemption Date DG*5.3*972
 ; "ELIG","CLE" Camp Lejeune Indicated? DG*5.3*909
 ; "ELIG","CLEDT" Camp Lejeune Date DG*5.3*909
 ; "ELIG","CLEST" Camp Lejeune Change Site DG*5.3*909
 ; "ELIG","CLESOR" Camp Lejeune Source DG*5.3*909
 ; "ELIG","OTHTYPE" Expanded MH care type
 ; "DATETIME" Date/Time Entered
 ; "USER" Entered By
 ; 
 N SUB,NODE
 I '$G(DGENRIEN) Q 0
 I '$D(^DGEN(27.11,DGENRIEN,0)) Q 0
 K DGENR
 S DGENR=""
 S NODE=$G(^DGEN(27.11,DGENRIEN,0))
 S DGENR("APP")=$P(NODE,"^")
 S DGENR("DATE")=$P(NODE,"^",10)
 S DGENR("END")=$P(NODE,"^",11)
 S DGENR("DFN")=$P(NODE,"^",2)
 S DGENR("SOURCE")=$P(NODE,"^",3)
 S DGENR("STATUS")=$P(NODE,"^",4)
 S DGENR("REASON")=$P(NODE,"^",5)
 S DGENR("FACREC")=$P(NODE,"^",6)
 S DGENR("PRIORITY")=$P(NODE,"^",7)
 S DGENR("EFFDATE")=$P(NODE,"^",8)
 S DGENR("PRIORREC")=$P(NODE,"^",9)
 ;Phase II Get enrollment sub-grp (SRS 6.4)
 S DGENR("SUBGRP")=$P(NODE,"^",12)
 S DGENR("RCODE")=$P(NODE,"^",13) ;DJE field added with DG*5.3*940 - Closed Application - RM#867186
 ; DG*5.3*993 KUM - Add PT Applied for Enrollment field and other Registration Only fields
 S DGENR("PTAPPLIED")=$P(NODE,"^",14)
 S DGENR("REGREA")=$P(NODE,"^",15)
 S DGENR("REGSRC")=$P(NODE,"^",17)
 S DGENR("REGDATE")=$P(NODE,"^",16)
 S NODE=$G(^DGEN(27.11,DGENRIEN,"R"))
 S DGENR("REMARKS")=$P(NODE,"^")
 S NODE=$G(^DGEN(27.11,DGENRIEN,"E"))
 S DGENR("ELIG","CODE")=$P(NODE,"^")
 S DGENR("ELIG","SC")=$P(NODE,"^",2)
 S DGENR("ELIG","SCPER")=$P(NODE,"^",3)
 S DGENR("ELIG","POW")=$P(NODE,"^",4)
 S DGENR("ELIG","A&A")=$P(NODE,"^",5)
 S DGENR("ELIG","HB")=$P(NODE,"^",6)
 S DGENR("ELIG","VAPEN")=$P(NODE,"^",7)
 S DGENR("ELIG","VACKAMT")=$P(NODE,"^",8)
 S DGENR("ELIG","DISRET")=$P(NODE,"^",9)
 S DGENR("ELIG","DISLOD")=$P(NODE,"^",20) ;added with DG*5.3*672
 S DGENR("ELIG","MEDICAID")=$P(NODE,"^",10)
 S DGENR("ELIG","AO")=$P(NODE,"^",11)
 S DGENR("ELIG","AOEXPLOC")=$P(NODE,"^",22) ;added with DG*5.3*688
 S DGENR("ELIG","IR")=$P(NODE,"^",12)
 S DGENR("ELIG","EC")=$P(NODE,"^",13)
 S DGENR("ELIG","MTSTA")=$P(NODE,"^",14)
 S DGENR("ELIG","VCD")=$P(NODE,"^",15)
 S DGENR("ELIG","PH")=$P(NODE,"^",16)
 S DGENR("ELIG","UNEMPLOY")=$P(NODE,"^",17)
 S DGENR("ELIG","CVELEDT")=$P(NODE,"^",18)
 S DGENR("ELIG","SHAD")=$P(NODE,"^",19)
 S DGENR("ELIG","RADEXPM")=$P(NODE,"^",21)
 S DGENR("ELIG","MOH")=$P(NODE,"^",23)
 S DGENR("ELIG","CLE")=$P(NODE,"^",24) ;added with DG*5.3*909
 S DGENR("ELIG","CLEDT")=$P(NODE,"^",25) ;added with DG*5.3*909
 S DGENR("ELIG","CLEST")=$P(NODE,"^",26) ;added with DG*5.3*909
 S DGENR("ELIG","CLESOR")=$P(NODE,"^",27) ;added with DG*5.3*909
 S DGENR("ELIG","MOHAWRDDATE")=$P(NODE,"^",28) ;added with DG*5.3*972 HM
 S DGENR("ELIG","MOHSTATDATE")=$P(NODE,"^",29) ;added with DG*5.3*972 HM
 S DGENR("ELIG","MOHEXEMPDATE")=$P(NODE,"^",30) ;added with DG*5.3*972 HM
 S DGENR("ELIG","OTHTYPE")=$P(NODE,"^",31) ; DG*5.3*952
 ;S DGENCDZZ=1 ; for CD Testing (disabled).
 S NODE=$G(^DGEN(27.11,DGENRIEN,"U"))
 S DGENR("DATETIME")=$P(NODE,"^")
 S DGENR("USER")=$P(NODE,"^",2)
 Q 1
 ;
