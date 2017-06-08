DENTVRP5 ;DSS/KC - DSS DENTAL PROVIDER EDIT FILE 220.5 ;01/13/2004 10:53
 ;;1.2;DENTAL;**38,59**;Aug 10, 2001;Build 19
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ;  This routine contains various rpcs for doing fileman enter/edits
 ;  into file 220.5
 ;
 ;  DBIA#  SUPPORTED
 ;  -----  ---------  -------------------------------------------
 ;   2053      x      ^DIE: FILE, UPDATE
 ;   2056      x      GETS^DIQ
 ;
EDIT(RET,DATA) ; - RPC - DENTV PROVIDER ADD UPDATE
 ;  DATA array contains the input parameters
 ;  DATA("PERSON") = pointer to file 200 (NEW PERSON)
 ;  DATA("IEN") = pointer to file 220.5, for Update records only
 ;  DATA("PROVNUM") = 8 character number for new dental provider number
 ;  DATA("OLDNUM") = 4 character number for dental provider number (old# - will be deprecated w/ DAS)
 ;  DATA("INACTIVE") = inactive flag "1" = inactive
 ;  RETURN: ien^message if filed okay
 ;      or -1^message if an error occurs
 ;
 N X,Z,DENT,DENTER,DIERR,EDT,IENS,P,DENTIEN
 S Z(.04)=$G(DATA("PROVNUM"))
 S Z(1)=$G(DATA("OLDNUM"))
 S Z(2)=+$G(DATA("INACTIVE"))*-1
 S IENS=+$G(DATA("IEN")),DENTIEN(1)=IENS
 I IENS=0 S P=+$G(DATA("PERSON")) I 'P S RET="-1^Invalid Person, cannot Add Provider" Q
 ;lock the file and add/update the record
 L +^DENT(220.5,+IENS):2 E  S RET="-1^Unable to lock record-try again later" Q
 I 'IENS M DENT(220.5,"+1,")=Z D
 .S X=1+$P($G(^DENT(220.5,0)),U,3),DENTIEN(1)=X,DENT(220.5,"+1,",.01)=P
 .D UPDATE^DIE(,"DENT","DENTIEN","DENTER")
 .Q
 I IENS S IENS=IENS_"," M DENT(220.5,IENS)=Z D FILE^DIE(,"DENT","DENTERR")
 L -^DENT(220.5,+IENS)
 I '$D(DIERR) S RET=DENTIEN(1)_"^Record successfully "_$S(IENS=0:"added",1:"updated")
 E  S RET="-1^"_$$MSG^DSICFM01("VE",,,,"DENTER")
 Q
 ;
PROV(RET) ; RPC - DENTV GET ALL PROVIDERS
 ; RETURNS: data(n) = provider name^provider ien (220.5)^old dental prov id
 ;                    ^new dental prov id^inactive flag^provider ien (200)
 ;          or        -1^No Providers found
 ;providers are in alphabetical order
 ;  Patch 59 modified this to a global return, fixed undefined error when no name in ^VA(200, file
 N DENT,DENTERR,IEN,NM,P,NUM
 S RET=$NA(^TMP("DENTVRP5",$J)),NUM=1
 F P=0:0 S P=$O(^DENT(220.5,P)) Q:'P  S NODE=$G(^(P,0)) D
 .K DENT,DENTERR
 .S IEN=+NODE_"," D GETS^DIQ(200,IEN,".01","E","DENT","DENTERR")
 .I $D(DENTERR)!('$D(DENT(200,IEN,.01,"E"))) Q
 .I DENT(200,IEN,.01,"E")="" S NM="UNKNOWN"_NUM,NUM=NUM+1
 .I DENT(200,IEN,.01,"E")'="" S NM=$G(DENT(200,IEN,.01,"E"))
 .S @RET@(NM)=NM_U_P_U_$P(NODE,U,2)_U_$S(+$P(NODE,U,4):$P(NODE,U,4),1:0)_U_(+$P(NODE,U,3)*-1)_U_+NODE
 I $O(@RET@(""))="" S @RET@(1)="-1^No Providers found" Q
 Q
 ;
TYPE(RET) ; RPC - DENTV GET PROVIDER TYPES
 ; RETURNS: data(n) = type name^code
 ;          or        -1^No Provider Types found
 ;provider types are in alphabetical order
 ;  
 N I,NODE,CODE S I=0
 F  S I=$O(^DENT(220.51,I)) Q:'I  S NODE=$G(^(I,0)) D
 .I $P(NODE,U)=""!($P(NODE,U,3)) Q
 .S CODE=$P(NODE,U,2) IF $L(CODE)=1 S CODE="0"_CODE
 .S RET(+CODE)=CODE_"-"_$P(NODE,U)_U_(+$P(NODE,U,4)*-1)
 .Q
 I $O(RET(""))="" S RET(1)="-1^No Provider Types found" Q
 Q
 ;
SPEC(RET) ; RPC - DENTV GET PROVIDER SPECIALTIES
 ; RETURNS: data(n) = specialty name^code
 ;          or        -1^No Provider Specialties found
 ;provider types are in alphabetical order
 ;  
 N I,NODE,CODE S I=0
 F  S I=$O(^DENT(220.52,I)) Q:'I  S NODE=$G(^(I,0)) D
 .I $P(NODE,U)=""!($P(NODE,U,3)) Q
 .S CODE=$P(NODE,U,2) IF $L(CODE)=1 S CODE="0"_CODE
 .S RET(+CODE)=CODE_"-"_$P(NODE,U)
 .Q
 I $O(RET(""))="" S RET(1)="-1^No Provider Specialties found" Q
 Q
