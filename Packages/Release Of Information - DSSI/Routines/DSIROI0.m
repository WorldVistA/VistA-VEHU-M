DSIROI0 ;DSS/BLJ/EWL - Release Of Information ;04/14/2011 11:18
 ;;8.2;RELEASE OF INFORMATION - DSSI;;Nov 08, 2011;Build 25
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2050  MSG^DIALOG
 ;2053  UPDATE^DIE
 ;2053  FILE^DIE
 ;
 Q  ; only call via line tags.
 ;
ERR(WIDTH,LEFT) ;  process error message expected in ERR, return -1^error msg
 N X,Z,TMP S WIDTH=$G(WIDTH,72),LEFT=$G(LEFT,0)
 D MSG^DIALOG("AE",.TMP,WIDTH,LEFT,"ERR") S Z="-1^"
 F X=0:0 S X=$O(TMP(X)) Q:'X  S Z=Z_TMP(X)_" "
 Q Z
 ;
NEWITEM(RETN,VEJDDATA) ; Create a new released document RPC - DSIR ADD DOCUMENT
 ; Input: Array of
 ;        (1): Pointer to VEJD ROI INSTANCE (19620) file
 ;        (2): Internal Set of Codes value for document type
 ;        (3): Document IEN (If applicable)
 ;        (4): Internal Set of Codes value for document media
 ;        (5): Caption
 ;        (6): Document length
 ;        (7): Date/time of document
 ;        (8): Creator of Document: Needs to be a pointer to the NEW PERSON file
 ;        (9): Include in Billing (0 - No, 1 - Yes)
 ;
 N DIERR,ERR,ROOT,VEJD
 S ROOT(19620.1,"+1,",.01)=$G(VEJDDATA(1))
 S ROOT(19620.1,"+1,",.02)=$G(VEJDDATA(2))
 S ROOT(19620.1,"+1,",.03)=$G(VEJDDATA(3))
 S ROOT(19620.1,"+1,",.04)=$G(VEJDDATA(4))
 S ROOT(19620.1,"+1,",.05)=$G(VEJDDATA(5))
 S ROOT(19620.1,"+1,",.06)=$G(VEJDDATA(6))
 S ROOT(19620.1,"+1,",.07)=$G(VEJDDATA(7))
 S ROOT(19620.1,"+1,",.08)=$G(VEJDDATA(8))
 S ROOT(19620.1,"+1,",.09)=$G(DUZ)
 S ROOT(19620.1,"+1,",2.01)=$G(VEJDDATA(9))
 D UPDATE^DIE("","ROOT","VEJD","ERR")
 I '$D(DIERR) S RETN(1)="1^"_VEJD(1)
 E  S RETN(1)=$$ERR
 Q
ADDNCPR(AXY,NAME,SSN,DOB,OVRD,NCPIEN) ;RPC - DSIR ADD NONCOMP PAT
 ; Modified to allow updates January 2007 EWL
 ;
 ;Input Parameters:
 ;       NAME   - Patient Name (Required)
 ;       SSN    - Patient Social Security Number or Identifier (last 4) (Optional)
 ;       DOB        - Date of Birth (Optional)
 ;       OVRD   - Override Lookup (Optional) If 1 the RPC will laygo new entry into 19620.96 without checking xrefs
 ;       NCPIEN - If this exists then it is an update not an add.  ADDED 11/30/2006 EWL
 ;
 ;Return values may be one of the following:
 ;
 ;       -1^Error text
 ;       or
 ;       1^NNNN;DSIR(19620.96,^NAME,PATIENT
 ;         Where NNNN is the IEN in 19620.96
 ;  
 S AXY(1)="" I $G(NAME)="" S AXY(1)="-1^Unable to add/update patient record. Missing data." Q
 N IEN,DFN
 S OVRD=+$G(OVRD),DOB=$G(DOB),SSN=$G(SSN)
 S:SSN="" SSN=0 ; IF NO SSN SET IT TO 0 (ZERO)
 I 'OVRD,$D(^DPT("SSN",SSN)) D
 .S DFN=+$O(^DPT("SSN",SSN,0)),AXY(1)="-1^Social Security Number "_SSN_" on file for "_$P($G(^DPT(DFN,0)),U)_"!" Q
 S IEN=$G(NCPIEN)
 ;
 ;IF THERE IS A SPECIFIC IEN TO UPDATE
 I IEN'="" D NCPUPD(.AXY,NAME,SSN,DOB,OVRD,IEN) Q
 ;NO IEN SPECIFIED
 I IEN="" D NCPADD(.AXY,NAME,SSN,DOB,OVRD)
 Q
NCPADD(DSIRRET,NAME,SSN,DOB,OVRD) ;
 N IEN,AA,YY,DSIRA,NEW,DSIR,ERR S YY=0,NEW="+1,"
 ;IF OVERRIDE IS NOT SPECIFIED AND THE SSN ALREADY EXISTS IN 19620.96
 I 'OVRD,$D(^DSIR(19620.96,"SSN",SSN)) S IEN=0 D  Q
 .;RETURN ALL INFO FOR ANY NONCOMP WITH THIS SSN
 .F  S IEN=+$O(^DSIR(19620.96,"SSN",SSN,IEN)) Q:'IEN  S YY=YY+1 D  Q
 ..S DSIRRET(YY)=0_U_IEN_";DSIR(19620.96,"_U_$P($G(^DSIR(19620.96,IEN,0)),U)_U
 ..S DSIRRET(YY)=DSIRRET(YY)_$P($G(^DSIR(19620.96,IEN,0)),U,2)
 ;
 ;IF OVERRIDE IS NOT SPECIFIED AND THE NAME ALREADY EXISTS IN 19620.96
 I 'OVRD,$O(^DSIR(19620.96,"B",NAME))[NAME!($D(^DSIR(19620.96,"B",NAME))) D  Q
 .S (AA,BB)=$NA(^DSIR(19620.96,"B",NAME)),BB=$P(BB,""")")
 .F YY=0:1 S AA=$Q(@AA) Q:AA=""!(AA'[BB)  D
 ..S IEN=+$QS(AA,4) Q:'IEN  D
 ...S DSIRRET(YY)=0_U_IEN_";DSIR(19620.96,"_U_$P($G(^DSIR(19620.96,IEN,0)),U)_U_$P($G(^DSIR(19620.96,IEN,0)),U,2)
 ;
 ;OTHERWISE CREATE A NEW RECORD
 S DSIRA(19620.96,NEW,.01)=NAME,DSIRA(19620.96,NEW,.09)=SSN,DSIRA(19620.96,NEW,.02)=DOB
 D UPDATE^DIE("","DSIRA","DSIR","ERR")
 I $D(ERR) M ^TMP("XXX")=ERR S DSIRRET(1)="-1^Unable to create record!" Q
 S DSIRRET(1)=1_U_DSIR(1)_";DSIR(19620.96,"_U_NAME
 Q
NCPUPD(DSIRRET,NAME,SSN,DOB,OVRD,IEN) ;
 N TDATA,UPDTFLAG,FDA,ERR
 I '$D(^DSIR(19620.96,IEN,0)) S DSIRRET(1)="-1^Unable to update, record not on file!" Q
 S TDATA=$G(^DSIR(19620.96,IEN,0)),UPDTFLAG=0
 I $P(TDATA,U,1)'=NAME S FDA(19620.96,IEN_",",.01)=NAME,UPDTFLAG=1
 I $P(TDATA,U,2)'=DOB S FDA(19620.96,IEN_",",.02)=DOB,UPDTFLAG=1
 I $P(TDATA,U,9)'=SSN S FDA(19620.96,IEN_",",.09)=SSN,UPDTFLAG=1
 D FILE^DIE("","FDA","ERR")
 I $D(ERR) S DSIRRET(1)="-1^Unable to update record!" Q
 S DSIRRET(1)=1_U_IEN_";DSIR(19620.96,"_U_NAME
 Q
