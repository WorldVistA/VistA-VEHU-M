DENTVTP1 ;DSS/SGM - TP GET ADA TABLE, PROVIDERS ;11/10/2003 09:37
 ;;1.2;DENTAL;**39,45**;Aug 10, 2001
 ;Copyright 1995-2005, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  For Dental Treatment Planning software only
 ;  this routine is invoked from DENTVTP routine
 ;  it is not directly invokable
 ;
 ;  DBIA#  SUPPORTED
 ;  -----  ---------  ----------------------------------
 ;  10060      x      FM read of all fields in file 200
 ; 
ADA(DENT) ; RPC: DENTV TP GET ADA TABLE
 ;  return ^TMP("DENT",$J,cpt_code) = p1^p2^...^p10
 ;    p1 = cpt code          p8 = flags
 ;    p2 = cpt description   p9 = local code (boolean)
 ;    p3 = condition        p10 = quick code (boolean) 
 ;    p4 = area             
 ;    p5 = material         
 ;    p6 = diagnosis code   
 ;    p7 = diagnosis desc   
 ;           
 ;    boolean in treatment planning is -1 for true, 0 for false
 ;    flags =  10 character text containing 0 or more of the following:
    ;             Q=Quad related, T=Tooth related, Y=Primary, A=Arch
    ;             P=Prosthesis related, E=Endo, R=Ranged, a=Apico
    ;             r=Retro, H=Hemi, p=Partial, C=Crown
 ;    header records are also returned:
 ;       ^TMP("DENT",$J,cpt_header_code) = cpt code^cpt description
 N I,X,Y,Z,CPT,DEN0,DEN1,DENTX,IEN,VAL,FROM,TO,DENTQ,INC
 S DENT=$NA(^TMP("DENT",$J)),DENTX=$NA(^TMP("DENTX",$J))
 K @DENT,@DENTX
 ;  get user's quick list
 ;D GET^DENTVRP2($NA(^TMP("DENTX",$J,1)))
 ;S I=0 F  S I=$O(@DENTX@(1,I)) Q:'I  S X=^(I) D:X["$BEGIN"
 ;.S CPT=$P(X,"$BEGIN ",2),@DENTX@(2,CPT)=""
 ;.Q
 D GET^DSICXPR(.DENTQ,"USR~DENTV CPT QUICK LIST")
 ;  check for any inactive codes and delete them
 F INC=0:0 S INC=$O(DENTQ(INC)) Q:'INC  D
 .I '$$ACTCPT^DSICCPT(,+DENTQ(INC),DT,,1) K DENTQ(INC) Q
 .I '$D(^DENT(228,+DENTQ(INC))) K DENTQ(INC)
 .Q
 ;set dentx temp global with cpt codes
 F INC=0:0 S INC=$O(DENTQ(INC)) Q:'INC  D
 .S X=$P(DENTQ(INC),U,2) I X]"" S @DENTX@(2,X)=""
 ;  get header records for treatment plan
 F I=1:1 S X=$P($T(ADAH+I),";",3) Q:X=""  S @DENT@($P(X,U))=X
 F IEN=0:0 S IEN=$O(^DENT(228,IEN)) Q:'IEN  S DEN0=$G(^(IEN,0)),DEN1=$G(^(1)) D:DEN0]""
 .K CPT,VAL D CPT Q:'$D(CPT)
 .S Y=$$ICD9^DSICDRG(,+DEN1,,DT,,1)
 .;  get diagnosis code and description only if active
 .I Y>0 S $P(VAL,U,6)=$P(Y,U,2),$P(VAL,U,7)=$P(Y,U,4)
 .;  get condition, area, material
 .F I=11,12,13 S Y=$P(DEN1,U,I) I Y S $P(VAL,U,I-8)=$P($G(^DENT(228.3,Y,0)),U,3)
 .S $P(VAL,U,8)=$P(DEN0,U,17) ; get the flags
 .S $P(VAL,U,9)=$S($P(DEN0,U,15)="L":-1,1:0) ; get boolean flag for local code
 .S X=0 I $D(@DENTX@(2,CPT)) K ^(CPT) S X=-1 ; get boolean flag for quick list
 .S $P(VAL,U,10)=X
 .I $E(CPT)'="D" S CPT="M"_CPT ; force medical codes to sort after ADA codes
 .S @DENT@(CPT)=VAL
 .S @DENT@(CPT,1)="$$"_$E($$CPTD^DSICCPT(,$S($E(CPT)="M":$E(CPT,2,9),1:CPT),DT,,1),1,250)
 .Q
 ;  check to see if any quick codes left over
 S IEN=0 F  S IEN=$O(@DENTX@(2,IEN)) Q:'IEN  D
 .D CPT Q:'$D(VAL)  S:$E(CPT)'="D" CPT="M"_CPT
 .S $P(VAL,U,10)=-1,@DENT@(CPT)=VAL
 .Q
 K @DENTX
 I '$D(@DENT) S @DENT@(1)="-1^Unexpected problems encountered"
 Q
 ;
VADSS(DENT) ; RPC: DENTV TP GET VA-DSS PRODUCTS
 ;  return ^TMP("DENT",$J,ien) = p1^p2
 ;    p1 = VA-DSS product line ien    p2 = Code-Description
 N I,X,Y
 S DENT=$NA(^TMP("DENT",$J))     K @DENT
 F I=0:0 S I=$O(^DENT(228.42,I)) Q:'I  S X=$G(^DENT(228.42,I,0)) D
 .S @DENT@(I)=I_U_$P(X,U)_"-"_$P(X,U,3)
 .Q
 Q
 ;
PROV(DENT,DENTL) ;  RPC: DENTV TP GET PROVIDERS
 ;  get all the providers for a patient for a date range
 ;  DENTL - required - input array
 ;  DENTL("StartDate") - optional - start date in FM format
 ;                       default = 0
 ;  DENTL("EndDate")   - optional - end date in FM format
 ;                       default = today
 ;  DENTL("Patient")   - required - pointer to PATIENT file
 ;  RETURN:
 ;    if problems, return DENT(1) = -1^message
 ;    else return DENT(n) = DUZ^Initials^IsCurrent^Name
 ;         where n = 1,2,3,4,...
 ;               IsCurrent is Boolean (-1 is true, 0 is false)
 ;
 N I,X,Y,Z,DFN,EDT,LIST,NM,PROV,SDT
 S SDT=+$G(DENTL("StartDate"))
 S EDT=$G(DENTL("EndDate")) S:'EDT EDT=DT+.25
 S DFN=$G(DENTL("Patient"))
 I 'DFN S DENT(1)="-1^No patient DFN received" Q
 S X=$$GET^DSICDPT1(DFN) I X<0 S DENT(1)=X Q
 ;  ^dent(228.1,"ae",dfn,date,da)
 F Y=SDT-.000001:0 S Y=$O(^DENT(228.1,"AE",DFN,Y)) Q:Y>EDT!'Y  D
 .F Z=0:0 S Z=$O(^DENT(228.1,"AE",DFN,Y,Z)) Q:'Z  D
 ..S PROV=$P($G(^DENT(228.1,Z,0)),U,7) Q:'PROV  Q:$D(LIST(PROV))  D ACT
 ..Q
 .Q
 I '$D(LIST(DUZ)) S PROV=DUZ D ACT
 I '$D(DENT) S DENT(1)="-1^No providers found"
 Q
 ;-------------------------  subroutines  -------------------------
ACT ;  called from PROV above
 ;  set up return array of providers - expects PROV
 N X,ACT,X0
 S ACT=$$ACT^DSICDUZ(,PROV,,1),ACT=$S(ACT>0:-1,1:0)
 S X0=$G(^VA(200,PROV,0)),X=PROV_U_$P(X0,U,2)_U_ACT_U_$P(X0,U)
 S LIST(PROV)="",DENT($P(X0,U)_PROV)=X
 Q
 ;
CPT ;  called from ADA above expects IEN = cpt code or cpt ien
 ;  get cpt code and description only if active
 ;  set VAL and CPT
 N X S X=$$CPT^DSICCPT(,IEN,DT,,,1) K CPT,VAL
 I X>0,$P(X,U,7) S CPT=$P(X,U,2),$P(VAL,U,1,2)=CPT_U_$P(X,U,3)
 Q
 ;
ADAH ;  get ADA headers
 ;; D0100^DIAGNOSTIC
 ;; D1100^PREVENTIVE
 ;; D2100^RESTORATIVE
 ;; D3000^ENDODONTICS
 ;; D4200^PERIODONTICS
 ;; D5100^REMOVABLE
 ;; D5900^MAXILLOFACIAL PROSTH
 ;; D6000^IMPLANT SERVICES
 ;; D6200^FIXED PROSTHODONTICS
 ;; D7100^SURGERY
 ;; D8000^ORTHODONTICS
 ;; D9000^ADJUNCTIVE
