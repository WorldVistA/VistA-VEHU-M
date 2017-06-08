DENTVUTL ;DSS/SGM - COMMON CALLS FOR GUI ;07/22/2003 15:25
 ;;1.2;DENTAL;**30,33,34,36,31,43,45,47,53,55,59**;Aug 10, 2001;Build 19
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ;  this routine contains common subroutines called by more that one
 ;  DENTV* routine
 ;
 ;  DBIA#  Supported  description
 ;  -----  ---------  --------------------------------------
 ;  10048      x      FM read of all fields in file 9.4
 ;  2056       x      GETS^DIQ and $$GET1^DIQ
 ;  2053       x      FILE^DIE
 ;  2343       x      XUSER
 ;  1625       x      $$GET^XUA4A72
 ;  
 ;
DPRV(P) Q +$O(^DENT(220.5,"B",+$G(P),0))
 ;
PKG() N DIERR,DENERR Q +$$FIND1^DIC(9.4,,"MOQ","DENT","B^C",,"DENERR")
 ;
 ;
GS(RET,DFN,PSPROV) ;RPC: DENTV PRIMARY PROVIDER
 ; input:  DFN    = patient pointer to DENTAL PATIENT (#220) file
 ;         PSPROV = p1^p2+p3  Primary prov ien^sec prov ien (optional)^enc provider
 ;get/set the primary^secondary provider for a dental patient
 ;P53 set encounter provider (p3) if user is provider - this goes in banner too
 S DFN=$G(DFN),RET=U I 'DFN S RET="-1^Invalid Patient" Q
 S PSPROV=$G(PSPROV) I PSPROV]"" D SET Q
 N PID S PID=$$PROV1^DENTVA2(DUZ) I PID?1"X"8N D
 .S PID=+$E(PID,2,3)
 .I $S(PID<5:1,PID=7:1,PID>13:1,1:0) S $P(RET,U,3)=DUZ
 .Q
 N DEND,DENER D GETS^DIQ(220,DFN_",",".09;.1;.11;.12","IE","DEND","DENER") ;P55 3.5.08
 I $D(DENER) Q
 S $P(RET,U)=$P($G(^DENT(220.5,+$G(DEND(220,DFN_",",.09,"I")),0)),U)
 S $P(RET,U,2)=$P($G(^DENT(220.5,+$G(DEND(220,DFN_",",.1,"I")),0)),U)
 I $G(DEND(220,DFN_",",.11,"E"))]"" S $P(RET,U)="*Fee Basis" ;P55 3.5.08
 I $G(DEND(220,DFN_",",.12,"E"))]"" S $P(RET,U,2)="*Fee Basis" ;P55 3.5.08
 Q
 ;
SET ;set the primary/secondary provider in the DENTAL PATIENT file (#220)
 N DENT,IENS,DENER,PPROV,SPROV S IENS=DFN_","
 S PPROV=$P(PSPROV,U)
 I PPROV'=+PPROV S DENT(220,IENS,.11)=PPROV,PPROV="" ;P55 3.5.08 set Pri Prov='Fee Basis'
 E  S DENT(220,IENS,.11)=""
 I PPROV S PPROV=$$DPRV(PPROV) ;PPROV is a number (real provider in VistA db)
 S SPROV=$P(PSPROV,U,2)
 I SPROV'=+SPROV S DENT(220,IENS,.12)=SPROV,SPROV="" ;P55 3.5.08 set Sec Prov='Fee Basis'
 E  S DENT(220,IENS,.12)=""
 I SPROV S SPROV=$$DPRV(SPROV)
 S DENT(220,IENS,.09)=PPROV,DENT(220,IENS,.1)=SPROV
 L +^DENT(220,DFN):1 E  S RET="-1^Couldn't lock patient record" Q
 D FILE^DIE(,"DENT","DENER") L -^DENT(220,DFN)
 I $D(DENER) S RET="-1^Could not file providers" Q
 S RET=DFN_U_"Successful"
 Q
 ;
GAL(RET,DFN,DENAL) ;RPC: DENTV ALERTS
 ; input:  DFN    = patient pointer to DENTAL PATIENT (#220) file
 ;      DENAL(n)  = alert text
 ;get/set alerts for a dental patient
 ;also called by DENTVA7 for Recare Report P53
 S DFN=$G(DFN) I 'DFN S RET="-1^Invalid Patient" Q
 N X S X=$$DFN^DENTVRF0(DFN,1) I X<0 S RET="-1^Cannot add new Dental Patient" Q
 I $D(DENAL)>1 D SAL Q  ;ADD ALERTS
 N PIEN,P0,NODE S NODE=0
 F PIEN=0:0 S PIEN=$O(^DENT(220,DFN,12,PIEN)) Q:'PIEN  S P0=^(PIEN,0) D
 .S NODE=NODE+1,RET(NODE)=U_$P(P0,U)
 .Q
 I '$O(RET(0)) S RET(1)="-1^No ALERTS found for the patient"
 Q
 ;
SAL ;set the primary/secondary provider in the DENTAL PATIENT file (#220)
 L +^DENT(220,DFN):2 E  S RET(1)="-1^Unable to lock file 220 to add ALERTS" Q
 I $G(DENAL(1))="@" K ^DENT(220,DFN,12)
 E  D WP^DIE(220,DFN_",",60,,"DENAL","DENTERR")
 L -^DENT(228.2,DFN)
 I $D(DENTERR) S RET(1)="-1^"_$$MSG^DSICFM01("VE",,,,"DENTERR") K DENTERR Q
 S RET(1)=DFN_"^ALERTS filed"
 Q
 ;
PP(RET,DFN,FLAG) ; RPC: DENTV PATIENT PROVIDER
 ; DFN = patient DFN, FLAG = 0 for set index, 1 for kill existing xref
 ; returns 0^none if no other providers accessing patient (or 0^removed patient/provider index for kill)
 ;         1^provider names if other providers accessing patient
 ;   or
 ; returns -1^error if bad parameters
 S FLAG=$G(FLAG) I FLAG D KPT S RET="0^removed patient/provider index" Q
 S DFN=$G(DFN) I 'DFN S RET="-1^no patient parameter" Q
 ;^XTMP will be translated, with one copy for the entire VistA production system at each site.  
 ;The structure of each top node shall follow the format:
 ;^XTMP(namespaced- subscript,0)=purge date^create date^optional descriptive information, 
 ;      both dates will be in VA FileMan internal date format.
 ;
 I '$D(^XTMP("DENTVPT",0)) S ^XTMP("DENTVPT",0)=DT_U_DT_U_"Dental Provider/Patient INDEX"
 D KPT S RET=$$CPT(DFN)
 S ^XTMP("DENTVPT",DFN,DUZ)=$$GET1^DIQ(200,DUZ_",",.01)
 Q
KPT ;remove the current patient for this provider before setting another patient
 N DENTDFN,DENTDUZ S DENTDFN=0
 F  S DENTDFN=$O(^XTMP("DENTVPT",DENTDFN)) Q:'DENTDFN  S DENTDUZ=0 D
 .F  S DENTDUZ=$O(^XTMP("DENTVPT",DENTDFN,DENTDUZ)) Q:'DENTDUZ  I DENTDUZ=DUZ K ^XTMP("DENTVPT",DENTDFN,DENTDUZ)
 .Q
 Q
CPT(DFN) ;check who's accessing the patient
 I '$D(^XTMP("DENTVPT",DFN)) Q "0^none"
 N P,X S P=0,X=1
 F  S P=$O(^XTMP("DENTVPT",DFN,P)) Q:'P  I P'=DUZ S X=X_U_$G(^(P))
 Q X
 ;
LIST(DENT,VAL) ;  RPC: DENTV ACTIVE USER PROVIDER
 ;  This call is like DSIC ACTIVE USER LIST except it checks for XUORES (provider access)
 ;  return a list of active users only for a lookup value
 ;  VAL - required - lookup value
 ;  Return ^TMP("DENTVU",$J,"DILIST",#,0) = data
 ;   if problems return  -1^message
 ;   else return  p1^p2^p3^...^p8  where
 ;    p1 = ien                      p5 = first m last
 ;    p2 = name (.01 field)         p6 = initials
 ;    p3 = sig block printed name   p7 = title
 ;    p4 - sig block title          p8 = service   p9 = person class
 ;
 N I,X,Y,Z,DSI,DSICX,ERR,INPUT
 S DENT=$NA(^TMP("DENTVU",$J)) K @DENT
 I $G(VAL)="" S @DENT@(1)="-1^No lookup value received"
 S Z=0
 S INPUT(1)="FILE^200"
 S INPUT(2)="FIELDS^.01;20.2;20.3;1;8;29"
 S INPUT(3)="VAL^"_VAL
 S INPUT(4)="SCREEN^I $$ACT^DENTVUTL(,+Y)>0"
 D FIND^DSICFM05(.DENT,.INPUT)
 I $D(@DENT) S DSI=0 F  S DSI=$O(@DENT@(DSI)) Q:'DSI  D
 .S X=$G(@DENT@(DSI,0)) Q:+X'>0  S X=$P(X,U,2),X=$$NAMEFMT^XLFNAME(X)
 .S Y=@DENT@(DSI,0),Z=$P(Y,U,1,4),$P(Z,U,5)=X_U_$P(Y,U,5,7)
 .S Z=Z_U_$$VCODE^DENTVHLU(+Z,DT)
 .S @DENT@(DSI,0)=Z
 .Q
 I '$D(@DENT) S @DENT@(1)="-1^No matches found"
 Q
ACT(RET,XDUZ) ; 
 ;  validate that DUZ is an active user
 ;  XDUZ - required - pointer to the new person file
 ;  RETURN: user's DUZ value or -1^message
 N X,Y,Z,DSI,DSIX
 I $G(XDUZ)="" S RET="-1^No lookup value received" Q RET
 S X=$$ACTIVE^XUSER(XDUZ)
 I +X'=1 S Y=$$PROVIDER^XUSER(XDUZ) I +Y=0 S RET="-1^Invalid User" Q RET
 Q XDUZ
LOCK(F,I) ;  lock individual record in file=F, record=I
 L +^DENT(F,I):2 I $T Q 1
 D MSG(2,F),DIK
 Q -1
MSG(X,Y) ;  error messages
 ;;Try again, unable to lock file 
 ;;Try again, unable to lock newly created record in file 
 I +X=X S X=$P($T(MSG+X),";",3)_$G(Y)
 S Y=1+$O(RET("A"),-1),RET(Y)=X
 Q
DIK N DA,DD,DO,DIK
 S DA=I,DIK="^DENT("_F_"," I $D(^DENT(F,I)) D ^DIK
 Q
PROVINQ(RET,PROV,DENTDAT) ; RPC: DENTV PERSON CLASS INQUIRY
 ;Wrapper for $$GET^XUA4A72 to return person class information
 S PROV=$G(PROV) I 'PROV S RET="-1^No Provider DUZ sent." Q
 S RET=$$GET^XUA4A72(PROV,DENTDAT)
 I RET=-1,'$P(RET,U,2) S $P(RET,U,2)="Provider not found"
 Q
