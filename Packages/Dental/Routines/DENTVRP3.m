DENTVRP3 ;DSS/SGM - DSS DENTAL EDIT FILE 228 ;06/26/2003 15:35
 ;;1.2;DENTAL;**30,32,35,31,39,43,45,53,57**;Aug 10, 2001;Build 8
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;  This routine contains various rpcs for doing fileman enter/edits
 ;  into file 228
 ;
 ;  DBIA#  SUPPORTED
 ;  -----  ---------  -------------------------------------------
 ;   2052      x      $$GET1^DID
 ;   2053      x      FILE^DIE, UPDATE^DIE
 ;   2056      x      GETS^DIQ
 ;  10076      x      Global read of ^XUSEC(key,duz)     
 ;
ADD(RET,DATA) ; RPC: DENTV DD GET/ADD RECORD
 ;  get ien to file 228 (or add new entry)
 ;  DATA = cpt code name ^ flag   where flag=1 if adding new cpt code
 ;  return ien or -1^error message
 N I,J,X,Y,Z,ADD,CPT,CPTI,DENT,DENTERR,DENTI,DENTX,DIERR,FLG
 N X,Y,Z,CPT,CPTI,DENERR,DENT,DENTX,DIERR,FLG
 S X=$G(DATA),CPT=$P(X,U),FLG=+$P(X,U,2)
 ;  if don't own key can't edit file
 I '$$KEY(,1) S RET=$$ERR(1) Q
 I CPT="" S RET=$$ERR(2) Q
 ;  check for valid cpt code
 S X=$$CPT^DSICCPT(,CPT,,,,1) I X<1 S RET="-1^"_$P(X,U,2) Q
 S CPTI=+X,CPT=$P(X,U,2)
 I '$P(X,U,7) S RET="-1^CPT code "_CPT_" is inactive" Q
 ;  check to see if cpt already in file
 I $D(^DENT(228,CPTI,0)) S RET=CPTI Q
 I $E(CPT)="D" S RET="-1^Sorry, you cannot add a dental code" Q
 I 'FLG S RET="-1^"_CPT_" not found in file 228" Q
 ;  add local CPT codes to ADA table
 S DENTX(1)=CPTI,Y="+1,"
 S DENT(228,Y,.01)=CPTI
 S DENT(228,Y,.06)="LOCAL CODES"
 S DENT(228,Y,.15)="L"
 L +^DENT(228,0):1 E  S RET=$$ERR(3) Q
 D UPDATE^DIE(,"DENT","DENTX","DENERR") L -^DENT(228,0)
 I $G(DENTX(1))>0 S RET=+DENTX(1)
 E  S RET="-1^"_$$ERM
 Q
 ;
FILE(DENTX,DATA) ; RPC: DENTV DD FIELD UPDATE
 ;  rpc to edit entries to file 228, only these field in file 228 are allowed 
 ;  to be edited: ^.01^.18^.16^1.14^1.15^3^5^
 ;  DATA(1)     = ien to file 228
 ;  DATA(2...n) = field# in 228 ^ value
 ;   Example: DATA(1)=100268
 ;            DATA(2)=".18^30"        RVU
 ;            DATA(3)=".16^1"        PRODUCT LINE IEN
 ;            DATA(4)="1.14^500.00"  VA COST
 ;            DATA(5)="1.15^555.00"  EQUIV PRIVATE COST
 ;            DATA(7)="3^"           ADMIN GUIDELINE
 ;            DATA(8)="5^528.3"      PRIMARY DEFAULT DX  (the first entry for field 5)
 ;            DATA(9)="5^528.5"      ADDITIONAL DEFAULT DX (in priority order)
 ;            DATA(10)="5^528.09"    ADDITIONAL DEFAULT DX
 ;            DATA(11)="5^525.40"    ADDITIONAL DEFAULT DX
 ;            DATA(12)="5^V60.0"     ADDITIONAL DEFAULT DX
 N I,J,X,Y,Z,ALLOW,DA,DENL,DENT,DENTER,DENTEX,DENX,DIERR,FLD,FLDS,IENS,TOT
 N LOCAL,VAL,X0,X1
 S IENS=$G(DATA(1)),X0=$G(^DENT(228,+IENS,0)),X1=$G(^(1))
 S LOCAL=$P(X0,U,15)="L"
 S ALLOW="^.01^.18^.16^1.14^1.15^3^5^" ;allow filing of RVU data P39 ;P57 added/removed fields
 I X0=""!'IENS S DENTX="-1^Invalid file 228 entry number: "_IENS Q
 ;  must own key to use this rpc
 I '$$KEY(,1) S DENTX=$$ERR(1) Q
 I $O(DATA(1))="" S DENTX="-1^No data sent to be filed" Q
 ;  validate all inputs
 S DENL=1,IENS=IENS_",",DA=+IENS,TOT=0
 F I=2:1 Q:'$D(DATA(I))  S X=$P(DATA(I),U),Y=$P(DATA(I),U,2) S:X<5 FLDS(X)=Y I X=5 S TOT=TOT+1,FLDS(X,TOT)=Y
 S Z="" F I=0:0 S I=$O(FLDS(I)) Q:'I  S:ALLOW'[(U_I_U) Z=Z_I_";"
 I Z'="" S DENTX="-1^You are not allowed to edit these fields: "_Z Q
 K Z S DENL=0 F  S DENL=$O(FLDS(5,DENL)) Q:'DENL  S X=FLDS(5,DENL) D
 .S Y=$$ICD9^DSICDRG(,X,"100;101;102",,,1)
 .I Y<1 S I=1+$O(Z("A"),-1),Z(I)=$P(Y,U,2) Q
 .I '$P(Y,U,10) S Z=$G(Z)_$P(Y,U,2)_" as of "_$P($P(Y,U,12),";",2)_"; "
 .E  S FLDS(5,DENL)=+Y
 .Q
 I $D(Z) S DENTX="" D  S DENTX="-1^"_DENTX Q
 .I $G(Z)'="" S DENTX="These diagnosis codes are inactive: "_Z
 .F I=0:0 S I=$O(Z(I)) Q:'I  S DENTX=DENTX_Z(I)_"; "
 .Q
 I $D(FLDS(.01)) S X=FLDS(.01) D
 .I "@"'[X S Z=$$ERR(5) Q
 .I 'LOCAL S Z=$$ERR(6)
 .Q
 I $D(FLDS(.01)) S DENT(228,IENS,.01)=FLDS(.01)
 S DENT(228,IENS,.18)=$G(FLDS(.18)) ;P53 file these (even if 0)
 S DENT(228,IENS,.16)=$G(FLDS(.16)) ;P53 file these
 S DENT(228,IENS,1.14)=$G(FLDS(1.14)) ;patch 43 VA Vost to Perform
 S DENT(228,IENS,1.15)=$G(FLDS(1.15)) ;patch 43 Equivalent Private Cost
 S DENT(228,IENS,3)=$G(FLDS(3)) ;patch 45 admin guidelines
 L +^DENT(228,+IENS):2 E  S DENTX=$$ERR(4) Q
 K DENTER,DIERR
 D FILE^DIE(,"DENT","DENTER")
 I $D(DENTER) S DENTX="-1^"_$$ERM Q
 K DENT S I=0
 F  S I=$O(FLDS(5,I)) Q:'I  S DENT(228.05,"+"_I_","_+IENS_",",.01)=$G(FLDS(5,I)) I '$D(DIERR) S DENTX="1^Entry successfully updated"
 I $D(DENT(228.05)) K ^DENT(228,+IENS,5) D UPDATE^DIE(,"DENT","DENTX","DENTER") K DENT
 L -^DENT(228,+IENS)
 Q
 ;
GTD(RET,CPT) ; RPC: DENTV DD GET DATA
 ; rpc to get data from file 228
 ;return RET(#) = field# ^ field name ^ internal value ^ external value ^addtnl data
 ;fields returned are: ".01;.07;.15;.18;.16;.17;1.01;1.14;1.15;3;5"
 ; Example:
 ; RET(1)=".01^ADA CODE^103743^D0415^Collection of microorganisms"
 ; RET(2)=".07^SUBCATEGORY-2^MISC^MISC"
 ; RET(3)=".15^TYPE^C^VACO"
 ; RET(4)=".16^VA-DSS GROUP^8^DES008"
 ; RET(5)=".17^FLAGS^^"
 ; RET(6)=".18^RVU^15^15"
 ; RET(7)="1.01^TOTAL MAPPED DIAGNOSES^6^6"
 ; RET(8)="1.14^VA COST TO PERFORM^^"
 ; RET(9)="1.15^EQUIVALENT PRIVATE COST^^"
 ; RET(10)="3^ADMIN GUIDELINE^^"
 ; RET(11)="5^DEFAULT DIAGNOSES^2875^528.3^CELLULITIS/ABSCESS MOUTH"
 ; RET(12)="5^DEFAULT DIAGNOSES^2877^528.5^DISEASES OF LIPS"
 N I,X,Y,DENTER,DIERR,FLD,IC,ICD,CNT,DENTV,DENV,DESC
 ;  must be administrator to use this rpc
 I '$$KEY(,1) D SET($$ERR(1)) Q
 ;  check for cpt code sent
 I $G(CPT)="" D SET($$ERR(2)) Q
 S X=$$CPT^DSICCPT(,CPT,,,,1) I X<1 S RET(1)=X Q
 I '$D(^DENT(228,+X,0)) D SET("CPT"_$P(X,U,2)_" not found in ADA table") Q
 S CPT=+X,DESC=$P(X,U,3)
 D GETS^DIQ(228,CPT,".01;.07;.15;.18;.16;.17;1.01;1.14;1.15;3","IE","DENTV")
 S DENV="DENTV(228,"""_CPT_","")"
 S FLD=0,CNT=0 F  S FLD=$O(@DENV@(FLD)) Q:'FLD  D
 .S CNT=CNT+1,RET(CNT)=FLD_"^^"_$G(@DENV@(FLD,"I"))_U_$G(@DENV@(FLD,"E"))
 .I FLD=.01 S $P(RET(CNT),U,5)=DESC
 .Q
 S IC=0 F  S IC=$O(^DENT(228,CPT,5,IC)) Q:'IC  D
 .S ICD=+$G(^DENT(228,CPT,5,IC,0)),X=$$ICD9^DSICDRG(,ICD,,,,1)
 .I X>0 S CNT=CNT+1,RET(CNT)=5_U_U_$P(X,U,1,2)_U_$P(X,U,4)
 .Q
 S FLD=0 F  S FLD=$O(RET(FLD)) Q:'FLD  S X=+RET(FLD) D
 .K DENTER,DIERR S Y=$$GET1^DID(228,X,"","LABEL",,"DENTER")
 .I '$D(DIERR),Y'="" S $P(RET(FLD),U,2)=Y
 .Q
 Q
 ;
KEY(RET,FUN) ; RPC: DENTV DD SECURITY KEY
 ;  check for security key - either called from above or rpc
 ;  if $G(FUN) then extrinsic function, else rpc call
 ;  returns 1 or 0
 N X,Y,Z
 S RET=$D(^XUSEC("DENTV EDIT FILE",DUZ))
 I $G(FUN) Q $$GET1^DSICXPR(,"USR~DENTV DRM ADMINISTRATOR",1)=1
 Q
 ;
 ;  --------------------  SUBROUTINES  --------------------
ERR(X) ; Error processor
 I X=1 Q "-1^Access to this file to not allowed"
 I X=2 Q "-1^No CPT code received"
 I X=3 Q "-1^Unable to lock file 228, try again"
 I X=4 Q "-1^Unable to lock record "_(+IENS)_" in file 228, try again"
 I X=5 Q "-1^Changing of the .01 field value is not allowed"
 I X=6 Q "-1^Deletion of a nationally maintained procedure code is not allowed"
 Q ""
 ;
ERM() Q $$MSG^DSICFM01("EV",,,,"DENTER")
 ;
SET(T) N N S N=1+$O(RET("A"),-1)
 S RET(N)=$S(+T=-1:T,1:"-1^"_T) Q
 ;
GC(RET) ;RPC - DENTV ADA GET COSTS
 N I,X,X0,X1,DEN
 S RET=$NA(^TMP("DENTV",$J)) K @RET
 F I=0:0 S I=$O(^DENT(228,I)) Q:'I  S X0=$G(^(I,0)) I $P(X0,U,2)="" D
 .S X=$$CPT^DSICCPT(,I,,,,1) Q:X=""!($P(X,U,7)=0)
 .S X1=$G(^DENT(228,I,1))
 .S DEN=$P(X,U)_U_$P(X,U,2)_"  "_$P(X,U,3)_U_$P(X1,U,14)_U_$P(X1,U,15)_U_$P(X0,U,18)
 .S X=$S($P(X,U,2)=+$P(X,U,2):"X"_$P(X,U,2),1:$P(X,U,2))
 .S @RET@(X)=DEN
 .Q
 I '$D(@RET) S @RET@(1)="-1^No data found"
 Q
