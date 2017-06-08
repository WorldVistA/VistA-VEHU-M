DSICPL ; DSS/BLJ - PROBLEM LIST RPCS ;11/15/2002 11:58
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA 928 - ^GMPLUTL:  CREATE, UPDATE
 ;
CREATE(DSICX,DATA) ; RPC: DSIC ADD PROBLEM
 ; Create a new problem in problem list.
 ; Input: DATA(sub) where sub equals
 ;   Required:
 ;        "PATIENT"  : Patient IFN
 ;        "NARRATIVE": Text of the problem
 ;        "PROVIDER" : Provider IFN in file 200.
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
 ;        "MST"      : 1 or 0 - military sexual trauma
 ;        "HNC"      : 1 or 0 - head & neck cancer
 ;
 ; Return:
 ;        Successful add: "1^new IEN in problem list"
 ;        Unsuccessful add: "-1^Error message"
 ;
 S:$G(DATA("PROVIDER"))="" DATA("PROVIDER")=DUZ
 S:$G(DATA("RECORDED"))="" DATA("RECORDED")=DT
 D CREATE^GMPLUTL(.DATA,.DSICX)
 I $P($G(DSICX),U)="-1" S DSICX=DSICX_U_DSICX(0) K DSICX(0)
 E  S DSICX="1^"_DSICX
 Q
UPDATE(DSICX,DATA) ; RPC: DSIC UPDATE PROBLEM
 ; Update problem list.
 ; Input: DATA(sub) where sub equals
 ;   Required:
 ;       "PROBLEM": IEN in Problem file (file 9000011)
 ;       "PROVIDER": Provider IFN in NEW PERSON file (file 200).  Will
 ;                   be set to DUZ if blank.
 ;   Optional:
 ;     Note: A null or blank field will not be modified
 ;     For definition see CREATE above
 ;    "NARRATIVE", "DIAGNOSIS", "LEXICON", "STATUS"
 ;    "ONSET", "RECORDED", "RESOLVED", "COMMENT"
 ;    "LOCATION", "SC", "AO", "IR", "EC", "MST", "HNC"
 ;
 I +$G(DATA("PROBLEM"))=0 S DSICX(1)="-1^Problem IEN not defined." Q
 I $G(DATA("PROVIDER"))<1 S DATA("PROVIDER")=DUZ
 D UPDATE^GMPLUTL(.DSICX,.DATA)
 I $P($G(DSICX),U)="-1" S DSICX=DSICX_U_DSICX(0) K DSICX(0)
 E  S DSICX="1^"_DSICX
 Q
