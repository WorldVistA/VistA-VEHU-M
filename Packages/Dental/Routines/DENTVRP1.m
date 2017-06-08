DENTVRP1 ;DSS/SGM - RPC CALLS FOR DSS DENTAL CPRS ;07/30/2003 22:21
 ;;1.2;DENTAL;**30,34,36,31,37,39,43,45,57,60**;Aug 10, 2001;Build 3
 ;Copyright 1995-2010, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  DBIA#  SUPPORTED
 ;  -----  ---------  --------------------------------------------
 ;   2051      x      FIND^DIC
 ;   2056      x      $$GET1^DIQ
 ;   3065      x      $$NAMEFMT^XLFNAME
 ;  10060      x      FM read of all fields in file 200
 ;  10104      x      ^XLFSTR: $$LOW, $$UP
 ;
CAT(RET,TYP) ;  RPC: DENTV GET CATEGORIES
 ;  return ada categories from 228
 ;  TYP - optional - <1> for subcategory-1  <2> for sub cat-2
 ;                   <Null>,<12> - for both subcategories [default]
 N I,J,X,Y,Z,IDX
 S TYP=$G(TYP,12)
 F I=1,2 S IDX="AS"_I I TYP[I S Y="" D
 .F  S Y=$O(^DENT(228,IDX,Y)) Q:Y=""  S Z(Y)=""
 .Q
 S Y=""
 F I=1:1 S Y=$O(Z(Y)) Q:Y=""  S RET(I)=$E(Y)_$$LOW^XLFSTR($E(Y,2,$L(Y)))
 Q
 ;
CATC(RET,TYP) ;  RPC: DENTV GET CATEG/CODES
 ;  TYP - required - name of subcategory
 ;  return ada data for a given subcategory TYP
 N I,X,Y,Z,DATA,IDX,ROOT,VIEN
 I $G(TYP)="" S RET(1)="-1^No dental category sent" Q
 S TYP=$$UP^XLFSTR(TYP)
 I $D(^DENT(228,"AS1",TYP)) S IDX="AS1"
 E  I $D(^DENT(228,"AS2",TYP)) S IDX="AS2"
 I '$D(IDX) S RET(1)="-1^"_TYP_" is an invalid category" Q
 D GLBINT S VIEN=0
 F  S VIEN=$O(^DENT(228,IDX,TYP,VIEN)) Q:'VIEN  D
 .S X=+^DENT(228,VIEN,0) D C(X)
 .Q
 D GLBERR S RET=ROOT
 Q
 ;
DC(RET) ;  RPC: DENTV DENTAL CLASSIFICATIONS
 ;  rpc to return dental classifications (#220.2)
 ;  ret(#) = ien to file 220.2 ^ name from 220.2 ^ I/O
 ;    where I = inpatient classification , O = outpatient
 N I,J S (I,J)=0
 F  S I=$O(^DIC(220.2,I)) Q:'I  D
 .S J=J+1,RET(J)=I_U_$P(^(I,0),U)_U_$E("IO",(I>8)+1) ;P60 reactivated IEN "12"
 .Q
 Q
 ;
INP(RET,DFN,FUN) ; RPC: DENTV INPATIENT BEDSECTION
 ;  DFN - required - pointer to PATIENT file
 ;  FUN - optional - if FUN, then extrinsic function, else RPC
 ;  RETURN: p1^p2^p3^p4^p5  where
 ;          p1 = Boolean flag (1 or 0) indicating inpatient status
 ;          p2 = PTF Specialty pointer
 ;          p3 = PTF Specialty name
 ;          p4 = DAS Bedsection pointer
 ;          p5 = DAS Bedsection name
 ;  p2,p3,p4,p5 - only returned if patient is an inpatient
 ;  On error, return -1^message
 N X,Y,Z,DAS,DENX
 S X=$$DFN^DENTVRF0($G(DFN)) I X<1 S RET=X G OUT
 D IN^DSICDPT2(.DENX,DFN) S X=DENX(1)
 S RET=$S(X<0:X,'X:0,1:1) I RET<1 G OUT
 S $P(RET,U,2)=$P(X,U,7,8)
 S Y=$P(X,U,7) I Y D
 .S DAS=$$SPEC^DENTVRF0(Y) Q:'DAS
 .S X=$P($G(^DIC(220.4,DAS,0)),U) Q:X=""
 .S $P(RET,U,4)=DAS_U_X
 .Q
 G OUT
 ;
LIST(RET,VAL) ;  RPC: DENTV GET CODE LIST
 ;  return ada codes for Fileman lookup value (VAL)
 ;  See GETADA for description of each array element
 ;  on error, RET(1) = -1^message
 N I,J,X,Y,Z,DEN,DENTER,DENTL,DIERR,ROOT
 D GLBINT S RET=ROOT
 I $G(VAL)="" S @ROOT@(1)="-1^No lookup value sent" Q
 D FIND^DIC(228,,,"M",VAL,,,,,"DENTL","DENTER")
 S J=+$G(DENTL("DILIST",0))
 I 'J S @ROOT@(1)="-1^No entries found matching '"_VAL_"'" Q
 K DEN M DEN=DENTL("DILIST",1) K DENTL S DEN=0
 I $L(VAL)=5,VAL=+VAL D  Q  ;p43 97810 brings back all 9781* codes, messes up Progress Note
 .F  S DEN=$O(DEN(DEN)) Q:'DEN  I DEN(DEN)=VAL D C(DEN(DEN))
 .D GLBERR S RET=ROOT
 .Q
 F  S DEN=$O(DEN(DEN)) Q:'DEN  D C(DEN(DEN))
 D GLBERR S RET=ROOT
 Q
 ;
PROV(RET,IEN,FUN) ;  RPC: DENTV DENTAL PROVIDER
 ;  determine if provider is an active dental provider
 ;  IEN - required - pointer to 200
 ;  FUN - optional - I $G(FUN) then extrinsic function, else RPC
 ;  RETURN: provider's name (1st m last) if active
 ;          else return -1^message
 N X,Y,Z,DENTER,DIERR,NM
 S IEN=$G(IEN) I 'IEN S RET="-1^No provider ien received" G OUT
 S X=$O(^DENT(220.5,"B",IEN,0))
 I 'X S RET="-1^Not found in DENTAL PROVIDER file" G OUT
 S X=$G(^DENT(220.5,X,0)),Y=""
 I $P(X,U,4)="" S Y=" does not have an 8 digit dental provider Id;"
 I $P(X,U,3) S Y=Y_" not an active dental provider"
 I Y'="" S RET="-1^Provider"_Y G OUT
 S X=$$GET1^DIQ(200,IEN_",",20.2,,,"DENTER") ;  sig block printed name
 I '$D(DIERR),X'="" S RET=X G OUT
 K DIERR,ERR S NM=$$GET1^DIQ(200,IEN_",",.01,,,"DENTER")
 S X=$$NAMEFMT^XLFNAME(NM,,"DM")
 I '$D(DIERR) S RET=$S(X'="":X,1:NM)
 E  S RET="-1^Problems encountered retrieving data from file 200"
OUT Q:$G(FUN) RET Q
 ;
 ; -------------------  subroutines  --------------------
C(CPT) N X,CPTNM,DATA S X=$$GETADA(.DATA,CPT)
 I X>0 S CPTNM=$P(X,U,2) D GLBADD
 Q
 ;
GETADA(RETC,CPT,DATE) ;  set up sorted CPT data based upon cpt name
 ;  called as extrinsic function
 ;  CPT - required - pointer to CPT file (#81)
 ; DATE - optional - default to today 
 ; Return RETC(1) = $BEGIN <cpt code>
 ;        RETC(2) = p1^p2^...^p11  where
 ;                  p1 = cpt code           p8 = prim icd9 str
 ;                  p2 = cpt short desc     p9 = 221 field
 ;                  p3 = ctv               p10 = primary (y) 
 ;                  p4 = # surf            p11 = subcat 2
 ;                  p5 = tooth string (y)  P12 = flags
 ;                  p6 = quad (y)          P13 = RVU
 ;                  p7 = #canals           P14 = VA-DSS Product Line
 ;                                         P15 = Admin guideline
 ;        RETC(3-n) = ^ additional icd9 str ^...^ icd9 str5
 ;                  where icd9 str# = ien ~ code ~ short desc (up to 5 per line)
 ;        RETC(n) = cpt detailed description
 ;        RETC(n) = $END <cpt code>
 ;  Extrinsic function return 1^cpt code name if successful
 ;  On error, or problems return -1^error message
 ;
 N I,J,X,Y,Z,ADA,CPTNM,CPTSTR,FROM,ICD,SAVE,X0,X1,X2,IC,CNT
 I '$G(CPT) Q "-1^no cpt received"
 S DATE=$G(DATE) S:DATE="" DATE=DT
 S CPTSTR=$$CPT^DSICCPT(,CPT,DATE,,,1)
 I CPTSTR<0 Q "-1^invalid cpt "_CPT
 ;  check for inactive code
 I '$P(CPTSTR,U,7) Q "-1^cpt "_CPT_" is inactive"
 ;  get cpt ien, short description
 S CPT=+CPTSTR,CPTNM=$P(CPTSTR,U,2)
 I CPT<1 Q "-1^cpt "_CPTNM_" - problems encountered"
 S SAVE=CPTNM_U_$P(CPTSTR,U,3)
 S X=$O(^DENT(228,"B",CPT,0)) I 'X Q "-1^"_CPT_" not found in ADA table"
 S X0=^DENT(228,X,0),X1=$G(^(1)),X2=$P($G(^(2)),U)
 ;  map pieces from ^dent(228,x,0) to save
 S FROM="3^9^10^8^11^^4^13^7^17^18^16"
 F I=1:1:12 S J=$P(FROM,U,I) S:J $P(SAVE,U,I+2)=$P(X0,U,J)
 ;  if tooth related place tooth# string
 I $P(X0,U,10)="y",X2'="" S $P(SAVE,U,5)=X2
 K SAVEIC S IC=0,CNT=1 F  S IC=$O(^DENT(228,CPT,5,IC)) Q:'IC  D
 .S ICD=+$G(^DENT(228,CPT,5,IC,0)) Q:'ICD
 .N I,X0,X1,X2
 .S X=$$ICD9^DSICDRG(,ICD,,DATE,,1) Q:X'>0
 .I IC=1 S $P(SAVE,U,8)=$P(X,U)_"~"_$P(X,U,2)_"~"_$P(X,U,4) Q
 .S SAVEIC(CNT)=$G(SAVEIC(CNT))_$P(X,U)_"~"_$P(X,U,2)_"~"_$P(X,U,4)_U
 .I IC#5=0 S CNT=CNT+1
 .Q
 S RETC(1)="$BEGIN "_CPTNM
 S RETC(2)=SAVE_U_$G(^DENT(228,CPT,3))
 S I=0 F  S I=$O(SAVEIC(I)) Q:'I  S RETC(2+I)=U_SAVEIC(I)
 S CNT=$O(RETC(20),-1)
 S CNT=CNT+1,RETC(CNT)=$$CPTD^DSICCPT("",CPT,DATE,"",1)
 S CNT=CNT+1,RETC(CNT)="$END "_CPTNM
 Q "1^"_CPTNM
 ;
GLBADD M @ROOT@(CPTNM)=DATA Q
GLBERR S:'$D(@ROOT) @ROOT@(1)="-1^problem encountered retrieving ADA data" Q
GLBINT S ROOT=$NA(^TMP("DENTV",$J)) K @ROOT Q
