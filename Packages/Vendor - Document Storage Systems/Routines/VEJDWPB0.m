VEJDWPB0 ; DSS/BLJ ;08/27/2000 20:29
 ;;2.11;VEJDCERT RPCS;;Mar 06, 2002
 Q  ; Call via line tags only.
 ;
PLACTIV(VEJDRETN,VEJDDFN) ; Retrieve active problems.
 ; Input: VEJDDFN: Patient IFN
 ;
 ; Return: VEJDRETN: Array
 ;     Lines 1-n : Problem IEN^ICD Diagnosis code^Problem Desc.
 ;
 I +$G(VEJDDFN)=0 S VEJDRETN(1)="-1^Patient DNF Undefined!" Q
 N VEJDDATA,VEJDLOOP
 D ACTIVE^GMPLUTL(VEJDDFN,.VEJDDATA)
 S VEJDLOOP=0
 F  S VEJDLOOP=$O(VEJDDATA(VEJDLOOP)) Q:VEJDLOOP=""  D
 .S VEJDRETN(VEJDLOOP)=$G(VEJDDATA(VEJDLOOP,0))_U
 .S VEJDRETN(VEJDLOOP)=VEJDRETN(VEJDLOOP)_$P($G(VEJDDATA(VEJDLOOP,2)),U,2)_U
 .S VEJDRETN(VEJDLOOP)=VEJDRETN(VEJDLOOP)_$P($G(VEJDDATA(VEJDLOOP,1)),U,2)
 K VEJDDATA,VEJDLOOP
 Q
PLACTIV1(VEJDRETN,VEJDDFN,VEJDPROB) ; Retrieve specific active problem.
 ; Input: VEJDDFN: Patient IFN
 ;        VEJDPROB: Problem List IEN
 ;
 ; Return: VEJDRETN: Array
 ;         Line 1: Problem List IEN
 ;         Line 2: Internal^external value of problem description.
 ;         Line 3: Internal^external value of ICD code
 ;         Line 4: Internal^external value of the date of onset
 ;         Line 5: Abbreviated^full text of relationship to service
 ;                 connections.
 ;         Line 6: Abbreviated^full text of relationship to special
 ;                 exposure (i.e. Agent Orange, Radiation, etc.
 ;
 I +$G(VEJDDFN)=0 S VEJDRETN(1)="-1^Patient DFN is undefined" Q
 I +$G(VEJDPROB)=0 S VEJDRETN(1)="-1^Problem list IFN is undefined" Q
 N VEJDDATA,VEJDLOOP
 D ACTIVE^GMPLUTL(VEJDDFN,.VEJDDATA)
 I VEJDDATA(0)<1 S VEJDRETN(1)="-1^There are no problems for this patient."
 S VEJDLOOP=0
 F  S VEJDLOOP=$O(VEJDDATA(VEJDLOOP)) Q:VEJDLOOP=""!($G(VEJDDATA(VEJDLOOP,0))=VEJDPROB)
 I VEJDLOOP="" S VEJDRETN(1)="-1^Problem List IEN not found."
 M VEJDRETN=VEJDDATA(VEJDLOOP)
 Q
CREATE(VEJDRETN,VEJDDATA) ; Create a new problem in problem list.
 ; Input: VEJDDATA: Array
 ;   Required:
 ;        "PATIENT": Patient IFN
 ;        "NARRATIVE": Text of the problem
 ;        "PROVIDER": Provider IFN in file 2.
 ;   Optional:
 ;        "DIAGNOSIS": ICD Diagnosis (file 80) IEN
 ;        "LEXICON"  : Clinical Lexicon file (file 757.01) IEN
 ;        "STATUS"   : A or I (active or inactive)
 ;        "ONSET"    : Date of onset in internal fileman format.
 ;        "RECORDED" : Date this problem was recorded.
 ;        "RESOLVED" : Date this problem was resolved or inactivated.
 ;        "COMMENT"  : <61 characters of text.
 ;        "LOCATION" : Hospital location (file 44) IEN.
 ;        "SC"       : 1 or 0 flag for service connection.
 ;        "AO"       : 1 or 0 flag for Agent Orange
 ;        "IR"       : 1 or 0 flag for Ionizing Radiation.
 ;        "EC"       : 1 or 0 flag for Environmental Contaminations
 ;
 ; Return:
 ;        Successful add: "1^new IEN in problem list"
 ;        Unsuccessful add: "-1^Error message"
 ;
 N %,%I,%H,%T,VEJDNOW D NOW^%DTC S VEJDNOW=$P(%,".")
 S:$G(VEJDDATA("PROVIDER"))="" VEJDDATA("PROVIDER")=DUZ
 ;S:VEJDDATA("ONSET")="" VEJDDATA=VEJDNOW
 S:$G(VEJDDATA("RECORDED"))="" VEJDDATA("RECORDED")=VEJDNOW
 D CREATE^GMPLUTL(.VEJDDATA,.VEJDRETN)
 I $P($G(VEJDRETN),U)="-1" S VEJDRETN=VEJDRETN_U_VEJDRETN(0) K VEJDRETN(0)
 I $P($G(VEJDRETN),U)="-1" S VEJDRETN="1^"_VEJDRETN
 Q
UPDATE(VEJDRETN,VEJDDATA) ; Update problem list.
 ; Input: VEJDDATA: Array
 ;   Required:
 ;       "PROBLEM": IEN in Problem file (file 9000011)
 ;       "PROVIDER": Provider IFN in NEW PERSON file (file 200).  Will
 ;                   be set to DUZ if blank.
 ;   Optional:  Note: A null or blank field will not be modified.
 ;       "NARRATIVE":
 ;       "DIAGNOSIS":
 ;       "LEXICON"  :
 ;       "STATUS"   :
 ;       "ONSET"    :
 ;       "RECORDED" : For all parameters, see description above.
 ;       "RESOLVED" :
 ;       "COMMENT"  :
 ;       "LOCATION" :
 ;       "SC"       :
 ;       "AO"       :
 ;       "IR"       :
 ;       "EC"       :
 ;
 I +$G(VEJDDATA("PROBLEM"))=0 S VEJDRETN(1)="-1^Problem IEN not defined." Q
 I +$G(VEJDDATA("PROVIDER"))=0 S VEJDDATA("PROVIDER")=DUZ
 D UPDATE^GMPLUTL(.VEJDRETN,.VEJDDATA)
 I $P($G(VEJDRETN),U)="-1" S VEJDRETN=VEJDRETN_U_VEJDRETN(0) K VEJDRETN(0)
 I $P($G(VEJDRETN),U)'="-1" S VEJDRETN="1^"_VEJDRETN
 Q
