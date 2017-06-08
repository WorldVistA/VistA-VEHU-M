DSIROI2 ;DSS/BLJ/EWL - Release Of Information ;04/14/2011 11:18
 ;;8.2;RELEASE OF INFORMATION - DSSI;;Nov 08, 2011;Build 25
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2053  FILE^DIE
 ;2056  GETS^DIQ
 ;10103 $$NOW^XLFDT
 ;10103 $$FMADD^XLFDT
 ;10046 $$EN^XUWORKDY
 Q
GETITEMS(RETN,IFN) ; Get a list of all documents for a request RPC - DSIR GET DOCUMENTS
 ; Input: IFN of request
 ;
 ; Return: Array of
 ;     IFN^
 ;
 S RETN=$NA(^TMP("DSIROI",$J))
 K @RETN
 N I M ^TMP("DSIROI",$J)=^DSIR(19620.1,"B",IFN)
 F I=0:0 S I=$O(^TMP("DSIROI",$J,I)) Q:'I  S ^TMP("DSIROI",$J,I)=I_U
 Q
 ;
CLEANUP(VEJDRETN) ; Does cleanup of all TMP globals used. RPC - DSIR CLEANUP
 K ^TMP("DSIROI",$J)
 K ^TMP("DSIRVAL",$J)
 S VEJDRETN=""
 Q
 ;       
FOLLOWUP(RETN,IEN) ; Set date of followup letter to today.  RPC - DSIR SET FOLLOWUP DATE
 ; input: IEN of entry to set date on
 ;
 ; Return: "1^" if successful
 ;         "-1^Error Message" if unsuccessful
 ;
 N X,DIERR,ERR,DSIR
 S DSIR(19620,IEN,.26)=$$NOW^XLFDT\1
 D FILE^DIE("K","DSIR","ERR")
 I '$D(DIERR) S RETN(1)="1^"
 E  S RETN(1)=$$ERR^DSIROI0
 Q
 ;
GETFOLLW(RETN) ; Get list of requests that require a followup  RPC - DSIR FOLLOWUP REQUIRED LIST
 ; letter
 ;
 ; No Input
 ; 
 ; Output: Array of
 ;    IEN^
 ;
 N X,DATE,ST,WRKD S X=0
 F ST="O","P" F  S X=$O(^DSIR(19620,"ACST",ST,X)) Q:'X  D
 .Q:$P($G(^DSIR(19620,X,2)),U,6)'=""
 .S DATE=$P($G(^DSIR(19620,X,10)),U,6)
 .S WRKD=$$EN^XUWORKDY(DATE,$$NOW^XLFDT)
 .Q:WRKD<10
 .; Filter out FOIA from Privacy Act
 .Q:$P($G(^DSIR(19620,X,0)),U)[19620.95
 .; 6 Feb 2001: Below added to filter out all requests from different divisions. 
 .Q:$P($G(^DSIR(19620,X,6)),U,3)'=$G(DUZ(2))
 .S RETN(X)=X
 .Q
 Q
 ;
GFOLLOW2(RETN) ; RPC - DSIR GET FOLLOWUP LETTER DATA
 ; No Input
 ; 
 ; Output: Array of
 ;    IEN^PATIENT^CLERK^REQUESTOR^STREET1^STREET2^STREET3^CSZ^SSN
 ; Or -1^no records found
 ;
 N IEN,IENS,GET,PATIENT,CLERK,APTR,ADDR,STR1,STR2,STR3,C,S,Z,CSZ,SSN,DATE,ST,WRKD
 S IEN=0,RTNS="" F ST="O","P" F  S IEN=$O(^DSIR(19620,"ACST",ST,IEN)) Q:'IEN  D
 .Q:$P($G(^DSIR(19620,IEN,2)),U,6)'=""
 .S DATE=$P($G(^DSIR(19620,IEN,10)),U,6)
 .S WRKD=$$EN^XUWORKDY(DATE,$$NOW^XLFDT)
 .Q:WRKD<10
 .; Filter out FOIA from Privacy Act
 .Q:$P($G(^DSIR(19620,IEN,0)),U)[19620.95
 .; 6 Feb 2001: Below added to filter out all requests from different divisions. 
 .Q:$P($G(^DSIR(19620,IEN,6)),U,3)'=$G(DUZ(2))
 .S IENS=IEN_"," D GETS^DIQ(19620,IENS,".01;.03;.11;.81;203","IE","GET")
 .S GT=$NA(GET(19620,IENS)),PATIENT=@GT@(.01,"E"),CLERK=@GT@(.03,"E"),SSN=@GT@(203,"E")
 .S APTR=@GT@(.81,"I")_"," D GETS^DIQ(19620.92,APTR,".02:.07","E","ADDR")
 .S GT=$NA(ADDR(19620.92,APTR)),STR1=@GT@(.02,"E"),STR2=@GT@(.03,"E"),STR3=@GT@(.07,"E")
 .S C=@GT@(.04,"E"),S=@GT@(.05,"E"),Z=@GT@(.06,"E"),CSZ=C_", "_S_" "_Z
 .S RETN(IEN)=IEN_U_PATIENT_U_CLERK_U_STR1_U_STR2_U_STR3_U_CSZ_U_SSN
 I RETN']"" S RETN="-1^no records found"
 Q
 ;
GETPREVY(RETN,DFN,REQ,DATE) ; Get #requests for a given patient since a given date.  RPC - DSIR REQUESTS SINCE DATE
 ;
 ; Input: DFN: Patient IFN
 ;        REQ: Requestor IFN
 ;       DATE: Earliest date to look from
 ;
 ; Return: Number of requests
 ;
 N X,RQDT S (X,RETN)=0
 I '$G(DFN) S RETN="-1^Must specify patient!" Q
 I '$G(DATE) S RETN="-1^Must specify date!" Q
 F  S X=$O(^DSIR(19620,"B",DFN,X)) Q:'X  D
 .S RQDT=$P($G(^DSIR(19620,X,10)),U,6) Q:RQDT<DATE
 .I REQ,REQ'=+$G(^DSIR(19620,X,1)) Q
 .S RETN=RETN+1
 Q
 ;
GETVER(RETN,RTN) ; Returns the current version of the ROI KIDS file  RPC - DSIR GET ROUTINE VERSION
 ;
 ;  INPUT : RTN: Routine to test.
 ; RETURN : VERSION^PATCH
 ;
 N PATCH,VERSION
 S VERSION=$T(+2^@RTN)
 S PATCH=$P($P(VERSION,";",5),"**",2)
 S VERSION=$P(VERSION,";",3)
 S RETN=VERSION_"^"_PATCH
 Q
