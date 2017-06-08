DENTVRP2 ;DSS/SGM - RPC CALLS FOR DSS DENTAL CPRS ;07/27/2003 17:16
 ;;1.2;DENTAL;**30,31,37,45**;Aug 10, 2001
 ;Copyright 1995-2005, Document Storage Systems, Inc., All Rights Reserved
 ;  See individual line tags for description of RPC calls
 ;  All rpcs in this routine make changes to file 220.5
 ;
ADD(DENT,CPT) ;  RPC: DENTV ADD QL ENTRY
 ;  this will add a CPT code to a person's quick list
 ;  CPT - required - CPT code name or ien to file 81
 ;  RETURN - 1 if successfully added
 ;          -1^error message
 I $G(CPT)="" S DENT="-1^No CPT input value received"
 N X S X="USR~DENTV CPT QUICK LIST~"_CPT_"~1"
 S DENT=$$ADD^DSICXPR(,X,1)
 Q
 ;
DEL(DENT,CPT) ;  RPC: DENTV DEL QL ENTRY
 ;  delete a CPT code from the user's quick list
 ;  CPT - required - CPT code name or ien to file 81
 ;  RETURN - 1 if successfully added
 ;          -1^error message
 I $G(CPT)="" S DENT="-1^No CPT input value received"
 N X S X="USR~DENTV CPT QUICK LIST~"_CPT
 S DENT=$$DEL^DSICXPR(,X,1)
 Q
 ;
GET(DENT) ;  RPC: DENTV ADA CODES QUICK
 ;  also called from ADA^DENTVTP1
 ;  RPC get quick list of cpt codes for user
 ;  return @DENT@(#) = data (see GETADA^DENTVRP1)
 ;  on error, @DENT@(1)="-1^No quick list on file"
 ;
 N X,Y,Z,DENTQ,INC,ROOT,USER
 D GLBINT^DENTVRP1 S DENT=ROOT
 S USER=+$$DPRV^DENTVUTL($G(DUZ))
 I 'USER S DENT(1)="-1^This user is not a valid dental user" Q
 D GET^DSICXPR(.DENTQ,"USR~DENTV CPT QUICK LIST")
 S X=$O(DENTQ(0))
 I $G(DENTQ(+X))<1!'X S DENT(1)="-1^No quick list found" Q
 ;  check for any inactive codes and delete them
 F INC=0:0 S INC=$O(DENTQ(INC)) Q:'INC  D
 .I '$$ACTCPT^DSICCPT(,+DENTQ(INC),DT,,1) K X D DEL(.X,+DENTQ(INC))
 .Q
 S X=$O(DENTQ(0))
 I $G(DENTQ(+X))<1!'X S DENT(1)="-1^No quick list found" Q
 F INC=0:0 S INC=$O(DENTQ(INC)) Q:'INC  D C^DENTVRP1(+DENTQ(INC))
 D GLBERR^DENTVRP1 S DENT=ROOT
 Q
 ;
GUIDE(RET,ADA,ADMG) ; RCP: DENTV GET CODING GUIDELINES
 ; gets the admin guideline and the coding guideline for display on the client
 ; ADA = ADA code to get
 ; returns -1^failure reason or array with word processing text.
 I ADA="" S RET="-1^ADA Code not passed in" Q
 N IEN,PIEN,CNT,P0,PA S CNT=0
 S IEN=+$$CPT^DSICCPT(,ADA,,,,1) I IEN="" S RET="-1^Invalid ADA Code" Q
 I $G(ADMG) S PA=$P($G(^DENT(228,IEN,3)),U) I PA]"" S CNT=CNT+1,RET(CNT)="Admin Note: "_PA
 F PIEN=0:0 S PIEN=$O(^DENT(228,IEN,4,PIEN)) Q:'PIEN  S P0=^(PIEN,0) D
 .S CNT=CNT+1,RET(CNT)=$P(P0,U)
 .Q
 Q
