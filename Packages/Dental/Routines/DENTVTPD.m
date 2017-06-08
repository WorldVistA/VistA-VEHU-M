DENTVTPD ;DSS/SGM - FILE PCE DATA FOR TP ;12/11/2003 14:15
 ;;1.2;DENTAL;**39,47,50,53**;Aug 10, 2001;Build 10
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  this routine is invoked from DENTVTPA
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  -----------------------------------
 ;  1889  cont sub   $$DATA2PCE^PXAPI
 ;  2051      x      $$FIND1^DIC
 ; 10003      x      ^%DT
 ; 10048      x      Fileman read all fields in file 9.4
 ; 10103      x      $$NOW^XLFDT
 ;
 ; Definition of key loval variables
 ; DES(0) = zeroth node from file 228.1 record
 ;
FILE(DENA) ;  file pce data from treatment plan transactions
 ;  return DENA = 
 ;         1^Data successfully filed to PCE^<visit ien>
 ;         0 if no filing is needed
 ;        -1^error message
 ;    additional error messages in DENA(#)
 ;
 N I,X,Y,Z,DENTX,DENV,NOW,PCE,PKG,ROOT,SOURCE
 S ROOT=$NA(^TMP("DENT",$J,"PCE")) K @ROOT
 I '$G(DFN) S DENA=0 Q
 I $G(DES(0))="" S DENA="-1^Routine not invoked properly" Q
 S NOW=$E($$NOW^XLFDT,1,12)
 S DENTX("ENCOUNTER",1,"ENC D/T")=$$DATE
 S DENTX("ENCOUNTER",1,"PATIENT")=DFN
 S DENTX("ENCOUNTER",1,"HOS LOC")=$P(DES(0),U,11)
 S DENTX("ENCOUNTER",1,"CHECKOUT D/T")=NOW
 S DENTX("ENCOUNTER",1,"SERVICE CATEGORY")="A"
 S DENTX("ENCOUNTER",1,"ENCOUNTER TYPE")="P"
 D SC ;    sc conditions
 D PROV ;  provider info
 D CODE ;  cpt/icd9 codes
 D PKG ;   package/source
 I $G(DATA("VISIT")) S DENV=DATA("VISIT")
 ;  verify that there are procedures and diagnoses
 I '$D(DENTX("PROCEDURE"))  D ERR(4)
 I '$D(DENTX("DX/PL")) D ERR(5)
 Q:$D(DENA)
 S Y=$$DATA2PCE^PXAPI("DENTX",PKG,SOURCE,.DENV,PROV)
 I Y=1 S DENA="1^PCE data successfully filed, Visit#: "_DENV_U_DENV
 I Y=-1 D
 .S X="1^Some exceptions encountered while filing PCE data for visit#:"
 .S DENA=X_DENV_U_DENV
 .I $D(DENTX("DIERR")) D ERRP
 .Q
 I Y=-2 D ERR(2)
 I Y<-2 D ERR(3)
 I Y<1,$D(DENTX("DIERR")) S X=$$MSG^DSICFM01("VE",,,,"DENTX") D ERR(X)
 ;  if visit not in file 228.1, add it
 I DENV,'$P(DES(0),U,5) D
 .N DENER,DIERR
 .K DENTX S DENTX(228.1,DES_",",.05)=DENV
 .D FILE^DIE(,"DENTX","DENER")
 .D UPD(DES,DENV) ;P53 file visit date vs create date for new visits
 .Q
 Q
 ;
UPD(DES,DENV) ;update txns with visit date P53 2.27.07
 Q:'$G(DES)  Q:'$G(DENV)
 N VDT,TXN S VDT=$$GET1^DIQ(9000010,DENV,.01,"I") Q:'VDT
 S TXN=0 F  S TXN=$O(^DENT(228.2,"AG",DES,TXN)) Q:'TXN  D
 .K DENTX S DENTX(228.2,TXN_",",1.05)=VDT D FILE^DIE(,"DENTX")
 Q
 ;------------------------  subroutines  -------------------------
ERR(X) ;
 N A S A=1+$O(DENA("A"),-1)
 I A=1 S:$G(DENA)="" DENA="-1^PCE data not filed"
 I X=1 S X="No Dental package file entry found"
 I X=2 S X="Unable to identify a valid VISIT.  No data was processed"
 I X=3 S X="API was called incorrectly.  No data was processed."
 I X=4 S X="No valid procedures found for filing to PCE"
 I X=5 S X="No valid diagnosis codes found for filing to PCE"
 S:X'[U X=U_X S DENA(A)=X
 Q
 ;
ERRP ; loop through multiple error lines from PCE
 ;2.19.2004 ONLY for 'some exceptions', put text in piece 2
 N PCE,I
 D MSG^DSICFM01("AE",.PCE,,,"DENTX")
 F I=0:0 S I=$O(PCE(I)) Q:'I  D ERR(U_$TR(PCE(I),U,"~"))
 Q
CODE ;  set up procedure/diagnosis info
 ;  cpt(cpt ien) = subscript value
 ;  cpt(cpt ien,icd ien) = subscript value
 ;  icd(icd ien) = subscript value
 ; 
 N I,J,X,Y,Z,CPT,ICD,PATCH,PRIM,SUB
 S PATCH=$$PATCH^DENTVRH
 S PRIM=+$S(+PCE:PCE,1:$G(DATA("PCE-DIAG")))
 S SUB="T" F  S SUB=$O(DATA(SUB)) Q:SUB'?1"T"1N.N  S X=DATA(SUB) D
 .Q:$P(X,U)'="A"  Q:'$E($P(X,U,3),3)  ;  add + filing flag
 .S CPT=$P(X,U,5),ICD=$TR($P(X,U,29),";",U)
 .I CPT S I=$G(CPT(CPT)) D
 ..I 'I S I=1+$O(DENTX("PROCEDURE","A"),-1),CPT(CPT)=I D
 ...S DENTX("PROCEDURE",I,"PROCEDURE")=CPT
 ...S DENTX("PROCEDURE",I,"ENC PROVIDER")=PROV
 ...;  get cpt description
 ...S Y=$P(DATA(SUB),U,6) S:Y="" Y=$P($G(DENCPT(CPT)),U,2)
 ...S:Y'="" DENTX("PROCEDURE",I,"NARRATIVE")=Y
 ...Q
 ..S DENTX("PROCEDURE",I,"QTY")=1+$G(DENTX("PROCEDURE",I,"QTY"))
 ..F J=1:1:5 S Y=$P(ICD,U,J) I Y,'$D(CPT(CPT,Y)) D  ;P53 not filing all dxs to procedures
 ...S CPT(CPT,Y)="",X=$$DX() I X]"" S DENTX("PROCEDURE",I,X)=Y
 ...Q
 ..Q
 .S ICD=ICD_U_$G(DATA("PCE-DIAG"))
 .F J=1:1:6 S X=$P(ICD,U,J) I X,'$D(ICD(X)) D
 ..S I=1+$O(DENTX("DX/PL","A"),-1),ICD(X)=I
 ..S DENTX("DX/PL",I,"DIAGNOSIS")=X
 ..S DENTX("DX/PL",I,"PRIMARY")=PRIM=X
 ..S Y=$P(DENICD(X),U,2) S:Y'="" DENTX("DX/PL",I,"NARRATIVE")=Y
 ..S DENTX("DX/PL",I,"ENC PROVIDER")=PROV
 ..Q
 .Q
 Q
DX() ;P53 file ALL dxs to each procedure as entered by user
 S Z=$O(DENTX("PROCEDURE",I,"DIAGNOSIS 9"),-1)
 I Z="" Q "DIAGNOSIS"
 S Z=$E(Z,11),Z=$S(Z="":2,1:Z+1)
 I Z>8 Q ""
 Q "DIAGNOSIS "_Z
 ;
DATE() ;  get date for this encounter
 N %DT,I,X,Y,Z,DSI,DSIV
 S DSIV=$G(DATA("VISIT")),PCE=""
 ;  if no visit passed in, then see if DES record has VISIT
 I 'DSIV S DSIV=$P(DES(0),U,5)
 I DSIV D
 .D LOOK^DSICPX3(.DSI,DSIV_"^I") Q:+$G(DSI(1))=-1
 .S PCE=$$PCE^DSICPX2(,DSIV,1)
 .S X=0 F I=1:1 Q:'$D(DSI(I))  I +DSI(I)=.01 S DSIV=$P(DSI(I),U,3) Q
 .Q
 I 'DSIV D
 .S X=$G(DATA("DATE")) I X S %DT="TS" D ^%DT S:Y>0 DSIV=Y
 .I 'DSIV S DSIV=NOW
 .Q
 Q DSIV
 ;
PKG ;  check for valid dental package pointer for use with PCE
 S X=+$$FIND1^DIC(9.4,,"MOQ","DENT","B^C",,"DENXER")
 I X<1 D ERR(1) Q
 S PKG=X,SOURCE="DENTV DSS GUI"
 Q
 ;
PROV ;  set up provider information
 N I,X,Y,Z,PCEDUZ,DISTP ;DISTP is distributed provider P47
 I DES S DISTP=$$GET1^DIQ(228.1,DES,.08,"I")
 S PCEDUZ=$S($G(DISTP):DISTP,'$P(PCE,U,4):PROV,$P(PCE,U,4)'=PROV:$P(PCE,U,4),1:PROV)
 S DENTX("PROVIDER",1,"NAME")=PCEDUZ
 S DENTX("PROVIDER",1,"PRIMARY")=1
 S Y=1 I PCEDUZ'=PROV S Y=Y+1,DENTX("PROVIDER",Y,"NAME")=PROV
 S X=$TR($G(DATA("SEC")),";",U) I X'="" F I=1:1:$L(X,U) D
 .S Z=$P(X,U,I) I Z S Y=Y+1,DENTX("PROVIDER",Y,"NAME")=Z
 .Q
 Q
 ;
SC ;  QA sc conditions according to PCE business rules
 ;  expects DATA(condition)=value  10.20.06 P50 added SHAD
 F X="AO","EC","IR","SC","MST","HNC","CV","SHAD" D:$D(DATA(X))
 .S Z=DATA(X) I $S(Z="":1,Z'?1N:1,1:Z>1) K DATA(X)
 .Q
 I $G(DATA("SC")) F X="AO","EC","IR" K DATA(X) ;HNC removed from this kill
 F X="AO","EC","IR","SC","MST","HNC","CV","SHAD" S:$D(DATA(X)) DENTX("ENCOUNTER",1,X)=DATA(X)
 Q
